import 'package:flutter/material.dart';

/// Spayz spacing & layout tokens.
///
/// 4-point grid. Named by scale, not px value, so you think in "spacingM"
/// rather than "16" — easier to keep consistent across the codebase.
abstract final class SpayzSpacing {
  // ─── Base unit ─────────────────────────────────────────────────────────────
  static const double _unit = 4;

  // ─── Scale ─────────────────────────────────────────────────────────────────
  static const double xs = _unit * 1; // 4
  static const double sm = _unit * 2; // 8
  static const double md = _unit * 3; // 12
  static const double base = _unit * 4; // 16  ← default padding
  static const double lg = _unit * 5; // 20
  static const double xl = _unit * 6; // 24
  static const double xl2 = _unit * 8; // 32
  static const double xl3 = _unit * 10; // 40
  static const double xl4 = _unit * 12; // 48
  static const double xl5 = _unit * 16; // 64

  // ─── Semantic shortcuts ────────────────────────────────────────────────────
  static const double pagePadding = base; // 16 — horizontal page inset
  static const double cardPadding = xl; // 24 — card internal padding
  static const double sectionGap = xl2; // 32 — gap between page sections
  static const double itemGap = md; // 12 — gap between list items
  static const double inlineGap = sm; // 8 — inline element gap (icon+label)
  static const double chipGap = sm; // 8 — gap between chips

  // ─── EdgeInsets helpers ────────────────────────────────────────────────────
  static const EdgeInsets pageInsets =
      EdgeInsets.symmetric(horizontal: pagePadding);
  static const EdgeInsets cardInsets =
      EdgeInsets.all(cardPadding);
  static const EdgeInsets cardInsetsH =
      EdgeInsets.symmetric(horizontal: cardPadding, vertical: base);
}

/// Spayz border radius tokens.
abstract final class SpayzRadius {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double base = 16; // ← cards, buttons
  static const double lg = 20;
  static const double xl = 24;
  static const double pill = 100; // fully rounded

  static const BorderRadius cardRadius =
      BorderRadius.all(Radius.circular(base));
  static const BorderRadius buttonRadius =
      BorderRadius.all(Radius.circular(base));
  static const BorderRadius inputRadius =
      BorderRadius.all(Radius.circular(md));
  static const BorderRadius chipRadius =
      BorderRadius.all(Radius.circular(pill));
  static const BorderRadius sheetRadius = BorderRadius.vertical(
    top: Radius.circular(xl),
  );
}

/// Spayz elevation / shadow tokens.
abstract final class SpayzElevation {
  /// Subtle card lift — 1dp equivalent in dark theme.
  static List<BoxShadow> get card => [
        BoxShadow(
          color: const Color(0xFF000000).withAlpha(60),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];

  /// Floating panel / bottom sheet.
  static List<BoxShadow> get floating => [
        BoxShadow(
          color: const Color(0xFF000000).withAlpha(100),
          blurRadius: 40,
          offset: const Offset(0, -8),
        ),
      ];

  /// Brand glow for primary CTAs.
  static List<BoxShadow> primaryGlow(Color color) => [
        BoxShadow(
          color: color.withAlpha(80),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  /// Coin glow for reward elements.
  static List<BoxShadow> get coinGlow => [
        BoxShadow(
          color: const Color(0xFFFFB800).withAlpha(100),
          blurRadius: 20,
          spreadRadius: -2,
          offset: const Offset(0, 4),
        ),
      ];
}
