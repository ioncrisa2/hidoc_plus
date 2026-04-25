import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

enum AppAvatarShape { rounded, circle }

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    required this.size,
    this.imageUrl,
    this.initials,
    this.fallbackIcon = Icons.person_rounded,
    this.shape = AppAvatarShape.rounded,
    this.radius = AppRadius.md,
    this.backgroundColor = AppColors.surfaceContainerLow,
    this.foregroundColor = AppColors.primary,
    this.fit = BoxFit.cover,
    this.badge,
  });

  final double size;
  final String? imageUrl;
  final String? initials;
  final IconData fallbackIcon;
  final AppAvatarShape shape;
  final double radius;
  final Color backgroundColor;
  final Color foregroundColor;
  final BoxFit fit;
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    final avatar = SizedBox.square(
      dimension: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: shape == AppAvatarShape.circle
              ? BoxShape.circle
              : BoxShape.rectangle,
          borderRadius: shape == AppAvatarShape.circle
              ? null
              : BorderRadius.circular(radius),
        ),
        child: ClipPath(
          clipper: shape == AppAvatarShape.circle
              ? const ShapeBorderClipper(shape: CircleBorder())
              : ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius),
                  ),
                ),
          child: _buildContent(context),
        ),
      ),
    );

    if (badge == null) {
      return avatar;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        avatar,
        Positioned(right: -2, bottom: -2, child: badge!),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    final trimmedUrl = imageUrl?.trim();

    if (trimmedUrl != null && trimmedUrl.isNotEmpty) {
      return Image.network(
        trimmedUrl,
        width: size,
        height: size,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _FallbackContent(
            size: size,
            initials: initials,
            fallbackIcon: fallbackIcon,
            foregroundColor: foregroundColor,
          );
        },
      );
    }

    return _FallbackContent(
      size: size,
      initials: initials,
      fallbackIcon: fallbackIcon,
      foregroundColor: foregroundColor,
    );
  }
}

class AppAvatarBadge extends StatelessWidget {
  const AppAvatarBadge({
    super.key,
    this.icon = Icons.circle,
    this.size = 16,
    this.iconSize = 6,
    this.backgroundColor = AppColors.secondaryContainer,
    this.foregroundColor = AppColors.secondary,
    this.borderColor = AppColors.surface,
    this.borderWidth = 2,
  });

  final IconData icon;
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: iconSize, color: foregroundColor),
    );
  }
}

class _FallbackContent extends StatelessWidget {
  const _FallbackContent({
    required this.size,
    required this.initials,
    required this.fallbackIcon,
    required this.foregroundColor,
  });

  final double size;
  final String? initials;
  final IconData fallbackIcon;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    final trimmedInitials = initials?.trim();

    if (trimmedInitials != null && trimmedInitials.isNotEmpty) {
      final fontSize = (size * 0.32).clamp(12.0, 18.0).toDouble();

      return Center(
        child: Text(
          trimmedInitials,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: foregroundColor,
            fontWeight: FontWeight.w800,
            fontSize: fontSize,
          ),
        ),
      );
    }

    final iconSize = (size * 0.42).clamp(18.0, 32.0).toDouble();

    return Center(
      child: Icon(fallbackIcon, size: iconSize, color: foregroundColor),
    );
  }
}
