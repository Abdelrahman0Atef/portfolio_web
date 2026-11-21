import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';

/// Compact stat card. Hover lifts the border to the accent color on web.
class StatCard extends StatefulWidget {
  final String value;
  final String label;
  final bool emphasised;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    this.emphasised = false,
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.inkSoft,
          border: Border.all(
            color: _hover
                ? AppColors.accent.withValues(alpha: 0.4)
                : AppColors.stroke,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.value,
              style: AppTheme.display(
                size: 28,
                weight: FontWeight.w700,
                color: widget.emphasised
                    ? AppColors.accent
                    : AppColors.textPrimary,
                letterSpacing: -1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.label,
              style: AppTheme.mono(
                size: 9.5,
                color: AppColors.textSecondary,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
