import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Direction of the transaction from the user's perspective.
enum TxDirection { credit, debit }

/// Spayz transaction list tile.
///
/// Matches the Monzo/PiggyVest pattern: category icon in a tinted circle,
/// merchant name + sub-label on the left, naira amount (red/green) + time on
/// the right. Supports a pending state and a Spayz Coins reward badge.
class SpayzTransactionTile extends StatelessWidget {
  const SpayzTransactionTile({
    super.key,
    required this.merchant,
    required this.amount,
    required this.direction,
    required this.category,
    required this.categoryIcon,
    this.categoryColor,
    this.timestamp,
    this.subLabel,
    this.isPending = false,
    this.coinsEarned,
    this.onTap,
    this.showDivider = true,
  });

  final String merchant;

  /// Pre-formatted string, e.g. "₦12,500.00".
  final String amount;

  final TxDirection direction;

  /// Category name, e.g. "Food & Drink".
  final String category;
  final IconData categoryIcon;

  /// Tint colour for the category icon circle. Defaults to brand primary.
  final Color? categoryColor;

  /// Formatted time/date string, e.g. "2:45 PM" or "Yesterday".
  final String? timestamp;

  /// Secondary line — account name, bank, or note.
  final String? subLabel;

  final bool isPending;

  /// Non-null means this transaction earned Spayz Coins. Shows a badge.
  final int? coinsEarned;

  final VoidCallback? onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final iconColor = categoryColor ?? SpayzColors.brandPrimary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: SpayzColors.brandPrimary.withAlpha(12),
            highlightColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SpayzSpacing.base,
                vertical: SpayzSpacing.md,
              ),
              child: Row(
                children: [
                  _CategoryIcon(icon: categoryIcon, color: iconColor),
                  const SizedBox(width: SpayzSpacing.md),
                  Expanded(child: _LeftColumn(this)),
                  const SizedBox(width: SpayzSpacing.sm),
                  _RightColumn(this),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          const Divider(
            indent: SpayzSpacing.base + 44 + SpayzSpacing.md,
            endIndent: 0,
            height: 1,
          ),
      ],
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        shape: BoxShape.circle,
        border: Border.all(color: color.withAlpha(40), width: 0.5),
      ),
      child: Icon(icon, size: 20, color: color),
    );
  }
}

class _LeftColumn extends StatelessWidget {
  const _LeftColumn(this.tile);

  final SpayzTransactionTile tile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                tile.merchant,
                style: SpayzTypography.bodyMMedium
                    .copyWith(color: SpayzColors.textPrimary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (tile.isPending) ...[
              const SizedBox(width: SpayzSpacing.xs),
              _PendingBadge(),
            ],
          ],
        ),
        const SizedBox(height: 2),
        Text(
          tile.subLabel ?? tile.category,
          style: SpayzTypography.caption
              .copyWith(color: SpayzColors.textSecondary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (tile.coinsEarned != null) ...[
          const SizedBox(height: 4),
          _CoinRewardLine(coins: tile.coinsEarned!),
        ],
      ],
    );
  }
}

class _RightColumn extends StatelessWidget {
  const _RightColumn(this.tile);

  final SpayzTransactionTile tile;

  @override
  Widget build(BuildContext context) {
    final isCredit = tile.direction == TxDirection.credit;
    final amountColor =
        isCredit ? SpayzColors.txCredit : SpayzColors.txDebit;
    final sign = isCredit ? '+' : '-';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$sign${tile.amount}',
          style: SpayzTypography.nairaM.copyWith(color: amountColor),
        ),
        if (tile.timestamp != null) ...[
          const SizedBox(height: 2),
          Text(
            tile.timestamp!,
            style: SpayzTypography.caption
                .copyWith(color: SpayzColors.textSecondary),
          ),
        ],
      ],
    );
  }
}

class _PendingBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: SpayzColors.gold500.withAlpha(30),
        borderRadius: SpayzRadius.chipRadius,
        border: Border.all(color: SpayzColors.gold500.withAlpha(80)),
      ),
      child: Text(
        'Pending',
        style: SpayzTypography.overline.copyWith(
          color: SpayzColors.gold500,
          fontSize: 9,
        ),
      ),
    );
  }
}

class _CoinRewardLine extends StatelessWidget {
  const _CoinRewardLine({required this.coins});

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
          '+$coins coins',
          style: SpayzTypography.caption.copyWith(
            color: SpayzColors.coinPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
