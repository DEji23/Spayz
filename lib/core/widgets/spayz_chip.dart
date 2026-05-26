import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Chip visual style.
enum SpayzChipStyle {
  /// Default filter chip — border, transparent bg, fills on select.
  filter,

  /// Category chip — small, icon + label, tinted bg.
  category,

  /// Tag chip — read-only label, no interaction.
  tag,
}

/// Spayz filter / tag chip.
///
/// Used for transaction category filters, budget period selectors, and
/// tag labels on transaction detail cards.
class SpayzChip extends StatelessWidget {
  const SpayzChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.leading,
    this.style = SpayzChipStyle.filter,
    this.selectedColor,
    this.count,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final Widget? leading;
  final SpayzChipStyle style;

  /// Custom accent colour when selected — defaults to brand violet.
  final Color? selectedColor;

  /// Optional count badge shown on the right.
  final int? count;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        padding: _padding,
        decoration: _decoration,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[
              IconTheme(
                data: IconThemeData(size: _iconSize, color: _contentColor),
                child: leading!,
              ),
              const SizedBox(width: SpayzSpacing.xs),
            ],
            Text(label, style: _textStyle),
            if (count != null) ...[
              const SizedBox(width: SpayzSpacing.xs),
              _CountBadge(count: count!, selected: selected,
                  accent: selectedColor ?? SpayzColors.brandPrimary),
            ],
          ],
        ),
      ),
    );
  }

  EdgeInsetsGeometry get _padding => switch (style) {
        SpayzChipStyle.filter => const EdgeInsets.symmetric(
            horizontal: SpayzSpacing.md,
            vertical: SpayzSpacing.sm,
          ),
        SpayzChipStyle.category => const EdgeInsets.symmetric(
            horizontal: SpayzSpacing.sm,
            vertical: SpayzSpacing.xs,
          ),
        SpayzChipStyle.tag => const EdgeInsets.symmetric(
            horizontal: SpayzSpacing.sm,
            vertical: 3,
          ),
      };

  BoxDecoration get _decoration {
    final accent = selectedColor ?? SpayzColors.brandPrimary;

    return switch (style) {
      SpayzChipStyle.filter => BoxDecoration(
          color: selected ? accent.withAlpha(35) : Colors.transparent,
          borderRadius: SpayzRadius.chipRadius,
          border: Border.all(
            color: selected ? accent : SpayzColors.borderDefault,
            width: selected ? 1.5 : 1,
          ),
        ),
      SpayzChipStyle.category => BoxDecoration(
          color: selected
              ? accent.withAlpha(35)
              : SpayzColors.bgElevated,
          borderRadius: SpayzRadius.chipRadius,
          border: Border.all(
            color: selected
                ? accent.withAlpha(120)
                : SpayzColors.borderSubtle,
          ),
        ),
      SpayzChipStyle.tag => BoxDecoration(
          color: SpayzColors.bgElevated,
          borderRadius: SpayzRadius.chipRadius,
        ),
    };
  }

  Color get _contentColor {
    final accent = selectedColor ?? SpayzColors.brandPrimary;
    return selected ? accent : SpayzColors.textSecondary;
  }

  TextStyle get _textStyle => switch (style) {
        SpayzChipStyle.filter => SpayzTypography.bodyMMedium
            .copyWith(color: _contentColor),
        SpayzChipStyle.category => SpayzTypography.captionMedium
            .copyWith(color: _contentColor),
        SpayzChipStyle.tag => SpayzTypography.caption
            .copyWith(color: SpayzColors.textSecondary),
      };

  double get _iconSize => switch (style) {
        SpayzChipStyle.filter => 16,
        _ => 12,
      };
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({
    required this.count,
    required this.selected,
    required this.accent,
  });

  final int count;
  final bool selected;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: selected ? accent : SpayzColors.bgInput,
        borderRadius: SpayzRadius.chipRadius,
      ),
      child: Text(
        '$count',
        style: SpayzTypography.overline.copyWith(
          color: selected ? SpayzColors.textPrimary : SpayzColors.textSecondary,
          fontSize: 10,
        ),
      ),
    );
  }
}

/// A horizontal scrollable row of [SpayzChip]s — common for category filters.
///
/// Manages single-select state internally when [onChanged] is provided;
/// use [selectedIndex] + [onChanged] for controlled mode.
class SpayzChipRow extends StatelessWidget {
  const SpayzChipRow({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
    this.leading,
    this.style = SpayzChipStyle.filter,
    this.padding,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final List<Widget?>? leading;
  final SpayzChipStyle style;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding ??
          const EdgeInsets.symmetric(horizontal: SpayzSpacing.base),
      child: Row(
        children: List.generate(labels.length, (i) {
          return Padding(
            padding: EdgeInsets.only(
              right: i < labels.length - 1 ? SpayzSpacing.chipGap : 0,
            ),
            child: SpayzChip(
              label: labels[i],
              selected: selectedIndex == i,
              onTap: () => onChanged(i),
              leading: leading?[i],
              style: style,
            ),
          );
        }),
      ),
    );
  }
}
