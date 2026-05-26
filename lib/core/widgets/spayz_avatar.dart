import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Avatar size enumeration.
enum SpayzAvatarSize { xs, sm, md, lg, xl }

/// Status indicator shown on the avatar ring.
enum SpayzAvatarStatus { none, online, verified, premium }

/// Spayz avatar component.
///
/// Shows either a network image or initials fallback with the Spayz gradient
/// ring. Supports a status indicator dot and a premium ring for high-tier
/// users. Also used for bank account icons in the accounts list.
class SpayzAvatar extends StatelessWidget {
  const SpayzAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = SpayzAvatarSize.md,
    this.status = SpayzAvatarStatus.none,
    this.showBrandRing = false,
    this.ringGradient,
    this.backgroundColor,
    this.onTap,
  }) : assert(
          imageUrl != null || initials != null,
          'Provide either imageUrl or initials.',
        );

  /// Network image URL. Takes precedence over [initials].
  final String? imageUrl;

  /// 1–2 character initials shown when no image is available.
  final String? initials;

  final SpayzAvatarSize size;
  final SpayzAvatarStatus status;

  /// Draws a gradient ring around the avatar (like an Instagram story ring).
  final bool showBrandRing;

  /// Custom ring gradient — defaults to [SpayzColors.primaryGradient].
  final Gradient? ringGradient;

  /// Background colour for the initials container.
  final Color? backgroundColor;

  final VoidCallback? onTap;

  double get _diameter => switch (size) {
        SpayzAvatarSize.xs => 24,
        SpayzAvatarSize.sm => 32,
        SpayzAvatarSize.md => 44,
        SpayzAvatarSize.lg => 64,
        SpayzAvatarSize.xl => 88,
      };

  double get _fontSize => switch (size) {
        SpayzAvatarSize.xs => 9,
        SpayzAvatarSize.sm => 12,
        SpayzAvatarSize.md => 16,
        SpayzAvatarSize.lg => 22,
        SpayzAvatarSize.xl => 30,
      };

  double get _ringWidth => switch (size) {
        SpayzAvatarSize.xs || SpayzAvatarSize.sm => 1.5,
        SpayzAvatarSize.md => 2,
        _ => 2.5,
      };

  double get _statusDotSize => switch (size) {
        SpayzAvatarSize.xs => 6,
        SpayzAvatarSize.sm => 8,
        SpayzAvatarSize.md => 10,
        SpayzAvatarSize.lg => 14,
        SpayzAvatarSize.xl => 18,
      };

  @override
  Widget build(BuildContext context) {
    Widget avatar = _buildAvatar();

    if (showBrandRing) {
      avatar = _buildRing(avatar);
    }

    if (status != SpayzAvatarStatus.none) {
      avatar = Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: _StatusDot(
              status: status,
              size: _statusDotSize,
            ),
          ),
        ],
      );
    }

    if (onTap != null) {
      avatar = GestureDetector(onTap: onTap, child: avatar);
    }

    return avatar;
  }

  Widget _buildAvatar() {
    final bg = backgroundColor ?? SpayzColors.violet700;

    return Container(
      width: _diameter,
      height: _diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: imageUrl == null ? bg : SpayzColors.bgCard,
        border: showBrandRing
            ? null
            : Border.all(
                color: SpayzColors.borderDefault,
                width: 0.5,
              ),
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl != null
          ? _NetworkImage(url: imageUrl!, diameter: _diameter)
          : Center(
              child: Text(
                (initials ?? '?').toUpperCase(),
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: _fontSize,
                  fontWeight: FontWeight.w700,
                  color: SpayzColors.textPrimary,
                  height: 1,
                ),
              ),
            ),
    );
  }

  Widget _buildRing(Widget child) {
    final gap = _ringWidth + 1.5; // space between ring and image
    return Container(
      width: _diameter + gap * 2 + _ringWidth * 2,
      height: _diameter + gap * 2 + _ringWidth * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: ringGradient ?? SpayzColors.primaryGradient,
      ),
      padding: EdgeInsets.all(gap),
      child: ClipOval(child: child),
    );
  }
}

class _NetworkImage extends StatelessWidget {
  const _NetworkImage({required this.url, required this.diameter});

  final String url;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: diameter,
      height: diameter,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const Center(
        child: Icon(Icons.person_outline, color: SpayzColors.textDisabled),
      ),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(color: SpayzColors.bgCard);
      },
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.status, required this.size});

  final SpayzAvatarStatus status;
  final double size;

  Color get _color => switch (status) {
        SpayzAvatarStatus.online => SpayzColors.stateSuccess,
        SpayzAvatarStatus.verified => SpayzColors.brandPrimary,
        SpayzAvatarStatus.premium => SpayzColors.coinPrimary,
        SpayzAvatarStatus.none => Colors.transparent,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _color,
        shape: BoxShape.circle,
        border: Border.all(
          color: SpayzColors.bgPage,
          width: 1.5,
        ),
      ),
      child: status == SpayzAvatarStatus.verified
          ? Icon(
              Icons.check,
              size: size * 0.55,
              color: SpayzColors.textPrimary,
            )
          : null,
    );
  }
}

/// Bank account avatar — logo image with bank-branded ring.
///
/// Use on the account selector and the transaction tile for account context.
class SpayzBankAvatar extends StatelessWidget {
  const SpayzBankAvatar({
    super.key,
    required this.bankName,
    this.logoUrl,
    this.size = SpayzAvatarSize.md,
    this.onTap,
  });

  final String bankName;
  final String? logoUrl;
  final SpayzAvatarSize size;
  final VoidCallback? onTap;

  String get _initials {
    final words = bankName.trim().split(RegExp(r'\s+'));
    if (words.length >= 2) return '${words[0][0]}${words[1][0]}';
    return bankName.substring(0, bankName.length.clamp(0, 2));
  }

  @override
  Widget build(BuildContext context) {
    return SpayzAvatar(
      imageUrl: logoUrl,
      initials: _initials,
      size: size,
      backgroundColor: SpayzColors.sky500.withAlpha(40),
      onTap: onTap,
    );
  }
}
