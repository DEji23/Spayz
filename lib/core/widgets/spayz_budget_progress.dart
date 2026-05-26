import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// How far through a budget the user is — drives colour coding.
enum BudgetStatus { safe, caution, danger, over }

/// Spayz budget progress bar.
///
/// Shows a category name, spent/limit amounts, and an animated progress bar.
/// Color automatically shifts from emerald → gold → coral as the budget fills,
/// matching YNAB's intentional color coding and Cleo's warning system.
///
/// Optionally shows a coin-reward hint when the user is tracking well.
class SpayzBudgetProgress extends StatelessWidget {
  const SpayzBudgetProgress({
    super.key,
    required this.category,
    required this.spent,
    required this.limit,
    this.categoryIcon,
    this.categoryColor,
    this.coinsAvailable,
    this.onTap,
    this.compact = false,
  });

  /// Category label, e.g. "Food & Groceries".
  final String category;

  /// Amount spent in this period (NGN kobo or naira — caller's choice of unit,
  /// just be consistent with [limit]).
  final double spent;

  /// Budget cap for the period.
  final double limit;

  final IconData? categoryIcon;
  final Color? categoryColor;

  /// If set, shows a "earn N coins by staying in budget" hint.
  final int? coinsAvailable;

  final VoidCallback? onTap;

  /// Compact removes the amounts and uses a thinner bar — for list use.
  final bool compact;

  double get _ratio => limit <= 0 ? 0 : (spent / limit).clamp(0.0, 1.0);

  BudgetStatus get _status {
    final r = _ratio;
    if (r >= 1.0) return BudgetStatus.over;
    if (r >= 0.85) return BudgetStatus.danger;
    if (r >= 0.65) return BudgetStatus.caution;
    return BudgetStatus.safe;
  }

  Color get _barColor => switch (_status) {
        BudgetStatus.safe => SpayzColors.stateSuccess,
        BudgetStatus.caution => SpayzColors.stateWarning,
        BudgetStatus.danger => SpayzColors.stateError,
        BudgetStatus.over => SpayzColors.coral700,
      };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: compact ? _buildCompact() : _buildFull(),
    );
  }

  Widget _buildFull() {
    final remaining = (limit - spent).clamp(0, double.infinity);
    final isOver = _status == BudgetStatus.over;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row
        Row(
          children: [
            if (categoryIcon != null) ...[
              Icon(
                categoryIcon,
                size: 16,
                color: categoryColor ?? SpayzColors.textSecondary,
              ),
              const SizedBox(width: SpayzSpacing.xs),
            ],
            Expanded(
              child: Text(
                category,
                style: SpayzTypography.bodyMMedium
                    .copyWith(color: SpayzColors.textPrimary),
              ),
            ),
            _StatusChip(status: _status, ratio: _ratio),
          ],
        ),
        const SizedBox(height: SpayzSpacing.sm),

        // Amounts
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '₦${_fmt(spent)} spent',
              style: SpayzTypography.nairaS
                  .copyWith(color: SpayzColors.textSecondary),
            ),
            Text(
              isOver
                  ? '₦${_fmt(spent - limit)} over'
                  : '₦${_fmt(remaining)} left',
              style: SpayzTypography.nairaS.copyWith(color: _barColor),
            ),
          ],
        ),
        const SizedBox(height: SpayzSpacing.sm),

        // Bar
        _AnimatedBar(ratio: _ratio, color: _barColor, height: 8),

        // Coin hint
        if (coinsAvailable != null && _status == BudgetStatus.safe) ...[
          const SizedBox(height: SpayzSpacing.sm),
          _CoinHint(coins: coinsAvailable!),
        ],
      ],
    );
  }

  Widget _buildCompact() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category,
                style: SpayzTypography.bodyM
                    .copyWith(color: SpayzColors.textPrimary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              _AnimatedBar(ratio: _ratio, color: _barColor, height: 5),
            ],
          ),
        ),
        const SizedBox(width: SpayzSpacing.md),
        Text(
          '${(_ratio * 100).toStringAsFixed(0)}%',
          style: SpayzTypography.captionMedium.copyWith(color: _barColor),
        ),
      ],
    );
  }

  static String _fmt(num v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000) return '${(v / 1000).toStringAsFixed(0)}K';
    return v.toStringAsFixed(0);
  }
}

// ─── Sub-widgets ──────────────────────────────────────────────────────────────

class _AnimatedBar extends StatelessWidget {
  const _AnimatedBar({
    required this.ratio,
    required this.color,
    required this.height,
  });

  final double ratio;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: ratio),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        builder: (context, value, _) {
          return Stack(
            children: [
              Container(
                height: height,
                width: double.infinity,
                color: SpayzColors.bgInput,
              ),
              FractionallySizedBox(
                widthFactor: value,
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color.withAlpha(180), color],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status, required this.ratio});

  final BudgetStatus status;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      BudgetStatus.safe => ('On track', SpayzColors.stateSuccess),
      BudgetStatus.caution => ('Caution', SpayzColors.stateWarning),
      BudgetStatus.danger => ('Nearly over', SpayzColors.stateError),
      BudgetStatus.over => ('Over budget', SpayzColors.coral700),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: SpayzRadius.chipRadius,
      ),
      child: Text(
        label,
        style: SpayzTypography.overline.copyWith(color: color, fontSize: 10),
      ),
    );
  }
}

class _CoinHint extends StatelessWidget {
  const _CoinHint({required this.coins});

  final int coins;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(
            gradient: SpayzColors.coinGradient,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          'Earn $coins coins by month end',
          style: SpayzTypography.caption
              .copyWith(color: SpayzColors.coinPrimary),
        ),
      ],
    );
  }
}
