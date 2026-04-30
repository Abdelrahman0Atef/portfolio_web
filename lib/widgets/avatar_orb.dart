import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';

class AvatarOrb extends StatefulWidget {
  /// Diameter of the photo itself (the orbit ring extends ~40px beyond).
  final double size;

  /// Path of the image asset to render inside the orb.
  final String imagePath;

  const AvatarOrb({
    super.key,
    this.size = 320,
    this.imagePath = 'assets/images/profile.jpeg',
  });

  @override
  State<AvatarOrb> createState() => _AvatarOrbState();
}

class _AvatarOrbState extends State<AvatarOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 28),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orbitSize = widget.size + 56;

    return SizedBox(
      width: orbitSize,
      height: orbitSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Soft accent glow behind the photo
          IgnorePointer(
            child: Container(
              width: orbitSize,
              height: orbitSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accent.withValues(alpha: 0.18),
                    AppColors.accent.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),

          // Slow-rotating dashed orbit ring
          AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return Transform.rotate(
                angle: _controller.value * 2 * math.pi,
                child: CustomPaint(
                  size: Size(orbitSize - 4, orbitSize - 4),
                  painter: _DashedOrbitPainter(
                    color: AppColors.accent.withValues(alpha: 0.45),
                  ),
                ),
              );
            },
          ),

          // Profile photo with thin accent ring
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.55),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 32,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
                // If the asset is missing for any reason, render a calm
                // mono-colored placeholder rather than a broken-image icon.
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.inkRaised,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.person_outline,
                    color: AppColors.textMuted,
                    size: 48,
                  ),
                ),
              ),
            ),
          ),

          // Small fixed orbit dot — sits at top-right as a static accent
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Tiny rotating "satellite" — counter-rotates so it visually
          // travels around the orbit ring.
          AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              final angle = _controller.value * 2 * math.pi;
              final radius = (orbitSize - 6) / 2;
              return Transform.translate(
                offset: Offset(
                  math.cos(angle - math.pi / 2) * radius,
                  math.sin(angle - math.pi / 2) * radius,
                ),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.6),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DashedOrbitPainter extends CustomPainter {
  final Color color;
  _DashedOrbitPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);

    // Draw a dashed circle by stroking short arcs separated by gaps.
    const dashLengthDeg = 4.0;
    const gapLengthDeg = 4.0;
    const totalDeg = 360.0;
    final rect = Rect.fromCircle(center: center, radius: radius);

    var startDeg = 0.0;
    while (startDeg < totalDeg) {
      final sweepDeg = math.min(dashLengthDeg, totalDeg - startDeg);
      canvas.drawArc(
        rect,
        _degToRad(startDeg),
        _degToRad(sweepDeg),
        false,
        paint,
      );
      startDeg += dashLengthDeg + gapLengthDeg;
    }
  }

  static double _degToRad(double deg) => deg * math.pi / 180.0;

  @override
  bool shouldRepaint(covariant _DashedOrbitPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Compact horizontal "credit strip" — small avatar + role + status.
class AvatarCredit extends StatelessWidget {
  final double size;
  final String imagePath;
  final String name;
  final String role;

  const AvatarCredit({
    super.key,
    this.size = 44,
    this.imagePath = 'assets/images/profile.jpeg',
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.accent.withValues(alpha: 0.45),
              width: 1,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.inkRaised,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.person_outline,
                  color: AppColors.textMuted,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: AppTheme.body(
                size: 14,
                weight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              role,
              style: AppTheme.mono(
                size: 10,
                color: AppColors.textSecondary,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
