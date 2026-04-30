import 'package:flutter/material.dart';

import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/cv_data.dart';
import '../../widgets/reveal_on_scroll.dart';
import '../../widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isCompact = context.isCompact;

    return ContentColumn(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.responsive(sm: 32, md: 44, lg: 56),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RevealOnScroll(
              revealKey: const ValueKey('about_header'),
              child: const SectionHeader(
                index: '01',
                eyebrow: 'About',
                title: 'Three years of\nshipping production Flutter.',
              ),
            ),
            const SizedBox(height: 20),
            // --- Bio prose ------------------------------------------------
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isCompact ? double.infinity : 760,
              ),
              child: RevealOnScroll(
                revealKey: const ValueKey('about_bio'),
                delay: const Duration(milliseconds: 80),
                child: Text(
                  CvData.summary,
                  style: AppTheme.body(
                    size: isCompact ? 14.5 : 15.5,
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
