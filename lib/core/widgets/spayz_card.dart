import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Card elevation style — controls background + optional glow.
enum SpayzCardStyle {
  /// Standard card — slightly elevated background, subtle shadow.
  standard,

  /// Elevated card — higher surface, stronger shadow.
  elevated,

  /// Glass card — semi-transparent with gradient edge glow.
  glass,

  /// Branded card — brand-gradient border + inner glow.
  branded,
}

/// Spayz design-system card container.
///
/// Wraps content in the correct surface, border-radius, shadow, and optional
/// gradient border/glow for the Spayz premium dark aesthetic.
///
/// Usage:
/// ```dart
/// SpayzCard(
///   child: Text('Hello'),
/// )
/// SpayzCard(
///   style: SpayzCardStyle.branded,
///   glowColor: SpayzColors.brandPrimary,
///   child: TransactionContent(),
/// )
/// ```
class SpayzCard extends StatelessWidget {
  const SpayzCard({
    super.key,
    required this.child,
    this.style = SpayzCardStyle.standard,
    this.padding,
    this.margin,
    this.glowColor,
    this.onTap,
    this.borderRadius,
    this.height,
    this.width,
  });

  final Widget child;
  final SpayzCardStyle style;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? glowColor;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? SpayzRadius.cardRadius;
    final effectivePadding = padding ?? SpayzSpacing.cardInsets;

    Widget card = _buildCard(radius, effectivePadding);

    if (onTap != null) {
      card = Material(
        color: Colors.transparent,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          splashColor: SpayzColors.brandPrimary.withAlpha(20),
          highlightColor: SpayzColors.brandPrimary.withAlpha(10),
          child: card,
        ),
      );
    }

    if (margin != null) {
      card = Padding(padding: margin!, child: card);
    }

    return card;
  }

  Widget _buildCard(BorderRadius radius, EdgeInsetsGeometry effectivePadding) {
    switch (style) {
      case SpayzCardStyle.standard:
        return _StandardCard(
          radius: radius,
          padding: effectivePadding,
          height: height,
          width: width,
          child: child,
        );

      case SpayzCardStyle.elevated:
        return _ElevatedCard(
          radius: radius,
          padding: effectivePadding,
          height: height,
          width: width,
          child: child,
        );

      case SpayzCardStyle.glass:
        return _GlassCard(
          radius: radius,
          padding: effectivePadding,
          glowColor: glowColor ?? SpayzColors.brandPrimary,
          height: height,
          width: width,
          child: child,
        );

      case SpayzCardStyle.branded:
        return _BrandedCard(
          radius: radius,
          padding: effectivePadding,
          glowColor: glowColor ?? SpayzColors.brandPrimary,
          height: height,
          width: width,
          child: child,
        );
    }
  }
}

// ─── Variant implementations ─────────────────────────────────────────────────

class _StandardCard extends StatelessWidget {
  const _StandardCard({
    required this.radius,
    required this.padding,
    required this.child,
    this.height,
    this.width,
  });

  final BorderRadius radius;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: SpayzColors.bgCard,
        borderRadius: radius,
        boxShadow: SpayzElevation.card,
        border: Border.all(color: SpayzColors.borderSubtle, width: 0.5),
      ),
      padding: padding,
      child: child,
    );
  }
}

class _ElevatedCard extends StatelessWidget {
  const _ElevatedCard({
    required this.radius,
    required this.padding,
    required this.child,
    this.height,
    this.width,
  });

  final BorderRadius radius;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: SpayzColors.bgElevated,
        borderRadius: radius,
        boxShadow: SpayzElevation.floating,
        border: Border.all(color: SpayzColors.borderDefault, width: 0.5),
      ),
      padding: padding,
      child: child,
    );
  }
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({
    required this.radius,
    required this.padding,
    required this.glowColor,
    required this.child,
    this.height,
    this.width,
  });

  final BorderRadius radius;
  final EdgeInsetsGeometry padding;
  final Color glowColor;
  final Widget child;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: SpayzColors.cardGlowGradient(glowColor),
        borderRadius: radius,
        border: Border.all(
          color: glowColor.withAlpha(50),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: glowColor.withAlpha(30),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: padding,
      child: child,
    );
  }
}

class _BrandedCard extends StatelessWidget {
  const _BrandedCard({
    required this.radius,
    required this.padding,
    required this.glowColor,
    required this.child,
    this.height,
    this.width,
  });

  final BorderRadius radius;
  final EdgeInsetsGeometry padding;
  final Color glowColor;
  final Widget child;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    // 1.5px gradient border via nested containers
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: SpayzColors.primaryGradient,
        borderRadius: radius,
        boxShadow: SpayzElevation.primaryGlow(glowColor),
      ),
      padding: const EdgeInsets.all(1.5),
      child: Container(
        decoration: BoxDecoration(
          color: SpayzColors.bgCard,
          borderRadius: radius.subtract(const BorderRadius.all(Radius.circular(1.5))),
        ),
        padding: padding,
        child: child,
      ),
    );
  }
}
