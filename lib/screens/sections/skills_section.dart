import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/cv_data.dart';
import '../../models/education.dart';
import '../../models/skill_category.dart';
import '../../widgets/reveal_on_scroll.dart';
import '../../widgets/section_header.dart';
import '../../widgets/tag_chip.dart';

/// Skills + Education section.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
              revealKey: const ValueKey('skills_header'),
              child: const SectionHeader(
                index: '04',
                eyebrow: 'Skills',
                title: 'Technical stack.',
                subtitle:
                    'Tools and frameworks I reach for in production — organised by domain.',
              ),
            ),
            const SizedBox(height: 24),
            const _SkillsGrid(),
            // --- Education + certifications credentials block --------------
            // Sat in the About section before — moving it here pairs the
            // credentials with the technical stack they belong to.
            SizedBox(height: context.responsive(sm: 32, md: 40, lg: 48)),
            const _EducationStack(),
          ],
        ),
      ),
    );
  }
}

// Skills grid — content-sized cards via Wrap
// We previously used a GridView with a fixed [childAspectRatio].
class _SkillsGrid extends StatelessWidget {
  const _SkillsGrid();

  @override
  Widget build(BuildContext context) {
    final cols = context.responsive<int>(sm: 1, md: 2, lg: 3, xl: 4);
    final spacing = context.responsive<double>(sm: 12, md: 14, lg: 16, xl: 18);

    return LayoutBuilder(builder: (context, constraints) {
      // Subtract the gaps between columns and divide the rest evenly.
      final totalSpacing = spacing * (cols - 1);
      final cardWidth =
          ((constraints.maxWidth - totalSpacing) / cols) - 0.5;

      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: [
          for (var i = 0; i < CvData.skillCategories.length; i++)
            SizedBox(
              width: cardWidth,
              child: RevealOnScroll(
                revealKey: ValueKey('skill_$i'),
                delay: Duration(milliseconds: (i % cols) * 80),
                child: _CategoryBlock(
                  category: CvData.skillCategories[i],
                  index: i + 1,
                ),
              ),
            ),
        ],
      );
    });
  }
}

class _CategoryBlock extends StatefulWidget {
  final SkillCategory category;
  final int index;

  const _CategoryBlock({required this.category, required this.index});

  @override
  State<_CategoryBlock> createState() => _CategoryBlockState();
}

class _CategoryBlockState extends State<_CategoryBlock> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        // Trimmed from 18.
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        decoration: BoxDecoration(
          color: AppColors.inkSoft,
          border: Border.all(
            color: _hover
                ? AppColors.accent.withValues(alpha: 0.35)
                : AppColors.stroke,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Hug the content rather than fill any phantom height.
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  widget.index.toString().padLeft(2, '0'),
                  style: AppTheme.mono(
                    size: 11,
                    color: AppColors.accent,
                    letterSpacing: 1.4,
                    weight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(height: 1, color: AppColors.stroke),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.category.title,
              style: AppTheme.display(
                size: 16,
                weight: FontWeight.w600,
                color: AppColors.textPrimary,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: widget.category.skills
                  .map((s) => TagChip(label: s, dense: true))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// Education stack — eyebrow + cards + certs/languages footer
// Lifted wholesale out of [AboutSection].
class _EducationStack extends StatelessWidget {
  const _EducationStack();

  @override
  Widget build(BuildContext context) {
    final useHorizontal =
        !context.isCompact && CvData.education.length > 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Mini-header for the Education stack -------------------------
        RevealOnScroll(
          revealKey: const ValueKey('edu_eyebrow'),
          delay: const Duration(milliseconds: 80),
          child: Row(
            children: [
              const Icon(
                PhosphorIconsRegular.graduationCap,
                size: 14,
                color: AppColors.accent,
              ),
              const SizedBox(width: 8),
              Text(
                'EDUCATION',
                style: AppTheme.mono(
                  size: 10.5,
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
          ),
        ),
        const SizedBox(height: 14),
        // --- Education entries ------------------------------------------
        if (useHorizontal)
          RevealOnScroll(
            revealKey: const ValueKey('edu_row'),
            delay: const Duration(milliseconds: 120),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var i = 0; i < CvData.education.length; i++) ...[
                    if (i > 0) const SizedBox(width: 10),
                    Expanded(
                      child: _EducationCard(
                        entry: CvData.education[i],
                        index: i + 1,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          )
        else
          for (var i = 0; i < CvData.education.length; i++)
            Padding(
              padding: EdgeInsets.only(
                bottom: i == CvData.education.length - 1 ? 0 : 10,
              ),
              child: RevealOnScroll(
                revealKey: ValueKey('edu_$i'),
                delay: Duration(milliseconds: 120 + i * 80),
                child: _EducationCard(
                  entry: CvData.education[i],
                  index: i + 1,
                ),
              ),
            ),
        const SizedBox(height: 16),
        // --- Certifications + Languages block ---------------------------
        RevealOnScroll(
          revealKey: const ValueKey('certs'),
          delay: const Duration(milliseconds: 240),
          child: const _CertsLanguagesBlock(),
        ),
      ],
    );
  }
}

/// Hover-aware editorial-style education card.
class _EducationCard extends StatefulWidget {
  final Education entry;
  final int index;
  const _EducationCard({required this.entry, required this.index});

  @override
  State<_EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<_EducationCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: AppColors.inkSoft,
          border: Border.all(
            color: _hover
                ? AppColors.accent.withValues(alpha: 0.35)
                : AppColors.stroke,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Left accent stripe ---------------------------------
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: 3,
                decoration: BoxDecoration(
                  color: _hover
                      ? AppColors.accent
                      : AppColors.accent.withValues(alpha: 0.45),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14),
                  ),
                ),
              ),
              // --- Content -------------------------------------------
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top row: period + index marker
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.entry.period,
                              style: AppTheme.mono(
                                size: 10.5,
                                color: AppColors.textSecondary,
                                letterSpacing: 1.4,
                                weight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            widget.index.toString().padLeft(2, '0'),
                            style: AppTheme.mono(
                              size: 10.5,
                              color: _hover
                                  ? AppColors.accent
                                  : AppColors.textMuted,
                              letterSpacing: 1.4,
                              weight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Degree
                      Text(
                        widget.entry.degree,
                        style: AppTheme.display(
                          size: 17,
                          weight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.2,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Institution with accent dot
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha: 0.7),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              widget.entry.institution,
                              style: AppTheme.body(
                                size: 13.5,
                                weight: FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (widget.entry.notes.isNotEmpty) ...[
                        const SizedBox(height: 10),
                        ...widget.entry.notes.map(
                          (n) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, right: 8),
                                  child: Container(
                                    width: 3,
                                    height: 3,
                                    decoration: const BoxDecoration(
                                      color: AppColors.textMuted,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    n,
                                    style: AppTheme.body(
                                      size: 13,
                                      color: AppColors.textSecondary,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CertsLanguagesBlock extends StatelessWidget {
  const _CertsLanguagesBlock();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(PhosphorIconsRegular.certificate,
                  size: 14, color: AppColors.accent),
              const SizedBox(width: 8),
              Text(
                'CERTIFICATIONS & LANGUAGES',
                style: AppTheme.mono(
                  size: 10.5,
                  color: AppColors.textSecondary,
                  letterSpacing: 1.6,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...CvData.certifications.map(
            (c) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8, right: 10),
                    child: SizedBox(
                      width: 4,
                      height: 4,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.textSecondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      c,
                      style: AppTheme.body(
                          size: 14, color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(height: 1, color: AppColors.stroke),
          const SizedBox(height: 12),
          ...CvData.spokenLanguages.map(
            (l) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Text(
                    l.name,
                    style: AppTheme.body(
                        size: 14, color: AppColors.textPrimary),
                  ),
                  const Spacer(),
                  Text(
                    l.level,
                    style: AppTheme.mono(
                      size: 11,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.6,
                      weight: FontWeight.w500,
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
