import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../core/sections.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';

/// End drawer presented on mobile/tablet for navigation.
class MobileNavDrawer extends StatelessWidget {
  final List<NavSection> sections;
  final ScrollController scrollController;

  const MobileNavDrawer({
    super.key,
    required this.sections,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.inkSoft,
      shape: const RoundedRectangleBorder(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'NAVIGATION',
                    style: AppTheme.mono(
                      size: 10.5,
                      color: AppColors.textSecondary,
                      letterSpacing: 1.6,
                      weight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(PhosphorIconsRegular.x),
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(color: AppColors.stroke, height: 1),
              const SizedBox(height: 8),
              ...sections.map(
                (s) => _DrawerLink(
                  section: s,
                  scrollController: scrollController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerLink extends StatelessWidget {
  final NavSection section;
  final ScrollController scrollController;
  const _DrawerLink({required this.section, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        // Wait for the drawer to close before scrolling.
        Future.delayed(const Duration(milliseconds: 280), () {
          scrollToSection(section.key, controller: scrollController);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Text(
              section.label,
              style: AppTheme.display(
                size: 22,
                weight: FontWeight.w700,
                color: AppColors.textPrimary,
                letterSpacing: -0.4,
              ),
            ),
            const Spacer(),
            const Icon(
              PhosphorIconsRegular.arrowUpRight,
              size: 18,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
