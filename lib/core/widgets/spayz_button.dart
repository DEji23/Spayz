import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Button variant selector.
enum SpayzButtonVariant { primary, secondary, ghost, danger }

/// Button size selector.
enum SpayzButtonSize { large, medium, small }

/// Spayz design-system button.
///
/// - `primary` — gradient violet, glowing CTA.
/// - `secondary` — outlined with brand border, no fill.
/// - `ghost` — transparent, text only — low-emphasis actions.
/// - `danger` — coral fill / outline — destructive actions.
///
/// All variants support an optional [leading] / [trailing] icon, a [loading]
/// state (swaps content for a spinner), and [disabled].
class SpayzButton extends StatefulWidget {
  const SpayzButton({
    super.key,
    required this.label,
    required this.onTap,
    this.variant = SpayzButtonVariant.primary,
    this.size = SpayzButtonSize.large,
    this.leading,
    this.trailing,
    this.loading = false,
    this.disabled = false,
    this.fullWidth = true,
  });

  final String label;
  final VoidCallback? onTap;
  final SpayzButtonVariant variant;
  final SpayzButtonSize size;
  final Widget? leading;
  final Widget? trailing;
  final bool loading;
  final bool disabled;
  final bool fullWidth;

  @override
  State<SpayzButton> createState() => _SpayzButtonState();
}

class _SpayzButtonState extends State<SpayzButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _press;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _press = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 160),
    );
    _scale = Tween(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _press, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _press.dispose();
    super.dispose();
  }

  bool get _isInteractive => !widget.disabled && !widget.loading;

  void _onTapDown(TapDownDetails _) {
    if (_isInteractive) _press.forward();
  }

  void _onTapUp(TapUpDetails _) {
    _press.reverse();
    if (_isInteractive) widget.onTap?.call();
  }

  void _onTapCancel() => _press.reverse();

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final dims = _dims;
    final isDisabled = widget.disabled || widget.loading;

    Widget content = _buildContent(dims);

    switch (widget.variant) {
      case SpayzButtonVariant.primary:
        return _PrimaryButton(
          dims: dims,
          fullWidth: widget.fullWidth,
          disabled: isDisabled,
          child: content,
        );
      case SpayzButtonVariant.secondary:
        return _OutlinedButton(
          dims: dims,
          fullWidth: widget.fullWidth,
          disabled: isDisabled,
          borderColor: SpayzColors.brandPrimary,
          labelColor: SpayzColors.brandPrimary,
          child: content,
        );
      case SpayzButtonVariant.ghost:
        return _GhostButton(
          dims: dims,
          fullWidth: widget.fullWidth,
          disabled: isDisabled,
          child: content,
        );
      case SpayzButtonVariant.danger:
        return _OutlinedButton(
          dims: dims,
          fullWidth: widget.fullWidth,
          disabled: isDisabled,
          fill: true,
          fillColor: SpayzColors.coral500,
          borderColor: SpayzColors.coral500,
          labelColor: SpayzColors.textPrimary,
          child: content,
        );
    }
  }

  Widget _buildContent(_ButtonDims dims) {
    if (widget.loading) {
      return SizedBox(
        width: dims.iconSize,
        height: dims.iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: _spinnerColor,
        ),
      );
    }

    final textStyle = dims.textStyle.copyWith(color: _textColor);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.leading != null) ...[
          IconTheme(
            data: IconThemeData(size: dims.iconSize, color: _textColor),
            child: widget.leading!,
          ),
          const SizedBox(width: SpayzSpacing.sm),
        ],
        Text(widget.label, style: textStyle),
        if (widget.trailing != null) ...[
          const SizedBox(width: SpayzSpacing.sm),
          IconTheme(
            data: IconThemeData(size: dims.iconSize, color: _textColor),
            child: widget.trailing!,
          ),
        ],
      ],
    );
  }

  Color get _textColor {
    if (widget.disabled) return SpayzColors.textDisabled;
    return switch (widget.variant) {
      SpayzButtonVariant.primary => SpayzColors.textPrimary,
      SpayzButtonVariant.secondary => SpayzColors.brandPrimary,
      SpayzButtonVariant.ghost => SpayzColors.textSecondary,
      SpayzButtonVariant.danger => SpayzColors.textPrimary,
    };
  }

  Color get _spinnerColor {
    return switch (widget.variant) {
      SpayzButtonVariant.secondary => SpayzColors.brandPrimary,
      SpayzButtonVariant.ghost => SpayzColors.textSecondary,
      _ => SpayzColors.textPrimary,
    };
  }

  _ButtonDims get _dims => switch (widget.size) {
        SpayzButtonSize.large => const _ButtonDims(
            height: 52,
            hPadding: SpayzSpacing.xl,
            iconSize: 20,
            textStyle: SpayzTypography.buttonL,
          ),
        SpayzButtonSize.medium => const _ButtonDims(
            height: 44,
            hPadding: SpayzSpacing.base,
            iconSize: 18,
            textStyle: SpayzTypography.buttonM,
          ),
        SpayzButtonSize.small => const _ButtonDims(
            height: 36,
            hPadding: SpayzSpacing.md,
            iconSize: 16,
            textStyle: SpayzTypography.buttonM,
          ),
      };
}

// ─── Variant shells ──────────────────────────────────────────────────────────

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.dims,
    required this.fullWidth,
    required this.disabled,
    required this.child,
  });

  final _ButtonDims dims;
  final bool fullWidth;
  final bool disabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dims.height,
      width: fullWidth ? double.infinity : null,
      padding: EdgeInsets.symmetric(horizontal: dims.hPadding),
      decoration: BoxDecoration(
        gradient: disabled ? null : SpayzColors.primaryGradient,
        color: disabled ? SpayzColors.bgInput : null,
        borderRadius: SpayzRadius.buttonRadius,
        boxShadow: disabled
            ? null
            : SpayzElevation.primaryGlow(SpayzColors.brandPrimary),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}

class _OutlinedButton extends StatelessWidget {
  const _OutlinedButton({
    required this.dims,
    required this.fullWidth,
    required this.disabled,
    required this.borderColor,
    required this.labelColor,
    required this.child,
    this.fill = false,
    this.fillColor,
  });

  final _ButtonDims dims;
  final bool fullWidth;
  final bool disabled;
  final Color borderColor;
  final Color labelColor;
  final bool fill;
  final Color? fillColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dims.height,
      width: fullWidth ? double.infinity : null,
      padding: EdgeInsets.symmetric(horizontal: dims.hPadding),
      decoration: BoxDecoration(
        color: disabled
            ? SpayzColors.bgInput
            : (fill ? fillColor : Colors.transparent),
        borderRadius: SpayzRadius.buttonRadius,
        border: Border.all(
          color: disabled ? SpayzColors.borderSubtle : borderColor,
        ),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}

class _GhostButton extends StatelessWidget {
  const _GhostButton({
    required this.dims,
    required this.fullWidth,
    required this.disabled,
    required this.child,
  });

  final _ButtonDims dims;
  final bool fullWidth;
  final bool disabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dims.height,
      width: fullWidth ? double.infinity : null,
      padding: EdgeInsets.symmetric(horizontal: dims.hPadding),
      alignment: Alignment.center,
      child: child,
    );
  }
}

// ─── Internal helpers ─────────────────────────────────────────────────────────

class _ButtonDims {
  const _ButtonDims({
    required this.height,
    required this.hPadding,
    required this.iconSize,
    required this.textStyle,
  });

  final double height;
  final double hPadding;
  final double iconSize;
  final TextStyle textStyle;
}
