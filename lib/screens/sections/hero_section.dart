import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/cv_data.dart';
import '../../widgets/avatar_orb.dart';
import '../../widgets/grid_backdrop.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/tag_chip.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onSeeWork;
  final VoidCallback onSeeContact;

  const HeroSection({
    super.key,
    required this.onSeeWork,
    required this.onSeeContact,
  });

  @override
  Widget build(BuildContext context) {
    final desktop = context.isDesktop;

    return ContentColumn(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.responsive(sm: 32, md: 44, lg: 56),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (desktop)
              _DesktopHero(onSeeWork: onSeeWork, onSeeContact: onSeeContact)
            else
              _CompactHero(onSeeWork: onSeeWork, onSeeContact: onSeeContact),

            SizedBox(height: context.responsive(sm: 28, md: 36, lg: 44)),

            // Stats strip — 2 cols on phone, 4 on desktop
            const _StatsStrip(),
          ],
        ),
      ),
    );
  }
}

// Desktop hero: Two-column layout (text on left, avatar on right)
class _DesktopHero extends StatelessWidget {
  final VoidCallback onSeeWork;
  final VoidCallback onSeeContact;

  const _DesktopHero({required this.onSeeWork, required this.onSeeContact});

  @override
  Widget build(BuildContext context) {
    // Avatar size scales with breakpoint — bigger on xl monitors.
    final avatarSize = context.responsive<double>(
      sm: 200,
      md: 220,
      lg: 240,
      xl: 280,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // --- Left column: text + CTAs ----------------------------------
        Expanded(
          flex: 7,
          child: _NameBlock(
            onSeeWork: onSeeWork,
            onSeeContact: onSeeContact,
            compact: false,
          ),
        ),
        const SizedBox(width: 40),
        // --- Right column: avatar orb ----------------------------------
        Expanded(
          flex: 5,
          child: Center(
            child: AvatarOrb(size: avatarSize)
                .animate()
                .fadeIn(delay: 200.ms, duration: 700.ms)
                .scale(
                  begin: const Offset(0.92, 0.92),
                  end: const Offset(1.0, 1.0),
                  delay: 200.ms,
                  duration: 700.ms,
                  curve: Curves.easeOutCubic,
                ),
          ),
        ),
      ],
    );
  }
}

// Compact hero: stacked layout for phone & tablet
class _CompactHero extends StatelessWidget {
  final VoidCallback onSeeWork;
  final VoidCallback onSeeContact;

  const _CompactHero({required this.onSeeWork, required this.onSeeContact});

  @override
  Widget build(BuildContext context) {
    final avatarSize = context.responsive<double>(sm: 140, md: 180);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar above the name on mobile — left-aligned to keep the
        // editorial composition consistent with the body text.
        AvatarOrb(size: avatarSize)
            .animate()
            .fadeIn(duration: 600.ms)
            .scale(
              begin: const Offset(0.92, 0.92),
              end: const Offset(1.0, 1.0),
              duration: 600.ms,
              curve: Curves.easeOutCubic,
            ),
        SizedBox(height: context.responsive(sm: 22, md: 26)),
        _NameBlock(
          onSeeWork: onSeeWork,
          onSeeContact: onSeeContact,
          compact: true,
        ),
      ],
    );
  }
}

// Name + tagline + CTAs — used by both layouts
class _NameBlock extends StatelessWidget {
  final VoidCallback onSeeWork;
  final VoidCallback onSeeContact;
  final bool compact;

  const _NameBlock({
    required this.onSeeWork,
    required this.onSeeContact,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    final viewportWidth = MediaQuery.of(context).size.width;
    final nameSize = compact
        ? (viewportWidth * 0.075).clamp(32.0, 56.0)
        : (viewportWidth * 0.050).clamp(40.0, 84.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            TagChip(label: CvData.role, accent: true, dense: true),
            TagChip(label: CvData.location, dense: true),
          ],
        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2),

        SizedBox(height: context.responsive(sm: 16, md: 20, lg: 24)),

        // --- Name on a single line ----------------------------------
        // FittedBox ensures the whole headline scales down on edge cases
        // (very narrow phones, ultra-tall fonts) instead of overflowing.
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Abdelrahman',
                style: AppTheme.display(
                  size: nameSize,
                  weight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -1.5,
                  height: 1.0,
                ),
              )
                  .animate()
                  .fadeIn(delay: 80.ms, duration: 600.ms)
                  .slideY(begin: 0.1),

              SizedBox(width: nameSize * 0.18),

              Text(
                'Atef',
                style: AppTheme.script(
                  size: nameSize * 1.05,
                  weight: FontWeight.w600,
                  color: AppColors.accent,
                  height: 0.95,
                  letterSpacing: -0.5,
                ),
              )
                  .animate()
                  .fadeIn(delay: 160.ms, duration: 600.ms)
                  .slideY(begin: 0.1),

              if (!compact) ...[
                const SizedBox(width: 18),
                Padding(
                  padding: EdgeInsets.only(bottom: nameSize * 0.16),
                  child: const DiagonalLines(size: 56),
                )
                    .animate()
                    .fadeIn(delay: 320.ms, duration: 600.ms),
              ],
            ],
          ),
        ),

        SizedBox(height: context.responsive(sm: 18, md: 22, lg: 26)),

        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: compact ? double.infinity : 540,
          ),
          child: Text(
            CvData.tagline,
            style: AppTheme.body(
              size: context.responsive(sm: 15, md: 16, lg: 17, xl: 18),
              color: AppColors.textPrimary,
              height: 1.5,
              weight: FontWeight.w400,
            ),
          ),
        ).animate().fadeIn(delay: 240.ms, duration: 600.ms),

        const SizedBox(height: 22),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _HeroButton(
              primary: true,
              label: 'See selected work',
              icon: PhosphorIconsRegular.arrowDown,
              onTap: onSeeWork,
            ),
            _HeroButton(
              primary: false,
              label: 'Get in touch',
              icon: PhosphorIconsRegular.paperPlaneTilt,
              onTap: onSeeContact,
            ),
          ],
        ).animate().fadeIn(delay: 360.ms, duration: 600.ms).slideY(begin: 0.15),
      ],
    );
  }
}

// CTA button (hover-aware)
class _HeroButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool primary;

  const _HeroButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.primary,
  });

  @override
  State<_HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<_HeroButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.primary;
    final bg = p
        ? (_hover ? AppColors.textPrimary : AppColors.accent)
        : (_hover ? AppColors.inkRaised : Colors.transparent);
    final fg = p
        ? AppColors.accentInk
        : (_hover ? AppColors.textPrimary : AppColors.textSecondary);
    final borderColor = p
        ? Colors.transparent
        : (_hover ? AppColors.accent.withValues(alpha: 0.6) : AppColors.stroke);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          decoration: BoxDecoration(
            color: bg,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTheme.body(
                  size: 14.5,
                  weight: FontWeight.w600,
                  color: fg,
                ),
              ),
              const SizedBox(width: 10),
              Icon(widget.icon, size: 16, color: fg),
            ],
          ),
        ),
      ),
    );
  }
}

// Stats strip — 2 metric cards + an "Available for Work / Download CV" CTA
class _StatsStrip extends StatelessWidget {
  const _StatsStrip();

  @override
  Widget build(BuildContext context) {
    final desktop = context.isDesktop;
    final stats = CvData.headlineStats;

    // --- Desktop: single row, available card takes more horizontal space ---
    if (desktop) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < stats.length; i++) ...[
              if (i > 0) const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  value: stats[i].value,
                  label: stats[i].label,
                  emphasised: i == 0,
                )
                    .animate()
                    .fadeIn(
                        delay: Duration(milliseconds: 480 + (i * 90)),
                        duration: 500.ms)
                    .slideY(begin: 0.2),
              ),
            ],
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: const _AvailableForWorkCard()
                  .animate()
                  .fadeIn(
                      delay: Duration(
                          milliseconds: 480 + (stats.length * 90)),
                      duration: 500.ms)
                  .slideY(begin: 0.2),
            ),
          ],
        ),
      );
    }

    // --- Mobile: 2 stats side-by-side, CV card full-width below ----------
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < stats.length; i++) ...[
                if (i > 0) const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    value: stats[i].value,
                    label: stats[i].label,
                    emphasised: i == 0,
                  )
                      .animate()
                      .fadeIn(
                          delay: Duration(milliseconds: 480 + (i * 90)),
                          duration: 500.ms)
                      .slideY(begin: 0.2),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        const _AvailableForWorkCard()
            .animate()
            .fadeIn(
                delay:
                    Duration(milliseconds: 480 + (stats.length * 90)),
                duration: 500.ms)
            .slideY(begin: 0.2),
      ],
    );
  }
}

// Download CV button in the stats strip
class _AvailableForWorkCard extends StatefulWidget {
  const _AvailableForWorkCard();

  @override
  State<_AvailableForWorkCard> createState() => _AvailableForWorkCardState();
}

class _AvailableForWorkCardState extends State<_AvailableForWorkCard> {
  bool _hover = false;

  Future<void> _downloadCV() async {
    final uri = Uri.base.resolve(CvData.cvUrl);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      // user can still reach the CV via the contact section
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: _downloadCV,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          padding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: _hover
                ? AppColors.accent.withValues(alpha: 0.10)
                : AppColors.accent.withValues(alpha: 0.04),
            border: Border.all(
              color: _hover
                  ? AppColors.accent
                  : AppColors.accent.withValues(alpha: 0.4),
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          // Single-line layout: title on the left, animated arrow on the right.
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Download CV',
                  style: AppTheme.display(
                    size: 18,
                    weight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.4,
                    height: 1.1,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              AnimatedSlide(
                duration: const Duration(milliseconds: 220),
                offset: _hover
                    ? const Offset(0.15, 0)
                    : Offset.zero,
                child: Icon(
                  PhosphorIconsRegular.fileArrowDown,
                  size: 22,
                  color: _hover
                      ? AppColors.accent
                      : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
