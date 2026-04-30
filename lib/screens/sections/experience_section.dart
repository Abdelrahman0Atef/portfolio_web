import 'package:flutter/material.dart';

import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/cv_data.dart';
import '../../widgets/experience_card.dart';
import '../../widgets/reveal_on_scroll.dart';
import '../../widgets/section_header.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentColumn(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.responsive(sm: 32, md: 44, lg: 56),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RevealOnScroll(
              revealKey: const ValueKey('exp_header'),
              child: const SectionHeader(
                index: '02',
                eyebrow: 'Experience',
                title: 'Where I\'ve shipped.',
                subtitle:
                    'Each role is presented as a node on a timeline — most recent first.',
              ),
            ),
            const SizedBox(height: 24),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 820),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Paid work timeline ----------------------------
                  ...List.generate(CvData.experiences.length, (i) {
                    return RevealOnScroll(
                      revealKey: ValueKey('exp_$i'),
                      delay: Duration(milliseconds: i * 80),
                      child: ExperienceCard(
                        experience: CvData.experiences[i],
                        isLast: i == CvData.experiences.length - 1,
                      ),
                    );
                  }),

                  // --- Volunteering subsection -----------------------
                  const SizedBox(height: 24),
                  RevealOnScroll(
                    revealKey: const ValueKey('vol_eyebrow'),
                    child: const _VolunteeringEyebrow(),
                  ),
                  const SizedBox(height: 20),
                  ...List.generate(CvData.volunteering.length, (i) {
                    return RevealOnScroll(
                      revealKey: ValueKey('vol_$i'),
                      delay: Duration(milliseconds: i * 80),
                      child: ExperienceCard(
                        experience: CvData.volunteering[i],
                        isLast: i == CvData.volunteering.length - 1,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Mini-eyebrow that introduces the volunteering subsection.
class _VolunteeringEyebrow extends StatelessWidget {
  const _VolunteeringEyebrow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.only(left: 0, right: 18),
          decoration: BoxDecoration(
            color: AppColors.ink,
            border: Border.all(color: AppColors.stroke, width: 2),
            shape: BoxShape.circle,
          ),
        ),
        Text(
          'VOLUNTEERING',
          style: AppTheme.mono(
            size: 11,
            color: AppColors.textSecondary,
            letterSpacing: 1.6,
            weight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(height: 1, color: AppColors.stroke),
        ),
      ],
    );
  }
}
