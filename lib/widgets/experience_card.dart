import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../models/experience.dart';

/// Single experience entry on a timeline rail.
class ExperienceCard extends StatelessWidget {
  final Experience experience;
  final bool isLast;

  const ExperienceCard({
    super.key,
    required this.experience,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Timeline rail ------------------------------------------------
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: experience.isCurrent
                        ? AppColors.accent
                        : AppColors.ink,
                    border: Border.all(
                      color: experience.isCurrent
                          ? AppColors.accent
                          : AppColors.stroke,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      margin: const EdgeInsets.only(top: 4),
                      color: AppColors.stroke,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 18),

          // --- Content ------------------------------------------------------
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Role (job title) — anchors the card ---------
                  Text(
                    experience.role,
                    style: AppTheme.display(
                      size: 19,
                      weight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // --- Company + period on a single horizontal row.
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 12,
                    runSpacing: 6,
                    children: [
                      Text(
                        experience.company,
                        style: AppTheme.body(
                          size: 14.5,
                          weight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      // Separator dot — only present when there's a
                      // period to follow it.
                      Container(
                        width: 3,
                        height: 3,
                        decoration: const BoxDecoration(
                          color: AppColors.textMuted,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(
                        experience.period,
                        style: AppTheme.mono(
                          size: 11.5,
                          color: AppColors.textSecondary,
                          letterSpacing: 1.0,
                        ),
                      ),
                      if (experience.isCurrent)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                                color: AppColors.accent.withValues(alpha: 0.4)),
                          ),
                          child: Text(
                            'CURRENT',
                            style: AppTheme.mono(
                              size: 9,
                              color: AppColors.accent,
                              letterSpacing: 1.4,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...experience.bullets.map(
                    (b) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8, right: 12),
                            child: Container(
                              width: 4,
                              height: 4,
                              decoration: const BoxDecoration(
                                color: AppColors.accent,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              b,
                              style: AppTheme.body(
                                size: 13.5,
                                color: AppColors.textSecondary,
                                height: 1.55,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
