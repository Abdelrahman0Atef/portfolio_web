import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';

/// Editorial section header.
class SectionHeader extends StatelessWidget {
  final String index;
  final String eyebrow;
  final String title;
  final String? subtitle;

  const SectionHeader({
    super.key,
    required this.index,
    required this.eyebrow,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final titleSize = context.responsive<double>(
      sm: 26,
      md: 32,
      lg: 38,
      xl: 42,
    );
    final subtitleMaxWidth =
        context.responsive<double>(sm: 600, md: 680, lg: 720);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              index,
              style: AppTheme.mono(
                size: 11.5,
                color: AppColors.accent,
                letterSpacing: 1.6,
                weight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(height: 1, color: AppColors.stroke),
            ),
            const SizedBox(width: 12),
            Text(
              eyebrow.toUpperCase(),
              style: AppTheme.mono(
                size: 11,
                color: AppColors.textSecondary,
                letterSpacing: 1.6,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: AppTheme.display(
            size: titleSize,
            weight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -1.0,
            height: 1.05,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: subtitleMaxWidth),
            child: Text(
              subtitle!,
              style: AppTheme.body(
                size: 14.5,
                color: AppColors.textSecondary,
                height: 1.55,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
