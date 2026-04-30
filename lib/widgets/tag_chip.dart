import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';

/// Inline tag — used for tech stacks, categories, skills.
class TagChip extends StatelessWidget {
  final String label;
  final bool accent;
  final bool dense;

  const TagChip({
    super.key,
    required this.label,
    this.accent = false,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    final fg = accent ? AppColors.accent : AppColors.textSecondary;
    final border = accent
        ? AppColors.accent.withValues(alpha: 0.45)
        : AppColors.stroke;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dense ? 9 : 12,
        vertical: dense ? 5 : 7,
      ),
      decoration: BoxDecoration(
        color: accent
            ? AppColors.accent.withValues(alpha: 0.05)
            : Colors.transparent,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: AppTheme.mono(
          size: dense ? 10 : 10.5,
          color: fg,
          letterSpacing: 0.6,
          weight: FontWeight.w500,
        ),
      ),
    );
  }
}
