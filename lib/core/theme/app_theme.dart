import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Builds the Spayz [ThemeData].
///
/// Overrides Material 3 defaults to match the premium dark aesthetic —
/// custom colors, tight component shapes, and consistent ink palette.
abstract final class SpayzTheme {
  static ThemeData get dark => _buildDark();

  static ThemeData _buildDark() {
    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      // Brand
      primary: SpayzColors.brandPrimary,
      onPrimary: SpayzColors.textPrimary,
      primaryContainer: SpayzColors.violet700,
      onPrimaryContainer: SpayzColors.violet200,
      // Secondary (emerald — savings)
      secondary: SpayzColors.brandSecondary,
      onSecondary: SpayzColors.textInverse,
      secondaryContainer: SpayzColors.emerald700,
      onSecondaryContainer: SpayzColors.emerald100,
      // Tertiary (gold — coins)
      tertiary: SpayzColors.coinPrimary,
      onTertiary: SpayzColors.textInverse,
      tertiaryContainer: SpayzColors.coinSurface,
      onTertiaryContainer: SpayzColors.gold300,
      // Surfaces
      surface: SpayzColors.bgSurface,
      onSurface: SpayzColors.textPrimary,
      surfaceContainerHighest: SpayzColors.bgElevated,
      surfaceContainerHigh: SpayzColors.bgCard,
      surfaceContainer: SpayzColors.bgCard,
      surfaceContainerLow: SpayzColors.bgSurface,
      surfaceContainerLowest: SpayzColors.bgPage,
      // Error
      error: SpayzColors.stateError,
      onError: SpayzColors.textPrimary,
      errorContainer: SpayzColors.coral700,
      onErrorContainer: SpayzColors.coral300,
      // Outline
      outline: SpayzColors.borderDefault,
      outlineVariant: SpayzColors.borderSubtle,
      // Inverse
      inverseSurface: SpayzColors.ink100,
      onInverseSurface: SpayzColors.ink900,
      inversePrimary: SpayzColors.violet700,
      // Scrim / shadow
      scrim: SpayzColors.bgOverlay,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: SpayzColors.bgPage,
      fontFamily: 'PlusJakartaSans',
      textTheme: SpayzTypography.materialTextTheme.apply(
        bodyColor: SpayzColors.textPrimary,
        displayColor: SpayzColors.textPrimary,
      ),

      // ── App bar ────────────────────────────────────────────────────────────
      appBarTheme: const AppBarTheme(
        backgroundColor: SpayzColors.bgPage,
        foregroundColor: SpayzColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: SpayzTypography.headingM,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: SpayzColors.bgPage,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),

      // ── Bottom navigation bar ──────────────────────────────────────────────
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: SpayzColors.bgSurface,
        selectedItemColor: SpayzColors.brandPrimary,
        unselectedItemColor: SpayzColors.ink300,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: SpayzTypography.captionMedium,
        unselectedLabelStyle: SpayzTypography.caption,
        elevation: 0,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: SpayzColors.bgSurface,
        indicatorColor: SpayzColors.violet500.withAlpha(40),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: SpayzColors.brandPrimary);
          }
          return const IconThemeData(color: SpayzColors.ink300);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return SpayzTypography.captionMedium
                .copyWith(color: SpayzColors.brandPrimary);
          }
          return SpayzTypography.caption
              .copyWith(color: SpayzColors.ink300);
        }),
        elevation: 0,
        height: 72,
      ),

      // ── Cards ──────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: SpayzColors.bgCard,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: SpayzRadius.cardRadius,
        ),
        margin: EdgeInsets.zero,
      ),

      // ── Input decoration ───────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: SpayzColors.bgInput,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: SpayzSpacing.base,
          vertical: SpayzSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: SpayzRadius.inputRadius,
          borderSide: const BorderSide(color: SpayzColors.borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: SpayzRadius.inputRadius,
          borderSide: const BorderSide(color: SpayzColors.borderSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: SpayzRadius.inputRadius,
          borderSide:
              const BorderSide(color: SpayzColors.borderFocus, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: SpayzRadius.inputRadius,
          borderSide: const BorderSide(color: SpayzColors.stateError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: SpayzRadius.inputRadius,
          borderSide:
              const BorderSide(color: SpayzColors.stateError, width: 1.5),
        ),
        hintStyle: SpayzTypography.bodyL
            .copyWith(color: SpayzColors.textDisabled),
        labelStyle: SpayzTypography.bodyM
            .copyWith(color: SpayzColors.textSecondary),
        floatingLabelStyle: SpayzTypography.captionMedium
            .copyWith(color: SpayzColors.brandPrimary),
      ),

      // ── Elevated button ────────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: SpayzColors.brandPrimary,
          foregroundColor: SpayzColors.textPrimary,
          elevation: 0,
          minimumSize: const Size(double.infinity, 52),
          shape: const RoundedRectangleBorder(
            borderRadius: SpayzRadius.buttonRadius,
          ),
          textStyle: SpayzTypography.buttonL,
          padding: const EdgeInsets.symmetric(
            horizontal: SpayzSpacing.xl,
            vertical: SpayzSpacing.base,
          ),
        ),
      ),

      // ── Text button ────────────────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: SpayzColors.brandPrimary,
          textStyle: SpayzTypography.buttonM,
          shape: const RoundedRectangleBorder(
            borderRadius: SpayzRadius.buttonRadius,
          ),
        ),
      ),

      // ── Outlined button ────────────────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: SpayzColors.textPrimary,
          side: const BorderSide(color: SpayzColors.borderDefault),
          minimumSize: const Size(double.infinity, 52),
          shape: const RoundedRectangleBorder(
            borderRadius: SpayzRadius.buttonRadius,
          ),
          textStyle: SpayzTypography.buttonL,
        ),
      ),

      // ── Chip ──────────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: SpayzColors.bgElevated,
        selectedColor: SpayzColors.violet500.withAlpha(40),
        disabledColor: SpayzColors.bgInput,
        labelStyle: SpayzTypography.bodyMMedium,
        secondaryLabelStyle: SpayzTypography.bodyMMedium
            .copyWith(color: SpayzColors.brandPrimary),
        side: const BorderSide(color: SpayzColors.borderSubtle),
        shape: const RoundedRectangleBorder(
          borderRadius: SpayzRadius.chipRadius,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: SpayzSpacing.md,
          vertical: SpayzSpacing.xs,
        ),
      ),

      // ── Divider ────────────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: SpayzColors.borderSubtle,
        thickness: 1,
        space: 1,
      ),

      // ── List tile ─────────────────────────────────────────────────────────
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.transparent,
        contentPadding:
            EdgeInsets.symmetric(horizontal: SpayzSpacing.base),
        minLeadingWidth: 0,
      ),

      // ── Bottom sheet ──────────────────────────────────────────────────────
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: SpayzColors.bgCard,
        shape: RoundedRectangleBorder(borderRadius: SpayzRadius.sheetRadius),
        elevation: 0,
        dragHandleColor: SpayzColors.ink400,
        dragHandleSize: Size(40, 4),
        showDragHandle: true,
      ),

      // ── Dialog ────────────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: SpayzColors.bgCard,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: SpayzRadius.cardRadius,
        ),
        titleTextStyle: SpayzTypography.headingM
            .copyWith(color: SpayzColors.textPrimary),
        contentTextStyle:
            SpayzTypography.bodyM.copyWith(color: SpayzColors.textSecondary),
      ),

      // ── Snack bar ─────────────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: SpayzColors.bgElevated,
        contentTextStyle:
            SpayzTypography.bodyM.copyWith(color: SpayzColors.textPrimary),
        shape: const RoundedRectangleBorder(
          borderRadius: SpayzRadius.cardRadius,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      ),

      // ── Switch ────────────────────────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return SpayzColors.textPrimary;
          }
          return SpayzColors.ink300;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return SpayzColors.brandPrimary;
          }
          return SpayzColors.bgInput;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // ── Progress indicator ────────────────────────────────────────────────
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: SpayzColors.brandPrimary,
        linearTrackColor: SpayzColors.bgInput,
        linearMinHeight: 6,
        circularTrackColor: SpayzColors.bgInput,
      ),
    );
  }
}
