import 'package:flutter/material.dart';

/// Spayz typography tokens.
///
/// Uses Plus Jakarta Sans — a modern geometric grotesque that reads well
/// at small sizes on OLED screens and has strong numeral clarity for
/// finance figures.
abstract final class SpayzTypography {
  static const String _family = 'PlusJakartaSans';

  // ─── Scale ─────────────────────────────────────────────────────────────────
  // Named after their role, not pixel size, for semantic clarity.

  /// Hero numbers — balance, large amounts. 40/48sp ExtraBold.
  static const display = TextStyle(
    fontFamily: _family,
    fontSize: 40,
    height: 1.1,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.5,
  );

  /// Section hero — screen titles. 32/40sp ExtraBold.
  static const headingXL = TextStyle(
    fontFamily: _family,
    fontSize: 32,
    height: 1.15,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.8,
  );

  /// Screen headline. 24/32sp Bold.
  static const headingL = TextStyle(
    fontFamily: _family,
    fontSize: 24,
    height: 1.25,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
  );

  /// Card headline / modal title. 20/28sp Bold.
  static const headingM = TextStyle(
    fontFamily: _family,
    fontSize: 20,
    height: 1.3,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
  );

  /// Section header / row title. 18/24sp SemiBold.
  static const headingS = TextStyle(
    fontFamily: _family,
    fontSize: 18,
    height: 1.35,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
  );

  /// Body text — primary content. 16/24sp Regular.
  static const bodyL = TextStyle(
    fontFamily: _family,
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  /// Body text medium emphasis. 16/24sp Medium.
  static const bodyLMedium = TextStyle(
    fontFamily: _family,
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );

  /// Secondary body / list rows. 14/20sp Regular.
  static const bodyM = TextStyle(
    fontFamily: _family,
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
  );

  /// Secondary body medium. 14/20sp Medium.
  static const bodyMMedium = TextStyle(
    fontFamily: _family,
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  /// Caption / metadata / timestamps. 12/16sp Regular.
  static const caption = TextStyle(
    fontFamily: _family,
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.3,
  );

  /// Caption medium. 12/16sp Medium.
  static const captionMedium = TextStyle(
    fontFamily: _family,
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
  );

  /// Overline / label. 11/16sp SemiBold uppercase.
  static const overline = TextStyle(
    fontFamily: _family,
    fontSize: 11,
    height: 1.45,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
  );

  /// Button label — large. 16/24sp SemiBold.
  static const buttonL = TextStyle(
    fontFamily: _family,
    fontSize: 16,
    height: 1.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  /// Button label — medium. 14/20sp SemiBold.
  static const buttonM = TextStyle(
    fontFamily: _family,
    fontSize: 14,
    height: 1.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  /// Numeric — naira amounts. 24sp Bold, tabular figures.
  static const nairaL = TextStyle(
    fontFamily: _family,
    fontSize: 24,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Numeric — inline amounts. 16sp SemiBold, tabular figures.
  static const nairaM = TextStyle(
    fontFamily: _family,
    fontSize: 16,
    height: 1.3,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Numeric — small amounts / captions. 13sp Medium.
  static const nairaS = TextStyle(
    fontFamily: _family,
    fontSize: 13,
    height: 1.3,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Builds a Material 3 [TextTheme] from the Spayz scale.
  static TextTheme get materialTextTheme => const TextTheme(
        displayLarge: display,
        displayMedium: headingXL,
        displaySmall: headingL,
        headlineLarge: headingL,
        headlineMedium: headingM,
        headlineSmall: headingS,
        titleLarge: headingS,
        titleMedium: bodyLMedium,
        titleSmall: bodyMMedium,
        bodyLarge: bodyL,
        bodyMedium: bodyM,
        bodySmall: caption,
        labelLarge: buttonL,
        labelMedium: buttonM,
        labelSmall: captionMedium,
      );
}
