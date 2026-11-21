import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';

/// Top-of-card thumbnail for a project.
class ProjectThumbnail extends StatelessWidget {
  final String? image;
  final int index;
  final String fallbackLabel;
  final BorderRadius borderRadius;
  final double height;

  const ProjectThumbnail({
    super.key,
    required this.image,
    required this.index,
    required this.fallbackLabel,
    this.height = 150,
    this.borderRadius =
        const BorderRadius.vertical(top: Radius.circular(18)),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: image == null
            ? _PlaceholderArt(index: index, fallbackLabel: fallbackLabel)
            : _ImageArt(image: image!, index: index),
      ),
    );
  }
}

class _ImageArt extends StatelessWidget {
  final String image;
  final int index;

  const _ImageArt({required this.image, required this.index});

  @override
  Widget build(BuildContext context) {
    // Phone screenshots have a tall aspect ratio that BoxFit.cover would crop aggressively.
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.inkRaised,
                AppColors.ink,
                Color.alphaBlend(
                  AppColors.accent.withValues(alpha: 0.04),
                  AppColors.ink,
                ),
              ],
            ),
          ),
        ),
        // Diagonal accent stripe.
        Opacity(
          opacity: 0.5,
          child: CustomPaint(
            painter: _PlaceholderPainter(index: index),
          ),
        ),
        // The actual screenshot — contained, centred, with breathing
        // room above and below so the device feel is preserved.
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Image.asset(
            image,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) =>
                _PlaceholderArt(index: index, fallbackLabel: 'PROJECT'),
          ),
        ),
      ],
    );
  }
}

class _PlaceholderArt extends StatelessWidget {
  final int index;
  final String fallbackLabel;

  const _PlaceholderArt({required this.index, required this.fallbackLabel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Base — slightly raised dark surface
        const ColoredBox(color: AppColors.inkRaised),
        // Painter — diagonal stripes tinted by index, so each card feels
        // distinct even without a real screenshot.
        CustomPaint(
          painter: _PlaceholderPainter(index: index),
        ),
        // Big project number in the corner
        Positioned(
          left: 18,
          bottom: 14,
          child: Text(
            index.toString().padLeft(2, '0'),
            style: AppTheme.display(
              size: 64,
              weight: FontWeight.w700,
              color: AppColors.textPrimary.withValues(alpha: 0.75),
              letterSpacing: -2.0,
              height: 1.0,
            ),
          ),
        ),
        Positioned(
          right: 16,
          top: 14,
          child: Text(
            fallbackLabel.toUpperCase(),
            style: AppTheme.mono(
              size: 9.5,
              color: AppColors.textSecondary,
              letterSpacing: 1.6,
              weight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _PlaceholderPainter extends CustomPainter {
  final int index;
  _PlaceholderPainter({required this.index});

  @override
  void paint(Canvas canvas, Size size) {
    // Diagonal stripes — sparse, low-opacity. Index controls the angle so
    // adjacent cards don't look identical.
    final stripePaint = Paint()
      ..color = AppColors.accent.withValues(alpha: 0.06)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const step = 18.0;
    final diag = math.sqrt(size.width * size.width + size.height * size.height);
    final angle = (index % 2 == 0) ? -math.pi / 4 : math.pi / 4;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(angle);
    for (double x = -diag; x < diag; x += step) {
      canvas.drawLine(Offset(x, -diag), Offset(x, diag), stripePaint);
    }
    canvas.restore();

    // Single accent square in the upper-left
    final dotPaint = Paint()..color = AppColors.accent;
    canvas.drawRect(const Rect.fromLTWH(18, 18, 6, 6), dotPaint);
  }

  @override
  bool shouldRepaint(covariant _PlaceholderPainter oldDelegate) =>
      oldDelegate.index != index;
}
