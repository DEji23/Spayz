import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Display size for [SpayzCoinBadge].
enum CoinBadgeSize { small, medium, large }

/// Spayz Coins badge — the behavioral reward display unit.
///
/// Renders a gold gradient coin icon + count in a tinted pill.
/// Sizes: small (chip-level), medium (list row), large (hero balance).
///
/// Use [SpayzCoinBadge.hero] for the full balance card on the home screen.
class SpayzCoinBadge extends StatelessWidget {
  const SpayzCoinBadge({
    super.key,
    required this.coins,
    this.size = CoinBadgeSize.medium,
    this.showLabel = false,
    this.onTap,
  });

  /// Constructor for the home screen hero balance display.
  const SpayzCoinBadge.hero({
    super.key,
    required this.coins,
    this.onTap,
  })  : size = CoinBadgeSize.large,
        showLabel = true;

  final int coins;
  final CoinBadgeSize size;

  /// Show "Spayz Coins" label below (large) or inline (medium+).
  final bool showLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return switch (size) {
      CoinBadgeSize.small => _SmallBadge(coins: coins, onTap: onTap),
      CoinBadgeSize.medium => _MediumBadge(
          coins: coins, showLabel: showLabel, onTap: onTap),
      CoinBadgeSize.large => _LargeBadge(
          coins: coins, showLabel: showLabel, onTap: onTap),
    };
  }
}

// ─── Small ────────────────────────────────────────────────────────────────────
// Used on transaction tiles, chips, compact rows.

class _SmallBadge extends StatelessWidget {
  const _SmallBadge({required this.coins, this.onTap});

  final int coins;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: SpayzColors.coinSurface,
          borderRadius: SpayzRadius.chipRadius,
          border: Border.all(color: SpayzColors.gold500.withAlpha(60)),
          boxShadow: SpayzElevation.coinGlow,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CoinDot(size: 10),
            const SizedBox(width: 4),
            Text(
              '$coins',
              style: SpayzTypography.captionMedium
                  .copyWith(color: SpayzColors.coinPrimary),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Medium ───────────────────────────────────────────────────────────────────
// Default — nav bar, card headers.

class _MediumBadge extends StatelessWidget {
  const _MediumBadge({
    required this.coins,
    required this.showLabel,
    this.onTap,
  });

  final int coins;
  final bool showLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: SpayzSpacing.md,
          vertical: SpayzSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: SpayzColors.coinSurface,
          borderRadius: SpayzRadius.chipRadius,
          border: Border.all(color: SpayzColors.gold500.withAlpha(70)),
          boxShadow: SpayzElevation.coinGlow,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CoinDot(size: 16),
            const SizedBox(width: SpayzSpacing.xs),
            Text(
              _formatCoins(coins),
              style: SpayzTypography.bodyMMedium
                  .copyWith(color: SpayzColors.coinPrimary),
            ),
            if (showLabel) ...[
              const SizedBox(width: 4),
              Text(
                'coins',
                style: SpayzTypography.bodyM
                    .copyWith(color: SpayzColors.gold300),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Large / Hero ─────────────────────────────────────────────────────────────
// Home screen balance card.

class _LargeBadge extends StatelessWidget {
  const _LargeBadge({
    required this.coins,
    required this.showLabel,
    this.onTap,
  });

  final int coins;
  final bool showLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(SpayzSpacing.base),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              SpayzColors.gold500.withAlpha(20),
              SpayzColors.gold700.withAlpha(15),
            ],
          ),
          borderRadius: SpayzRadius.cardRadius,
          border: Border.all(color: SpayzColors.gold500.withAlpha(80)),
          boxShadow: SpayzElevation.coinGlow,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CoinDot(size: 36),
            const SizedBox(width: SpayzSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatCoins(coins),
                  style: SpayzTypography.headingL
                      .copyWith(color: SpayzColors.coinPrimary),
                ),
                if (showLabel)
                  Text(
                    'Spayz Coins',
                    style: SpayzTypography.caption
                        .copyWith(color: SpayzColors.gold300),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Shared helpers ───────────────────────────────────────────────────────────

class _CoinDot extends StatelessWidget {
  const _CoinDot({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        gradient: SpayzColors.coinGradient,
        shape: BoxShape.circle,
      ),
      child: size >= 24
          ? Icon(
              Icons.monetization_on_rounded,
              size: size * 0.65,
              color: SpayzColors.textInverse,
            )
          : null,
    );
  }
}

String _formatCoins(int coins) {
  if (coins >= 1000000) return '${(coins / 1000000).toStringAsFixed(1)}M';
  if (coins >= 1000) return '${(coins / 1000).toStringAsFixed(1)}K';
  return coins.toString();
}
