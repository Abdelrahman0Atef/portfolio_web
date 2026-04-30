import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// A subtle dotted grid + soft radial glow layered behind the page content.
class GridBackdrop extends StatelessWidget {
  final Widget child;
  final double opacity;
  final bool showGlow;

  const GridBackdrop({
    super.key,
    required this.child,
    this.opacity = 0.05,
    this.showGlow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: _DotGridPainter(
                color: AppColors.textSecondary.withValues(alpha: opacity),
              ),
            ),
          ),
        ),
        if (showGlow)
          Positioned(
            right: -200,
            top: -200,
            child: IgnorePointer(
              child: Container(
                width: 600,
                height: 600,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.accent.withValues(alpha: 0.08),
                      AppColors.accent.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        child,
      ],
    );
  }
}

class _DotGridPainter extends CustomPainter {
  final Color color;
  static const double spacing = 26;
  static const double radius = 0.7;

  _DotGridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final cols = (size.width / spacing).ceil();
    final rows = (size.height / spacing).ceil();
    for (var i = 0; i <= cols; i++) {
      for (var j = 0; j <= rows; j++) {
        canvas.drawCircle(
          Offset(i * spacing.toDouble(), j * spacing.toDouble()),
          radius,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotGridPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Decorative diagonal-line block.
class DiagonalLines extends StatelessWidget {
  final double size;
  final Color? color;

  const DiagonalLines({super.key, this.size = 56, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _DiagonalPainter(color: color ?? AppColors.accent),
      ),
    );
  }
}

class _DiagonalPainter extends CustomPainter {
  final Color color;
  _DiagonalPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.55)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    const step = 4.5;
    final diag = math.sqrt(size.width * size.width + size.height * size.height);
    for (double i = -diag; i < diag; i += step) {
      canvas.drawLine(
          Offset(i, 0), Offset(i + size.height, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DiagonalPainter oldDelegate) =>
      oldDelegate.color != color;
}
