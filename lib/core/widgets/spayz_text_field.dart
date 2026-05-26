import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Spayz design-system text input.
///
/// Wraps [TextFormField] with the Spayz dark-theme styling. Supports:
/// - Floating label with brand-violet focus colour.
/// - Prefix icon / suffix icon / suffix widget.
/// - Inline error / helper text.
/// - Naira-prefix variant for amount inputs (shows ₦ prefix).
/// - Obscure toggle for password inputs.
class SpayzTextField extends StatefulWidget {
  const SpayzTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.showNairaPrefix = false,
    this.autocorrect = false,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final bool autofocus;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final bool showNairaPrefix;
  final bool autocorrect;

  @override
  State<SpayzTextField> createState() => _SpayzTextFieldState();
}

class _SpayzTextFieldState extends State<SpayzTextField> {
  late bool _obscure;
  late FocusNode _focus;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
    _focus = widget.focusNode ?? FocusNode();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() => _hasFocus = _focus.hasFocus);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: SpayzTypography.bodyMMedium.copyWith(
              color: _hasFocus
                  ? SpayzColors.brandPrimary
                  : SpayzColors.textSecondary,
            ),
          ),
          const SizedBox(height: SpayzSpacing.xs),
        ],
        TextFormField(
          controller: widget.controller,
          focusNode: _focus,
          obscureText: _obscure,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          autofocus: widget.autofocus,
          maxLines: _obscure ? 1 : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          validator: widget.validator,
          autocorrect: widget.autocorrect,
          style: SpayzTypography.bodyL.copyWith(
            color: widget.enabled
                ? SpayzColors.textPrimary
                : SpayzColors.textDisabled,
          ),
          cursorColor: SpayzColors.brandPrimary,
          cursorWidth: 2,
          buildCounter: widget.maxLength != null
              ? (context, {required currentLength, required isFocused, maxLength}) {
                  return Text(
                    '$currentLength / $maxLength',
                    style: SpayzTypography.caption
                        .copyWith(color: SpayzColors.textTertiary),
                  );
                }
              : null,
          decoration: InputDecoration(
            hintText: widget.hint,
            errorText: widget.errorText,
            helperText: widget.helperText,
            helperStyle: SpayzTypography.caption
                .copyWith(color: SpayzColors.textSecondary),
            errorStyle: SpayzTypography.caption
                .copyWith(color: SpayzColors.stateError),
            counterText: '',
            prefixIcon: _buildPrefixIcon(),
            suffixIcon: _buildSuffixIcon(),
            suffix: widget.suffix,
          ),
        ),
      ],
    );
  }

  Widget? _buildPrefixIcon() {
    if (widget.showNairaPrefix) {
      return Padding(
        padding: const EdgeInsets.only(left: SpayzSpacing.base, right: SpayzSpacing.sm),
        child: Text(
          '₦',
          style: SpayzTypography.headingS.copyWith(
            color: _hasFocus
                ? SpayzColors.brandPrimary
                : SpayzColors.textSecondary,
          ),
        ),
      );
    }
    if (widget.prefixIcon != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: SpayzSpacing.md),
        child: IconTheme(
          data: IconThemeData(
            size: 20,
            color: _hasFocus
                ? SpayzColors.brandPrimary
                : SpayzColors.textSecondary,
          ),
          child: widget.prefixIcon!,
        ),
      );
    }
    return null;
  }

  Widget? _buildSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        onPressed: () => setState(() => _obscure = !_obscure),
        icon: Icon(
          _obscure
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          size: 20,
          color: SpayzColors.textSecondary,
        ),
      );
    }
    if (widget.suffixIcon != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: SpayzSpacing.md),
        child: IconTheme(
          data: const IconThemeData(size: 20, color: SpayzColors.textSecondary),
          child: widget.suffixIcon!,
        ),
      );
    }
    return null;
  }
}

/// Convenience variant — pre-configured for Nigerian Naira amounts.
class SpayzNairaField extends StatelessWidget {
  const SpayzNairaField({
    super.key,
    this.controller,
    this.label = 'Amount',
    this.hint = '0.00',
    this.onChanged,
    this.validator,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final String label;
  final String hint;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SpayzTextField(
      controller: controller,
      label: label,
      hint: hint,
      showNairaPrefix: true,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
    );
  }
}
