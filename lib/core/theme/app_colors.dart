import 'package:flutter/material.dart';

/// Spayz design token — color primitives and semantic aliases.
///
/// Dark-first palette inspired by Cleo's deep UI, PiggyVest's trust-green,
/// Monzo's clean card language, and Duolingo's reward-gold energy.
abstract final class SpayzColors {
  // ─── Primitives ────────────────────────────────────────────────────────────

  // Ink (backgrounds)
  static const ink900 = Color(0xFF08080E); // page bg
  static const ink800 = Color(0xFF10101A); // default surface
  static const ink700 = Color(0xFF171724); // card
  static const ink600 = Color(0xFF1F1F30); // elevated card
  static const ink500 = Color(0xFF2A2A3E); // input bg / divider
  static const ink400 = Color(0xFF393952); // border
  static const ink300 = Color(0xFF5A5A78); // muted icon
  static const ink200 = Color(0xFF8A8AA8); // secondary text
  static const ink100 = Color(0xFFBBBBD0); // tertiary text
  static const ink000 = Color(0xFFFFFFFF); // primary text

  // Violet (brand primary)
  static const violet900 = Color(0xFF2B0F7A);
  static const violet800 = Color(0xFF3D1FA8);
  static const violet700 = Color(0xFF5533CC);
  static const violet600 = Color(0xFF6B47F0);
  static const violet500 = Color(0xFF7C5CFC); // PRIMARY
  static const violet400 = Color(0xFF9A7EFF);
  static const violet300 = Color(0xFFB8A3FF);
  static const violet200 = Color(0xFFD6CBFF);
  static const violet100 = Color(0xFFEDE8FF);

  // Emerald (income / savings / success)
  static const emerald700 = Color(0xFF007A5C);
  static const emerald600 = Color(0xFF00A87C);
  static const emerald500 = Color(0xFF00C896); // SUCCESS
  static const emerald400 = Color(0xFF2DDEAC);
  static const emerald300 = Color(0xFF80EDCE);
  static const emerald100 = Color(0xFFD6FBF2);

  // Gold (Spayz Coins)
  static const gold700 = Color(0xFF8B5E00);
  static const gold600 = Color(0xFFCC8A00);
  static const gold500 = Color(0xFFFFB800); // COIN
  static const gold400 = Color(0xFFFFCA3D);
  static const gold300 = Color(0xFFFFDC80);
  static const gold100 = Color(0xFFFFF6D6);

  // Coral (spending / danger / debit)
  static const coral700 = Color(0xFF8B1A1A);
  static const coral600 = Color(0xFFCC2E2E);
  static const coral500 = Color(0xFFFF4D4D); // DANGER
  static const coral400 = Color(0xFFFF7A7A);
  static const coral300 = Color(0xFFFFADAD);
  static const coral100 = Color(0xFFFFEBEB);

  // Sky (info / links)
  static const sky500 = Color(0xFF3B9EFF);
  static const sky300 = Color(0xFF90C7FF);
  static const sky100 = Color(0xFFDCEEFF);

  // ─── Semantic aliases ──────────────────────────────────────────────────────

  // Backgrounds
  static const bgPage = ink900;
  static const bgSurface = ink800;
  static const bgCard = ink700;
  static const bgElevated = ink600;
  static const bgInput = ink500;
  static const bgOverlay = Color(0xCC08080E); // 80% ink900

  // Borders & dividers
  static const borderDefault = ink400;
  static const borderSubtle = ink500;
  static const borderFocus = violet500;

  // Text
  static const textPrimary = ink000;
  static const textSecondary = ink200;
  static const textTertiary = ink100;
  static const textDisabled = ink300;
  static const textInverse = ink900;

  // Brand
  static const brandPrimary = violet500;
  static const brandSecondary = emerald500;

  // States
  static const stateSuccess = emerald500;
  static const stateError = coral500;
  static const stateWarning = gold500;
  static const stateInfo = sky500;

  // Transaction-specific
  static const txCredit = emerald400;
  static const txDebit = coral400;

  // Coin
  static const coinPrimary = gold500;
  static const coinSurface = Color(0xFF241900); // very dark gold tint

  // Gradient stops
  static const gradientVioletStart = violet600;
  static const gradientVioletEnd = Color(0xFFAA5CFC);

  static const gradientEmeraldStart = emerald600;
  static const gradientEmeraldEnd = emerald400;

  static const gradientGoldStart = gold600;
  static const gradientGoldEnd = gold400;

  // Named gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientVioletStart, gradientVioletEnd],
  );

  static const LinearGradient coinGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientGoldStart, gradientGoldEnd],
  );

  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientEmeraldStart, gradientEmeraldEnd],
  );

  static LinearGradient cardGlowGradient(Color glowColor) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          glowColor.withAlpha(25),
          glowColor.withAlpha(8),
        ],
      );
}
