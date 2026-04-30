import 'package:flutter/material.dart';

import '../../core/responsive.dart';
import '../../data/cv_data.dart';
import '../../widgets/project_card.dart';
import '../../widgets/reveal_on_scroll.dart';
import '../../widgets/section_header.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // 3 cols on xl now that the container is fluid — spreads the 6 projects
    // across 2 rows on wide displays instead of 3 deep rows of 2.
    final cols = context.responsive<int>(sm: 1, md: 2, lg: 2, xl: 3);
    final spacing = context.responsive<double>(sm: 14, md: 18, lg: 22, xl: 24);

    // Thumbnail height (must match the value used inside ProjectCard so the
    // dynamic aspect-ratio calculation is accurate).
    final thumbHeight = context.responsive<double>(
      sm: 280,
      md: 300,
      lg: 280,
      xl: 280,
    );

    // Reserved space for the card body (everything below the thumbnail).
    const bodyHeight = 240.0;

    return ContentColumn(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.responsive(sm: 32, md: 44, lg: 56),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RevealOnScroll(
              revealKey: const ValueKey('proj_header'),
              child: const SectionHeader(
                index: '03',
                eyebrow: 'Projects',
                title: 'Selected work.',
                subtitle:
                    'Six production apps across e-commerce, healthcare, HR, and operations. Click any card for the full breakdown.',
              ),
            ),
            const SizedBox(height: 24),
            // Compute the aspect ratio from the actual card width vs.
            LayoutBuilder(builder: (context, constraints) {
              final cardWidth =
                  (constraints.maxWidth - spacing * (cols - 1)) / cols;
              final cardHeight = thumbHeight + bodyHeight;
              final aspectRatio = cardWidth / cardHeight;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: CvData.projects.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  mainAxisSpacing: spacing,
                  crossAxisSpacing: spacing,
                  childAspectRatio: aspectRatio,
                ),
                itemBuilder: (_, i) => RevealOnScroll(
                  revealKey: ValueKey('proj_$i'),
                  delay: Duration(milliseconds: (i % 4) * 70),
                  child: ProjectCard(
                    project: CvData.projects[i],
                    index: i + 1,
                    thumbHeight: thumbHeight,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
