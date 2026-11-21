import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Wraps any child so it fades + slides in the first time it scrolls into view.
class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double slideOffset;

  /// A unique key so [VisibilityDetector] can track this widget across rebuilds.
  final Key revealKey;

  const RevealOnScroll({
    super.key,
    required this.revealKey,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 520),
    this.slideOffset = 0.06,
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  bool _shown = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.revealKey,
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.12 && !_shown && mounted) {
          setState(() => _shown = true);
        }
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 0),
        child: _shown
            ? widget.child
                .animate()
                .fadeIn(delay: widget.delay, duration: widget.duration)
                .slideY(
                  begin: widget.slideOffset,
                  end: 0,
                  delay: widget.delay,
                  duration: widget.duration,
                  curve: Curves.easeOutCubic,
                )
            : Opacity(opacity: 0, child: widget.child),
      ),
    );
  }
}
