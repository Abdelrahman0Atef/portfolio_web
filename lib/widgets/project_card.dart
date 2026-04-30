import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/responsive.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../models/project.dart';
import 'project_thumbnail.dart';
import 'tag_chip.dart';

/// Opens [url] in an external app/browser.
Future<void> _openExternal(String url) async {
  try {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } catch (_) {
    // ignore
  }
}

/// Project card.
class ProjectCard extends StatefulWidget {
  final Project project;
  final int index;

  /// Height of the screenshot thumbnail.
  final double thumbHeight;

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
    required this.thumbHeight,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hover = false;

  void _openDetail() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (_) =>
          _ProjectDetailDialog(project: widget.project, index: widget.index),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final thumbHeight = widget.thumbHeight;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: _openDetail,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hover ? -3 : 0, 0),
          decoration: BoxDecoration(
            color: AppColors.inkSoft,
            border: Border.all(
              color: _hover
                  ? AppColors.accent.withValues(alpha: 0.5)
                  : AppColors.stroke,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          // ClipRRect makes sure the thumbnail's corners follow the card.
          child: ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // --- Thumbnail ---------------------------------------------
                Stack(
                  children: [
                    ProjectThumbnail(
                      image: p.image,
                      index: widget.index,
                      fallbackLabel: p.category,
                      height: thumbHeight,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(17)),
                    ),
                    // Highlight badge for "Solo developer" projects.
                    if (p.role.toLowerCase().contains('solo'))
                      const Positioned(
                        top: 12,
                        left: 12,
                        child: _RoleBadge(label: 'SOLO DEVELOPER'),
                      ),
                    // Store badges on the opposite corner — tappable when URLs are present.
                    if (p.platforms.hasAny &&
                        (p.platforms.googlePlayUrl != null ||
                            p.platforms.appStoreUrl != null))
                      Positioned(
                        top: 12,
                        right: 12,
                        child: _StoreLinks(platforms: p.platforms),
                      ),
                    // Gallery preview strip on the bottom-left.
                    if (p.gallery.isNotEmpty)
                      Positioned(
                        bottom: 12,
                        left: 12,
                        child: _GalleryPreviewStrip(images: p.gallery),
                      ),
                  ],
                ),

                // --- Content -----------------------------------------------
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Default mainAxisSize: max.
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
                              child: Text(
                                p.category.toUpperCase(),
                                style: AppTheme.mono(
                                  size: 9.5,
                                  color: AppColors.textSecondary,
                                  letterSpacing: 1.6,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Show small inline icons only as a fallback when there are no store URLs.
                            if (p.platforms.hasAny &&
                                p.platforms.googlePlayUrl == null &&
                                p.platforms.appStoreUrl == null)
                              _PlatformBadges(platforms: p.platforms),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          p.name,
                          style: AppTheme.display(
                            size: 18,
                            weight: FontWeight.w600,
                            color: AppColors.textPrimary,
                            letterSpacing: -0.4,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          p.tagline,
                          style: AppTheme.body(
                            size: 12.5,
                            color: AppColors.textSecondary,
                            height: 1.45,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: p.tech
                              .take(4)
                              .map((t) => TagChip(label: t, dense: true))
                              .toList(),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                p.role,
                                style: AppTheme.mono(
                                  size: 10.5,
                                  color: AppColors.textSecondary,
                                  letterSpacing: 1.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              PhosphorIconsRegular.arrowUpRight,
                              size: 16,
                              color: AppColors.accent,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'DETAILS',
                              style: AppTheme.mono(
                                size: 10,
                                color: AppColors.accent,
                                letterSpacing: 1.4,
                                weight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlatformBadges extends StatelessWidget {
  final ProjectPlatforms platforms;
  const _PlatformBadges({required this.platforms});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (platforms.googlePlay)
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(PhosphorIconsRegular.googlePlayLogo,
                size: 16, color: AppColors.textSecondary),
          ),
        if (platforms.appStore)
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(PhosphorIconsRegular.appleLogo,
                size: 16, color: AppColors.textSecondary),
          ),
      ],
    );
  }
}

/// Bold "SOLO DEVELOPER" badge that sits on top of the thumbnail.
class _RoleBadge extends StatelessWidget {
  final String label;
  const _RoleBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: AppColors.ink.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        label,
        style: AppTheme.mono(
          size: 10,
          color: AppColors.accentInk,
          letterSpacing: 1.4,
          weight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// Rounded pill containing tappable store icons.
class _StoreLinks extends StatelessWidget {
  final ProjectPlatforms platforms;
  const _StoreLinks({required this.platforms});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.ink.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (platforms.googlePlayUrl != null)
            _StoreIconButton(
              icon: PhosphorIconsRegular.googlePlayLogo,
              tooltip: 'Open in Google Play',
              onTap: () => _openExternal(platforms.googlePlayUrl!),
            ),
          if (platforms.googlePlayUrl != null && platforms.appStoreUrl != null)
            const SizedBox(width: 4),
          if (platforms.appStoreUrl != null)
            _StoreIconButton(
              icon: PhosphorIconsRegular.appleLogo,
              tooltip: 'Open in App Store',
              onTap: () => _openExternal(platforms.appStoreUrl!),
            ),
        ],
      ),
    );
  }
}

class _StoreIconButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _StoreIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_StoreIconButton> createState() => _StoreIconButtonState();
}

class _StoreIconButtonState extends State<_StoreIconButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          // Stop propagation so tapping the icon doesn't also trigger
          // the parent project card's onTap (which opens the dialog).
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _hover
                  ? AppColors.accent.withValues(alpha: 0.18)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              widget.icon,
              size: 16,
              color: _hover ? AppColors.accent : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

// Detail dialog — centred modal on desktop, full-width on mobile
class _ProjectDetailDialog extends StatelessWidget {
  final Project project;
  final int index;

  const _ProjectDetailDialog({required this.project, required this.index});

  @override
  Widget build(BuildContext context) {
    final maxWidth = context.responsive<double>(
      sm: double.infinity,
      md: 640,
      lg: 720,
    );
    final maxHeight = MediaQuery.of(context).size.height * 0.86;

    return Dialog(
      backgroundColor: AppColors.inkSoft,
      insetPadding: context.responsive<EdgeInsets>(
        sm: const EdgeInsets.all(12),
        md: const EdgeInsets.all(40),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.stroke),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(19),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero image / placeholder ---------------------------------
              Stack(
                children: [
                  ProjectThumbnail(
                    image: project.image,
                    index: index,
                    fallbackLabel: project.category,
                    height: 320,
                    borderRadius: BorderRadius.zero,
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Material(
                      color: AppColors.ink.withValues(alpha: 0.6),
                      shape: const CircleBorder(),
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(PhosphorIconsRegular.x, size: 16),
                        color: AppColors.textPrimary,
                        tooltip: 'Close',
                      ),
                    ),
                  ),
                ],
              ),

              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 22, 24, 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.category.toUpperCase(),
                        style: AppTheme.mono(
                          size: 10,
                          color: AppColors.accent,
                          letterSpacing: 1.6,
                          weight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        project.name,
                        style: AppTheme.display(
                          size: 30,
                          weight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        project.tagline,
                        style: AppTheme.body(
                          size: 15.5,
                          color: AppColors.textSecondary,
                          height: 1.55,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: project.tech
                            .map((t) => TagChip(label: t))
                            .toList(),
                      ),
                      const SizedBox(height: 26),
                      Text(
                        'OVERVIEW',
                        style: AppTheme.mono(
                          size: 10,
                          color: AppColors.textSecondary,
                          letterSpacing: 1.6,
                          weight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        project.description,
                        style: AppTheme.body(
                          size: 15,
                          color: AppColors.textPrimary,
                          height: 1.6,
                        ),
                      ),
                      // --- Screenshot gallery ----------------------------
                      // Only renders when the project has additional shots beyond the hero.
                      if (project.gallery.isNotEmpty) ...[
                        const SizedBox(height: 26),
                        Text(
                          'SCREENSHOTS',
                          style: AppTheme.mono(
                            size: 10,
                            color: AppColors.textSecondary,
                            letterSpacing: 1.6,
                            weight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _ProjectGallery(images: project.gallery),
                      ],
                      const SizedBox(height: 26),
                      Text(
                        'HIGHLIGHTS',
                        style: AppTheme.mono(
                          size: 10,
                          color: AppColors.textSecondary,
                          letterSpacing: 1.6,
                          weight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...project.highlights.map(
                        (h) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 8, right: 12),
                                child: SizedBox(
                                  width: 5,
                                  height: 5,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: AppColors.accent,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  h,
                                  style: AppTheme.body(
                                    size: 14.5,
                                    color: AppColors.textSecondary,
                                    height: 1.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.ink,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.stroke),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(PhosphorIconsRegular.user,
                                size: 14, color: AppColors.textSecondary),
                            const SizedBox(width: 8),
                            Text(
                              'Role · ',
                              style: AppTheme.mono(
                                size: 11,
                                color: AppColors.textSecondary,
                                letterSpacing: 1.0,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                project.role,
                                style: AppTheme.mono(
                                  size: 11,
                                  color: AppColors.textPrimary,
                                  letterSpacing: 0.4,
                                  weight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // --- Store install CTAs --------------------------
                      if (project.platforms.googlePlayUrl != null ||
                          project.platforms.appStoreUrl != null) ...[
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            if (project.platforms.googlePlayUrl != null)
                              _StoreCtaButton(
                                icon: PhosphorIconsRegular.googlePlayLogo,
                                label: 'Get it on Google Play',
                                onTap: () => _openExternal(
                                    project.platforms.googlePlayUrl!),
                              ),
                            if (project.platforms.appStoreUrl != null)
                              _StoreCtaButton(
                                icon: PhosphorIconsRegular.appleLogo,
                                label: 'Download on App Store',
                                onTap: () => _openExternal(
                                    project.platforms.appStoreUrl!),
                              ),
                          ],
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

class _StoreCtaButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _StoreCtaButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_StoreCtaButton> createState() => _StoreCtaButtonState();
}

class _StoreCtaButtonState extends State<_StoreCtaButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _hover
                ? AppColors.accent
                : AppColors.accent.withValues(alpha: 0.10),
            border: Border.all(
              color: _hover
                  ? AppColors.accent
                  : AppColors.accent.withValues(alpha: 0.4),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color:
                    _hover ? AppColors.accentInk : AppColors.accent,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: AppTheme.body(
                  size: 13,
                  weight: FontWeight.w600,
                  color: _hover
                      ? AppColors.accentInk
                      : AppColors.textPrimary,
                  letterSpacing: 0.1,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                PhosphorIconsRegular.arrowUpRight,
                size: 14,
                color:
                    _hover ? AppColors.accentInk : AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Project gallery — horizontal scroller of additional screenshots
// Sits inside the project detail dialog under the description.
class _ProjectGallery extends StatelessWidget {
  final List<String> images;

  const _ProjectGallery({required this.images});

  @override
  Widget build(BuildContext context) {
    // Phone-shaped tile: tall, fixed height.
    const tileHeight = 280.0;
    const tileWidth = 140.0;

    return SizedBox(
      height: tileHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) => _GalleryTile(
          image: images[i],
          width: tileWidth,
          height: tileHeight,
          onTap: () => _openLightbox(context, i),
        ),
      ),
    );
  }

  void _openLightbox(BuildContext context, int initialIndex) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (_) => _GalleryLightbox(
        images: images,
        initialIndex: initialIndex,
      ),
    );
  }
}

class _GalleryTile extends StatefulWidget {
  final String image;
  final double width;
  final double height;
  final VoidCallback onTap;

  const _GalleryTile({
    required this.image,
    required this.width,
    required this.height,
    required this.onTap,
  });

  @override
  State<_GalleryTile> createState() => _GalleryTileState();
}

class _GalleryTileState extends State<_GalleryTile> {
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
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: widget.width,
          height: widget.height,
          transform: Matrix4.translationValues(0, _hover ? -2 : 0, 0),
          decoration: BoxDecoration(
            color: AppColors.ink,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hover
                  ? AppColors.accent.withValues(alpha: 0.6)
                  : AppColors.stroke,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Image.asset(
                widget.image,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Center(
                  child: Icon(
                    PhosphorIconsRegular.imageBroken,
                    size: 24,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Full-screen lightbox for the gallery.
class _GalleryLightbox extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _GalleryLightbox({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_GalleryLightbox> createState() => _GalleryLightboxState();
}

class _GalleryLightboxState extends State<_GalleryLightbox> {
  late final PageController _controller;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final next = (_index + delta).clamp(0, widget.images.length - 1);
    if (next == _index) return;
    _controller.animateToPage(
      next,
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Stack(
        children: [
          // Tap-to-dismiss layer behind the image.
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          // Image pager
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.92,
                maxHeight: MediaQuery.of(context).size.height * 0.88,
              ),
              child: PageView.builder(
                controller: _controller,
                itemCount: widget.images.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (_, i) => InteractiveViewer(
                  minScale: 1.0,
                  maxScale: 4.0,
                  child: Center(
                    child: Image.asset(
                      widget.images[i],
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        PhosphorIconsRegular.imageBroken,
                        size: 40,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Close button (top-right)
          Positioned(
            top: 8,
            right: 8,
            child: Material(
              color: AppColors.ink.withValues(alpha: 0.7),
              shape: const CircleBorder(),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(PhosphorIconsRegular.x, size: 18),
                color: AppColors.textPrimary,
                tooltip: 'Close',
              ),
            ),
          ),
          // Prev / next arrows — only on multi-image galleries.
          if (widget.images.length > 1) ...[
            Positioned(
              left: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: _LightboxNavButton(
                  icon: PhosphorIconsRegular.caretLeft,
                  enabled: _index > 0,
                  onTap: () => _go(-1),
                ),
              ),
            ),
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: _LightboxNavButton(
                  icon: PhosphorIconsRegular.caretRight,
                  enabled: _index < widget.images.length - 1,
                  onTap: () => _go(1),
                ),
              ),
            ),
            // Index pill (bottom-centre)
            Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.ink.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${_index + 1} / ${widget.images.length}',
                    style: AppTheme.mono(
                      size: 11,
                      color: AppColors.textPrimary,
                      letterSpacing: 1.2,
                      weight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _LightboxNavButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _LightboxNavButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.3,
      child: Material(
        color: AppColors.ink.withValues(alpha: 0.7),
        shape: const CircleBorder(),
        child: IconButton(
          onPressed: enabled ? onTap : null,
          icon: Icon(icon, size: 20),
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

// Gallery preview strip — bottom-of-card hint that there's more to see
class _GalleryPreviewStrip extends StatelessWidget {
  final List<String> images;

  const _GalleryPreviewStrip({required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();

    // Show up to three previews; everything beyond rolls into the "+N"
    // counter so the strip never overflows on a project with many shots.
    const maxVisible = 3;
    final visible = images.take(maxVisible).toList();
    final remaining = images.length - visible.length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.ink.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < visible.length; i++) ...[
            if (i > 0) const SizedBox(width: 6),
            _MiniThumb(image: visible[i]),
          ],
          if (remaining > 0) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.4),
                ),
              ),
              child: Text(
                '+$remaining',
                style: AppTheme.mono(
                  size: 10,
                  color: AppColors.accent,
                  letterSpacing: 0.6,
                  weight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Tiny phone-shaped preview thumbnail used inside [_GalleryPreviewStrip].
class _MiniThumb extends StatelessWidget {
  final String image;
  const _MiniThumb({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.inkRaised,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.stroke),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
