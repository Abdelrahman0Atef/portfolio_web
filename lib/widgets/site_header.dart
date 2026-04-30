import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../core/responsive.dart';
import '../core/sections.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../data/cv_data.dart';

/// Fixed-position site header.
class SiteHeader extends StatelessWidget {
  final List<NavSection> sections;
  final VoidCallback onMenuTap;
  final SectionId? activeSection;
  final ScrollController scrollController;

  const SiteHeader({
    super.key,
    required this.sections,
    required this.onMenuTap,
    required this.scrollController,
    this.activeSection,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final desktop = context.isDesktop;
    final divider = theme.dividerTheme.color ?? AppColors.stroke;

    return ColoredBox(
      color: AppColors.ink.withValues(alpha: 0.78),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 60,
            child: ContentColumn(
              child: Row(
                children: [
                  _Logo(
                    onTap: () => scrollToSection(
                      sections.firstWhere((s) => s.id == SectionId.home).key,
                      controller: scrollController,
                    ),
                  ),
                  const SizedBox(width: 16),
                  if (desktop) ...[
                    const Spacer(),
                    _DesktopNav(
                      sections: sections,
                      activeSection: activeSection,
                      scrollController: scrollController,
                    ),
                  ] else ...[
                    const Spacer(),
                    IconButton(
                      onPressed: onMenuTap,
                      icon: const Icon(PhosphorIconsRegular.list),
                      color: AppColors.textPrimary,
                      tooltip: 'Open menu',
                    ),
                  ],
                ],
              ),
            ),
          ),
          // Explicit 1px divider — counted in the total height by being
          // a real widget, not a decoration border.
          Container(height: 1, color: divider),
        ],
      ),
    );
  }
}

/// Top-left brand mark.
class _Logo extends StatefulWidget {
  final VoidCallback onTap;
  const _Logo({required this.onTap});

  @override
  State<_Logo> createState() => _LogoState();
}

class _LogoState extends State<_Logo> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final compact = context.isCompact;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Portrait avatar ----------------------------------------
            // The accent ring grows slightly + brightens on hover.
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: EdgeInsets.all(_hover ? 2 : 1.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _hover
                    ? AppColors.accent
                    : AppColors.accent.withValues(alpha: 0.55),
              ),
              child: Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.inkSoft,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile.jpeg',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.accent,
                      alignment: Alignment.center,
                      child: Text(
                        'A',
                        style: AppTheme.display(
                          size: 17,
                          weight: FontWeight.w700,
                          color: AppColors.accentInk,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // --- Name ----------------------------------------------------
            // On phones we drop the surname so the header keeps room for
            // the hamburger; on tablets+ the full short name shows.
            Text(
              compact ? 'Abdelrahman' : CvData.shortName,
              style: AppTheme.body(
                size: 14,
                color: AppColors.textPrimary,
                weight: FontWeight.w600,
                letterSpacing: -0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DesktopNav extends StatelessWidget {
  final List<NavSection> sections;
  final SectionId? activeSection;
  final ScrollController scrollController;
  const _DesktopNav({
    required this.sections,
    required this.scrollController,
    this.activeSection,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: sections.map((s) {
        final active = s.id == activeSection;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: _NavLink(
            label: s.label,
            active: active,
            onTap: () => scrollToSection(s.key, controller: scrollController),
          ),
        );
      }).toList(),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _NavLink({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final showAccent = widget.active || _hover;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTheme.body(
                  size: 13.5,
                  weight: FontWeight.w500,
                  color: showAccent
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  letterSpacing: 0.1,
                ),
              ),
              const SizedBox(height: 5),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                height: 1.5,
                width: showAccent ? 18 : 0,
                color: AppColors.accent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// kept around so the badge can be re-enabled later without re-implementing
// ignore: unused_element
class _ContactCta extends StatefulWidget {
  final VoidCallback onTap;
  const _ContactCta({required this.onTap});

  @override
  State<_ContactCta> createState() => _ContactCtaState();
}

class _ContactCtaState extends State<_ContactCta> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _hover
                ? AppColors.accent
                : AppColors.accent.withValues(alpha: 0.08),
            border: Border.all(
              color: _hover
                  ? AppColors.accent
                  : AppColors.accent.withValues(alpha: 0.45),
            ),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: _hover ? AppColors.accentInk : AppColors.accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Available for work',
                style: AppTheme.mono(
                  size: 11,
                  color: _hover ? AppColors.accentInk : AppColors.accent,
                  letterSpacing: 1.1,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
