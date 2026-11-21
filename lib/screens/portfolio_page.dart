import 'package:flutter/material.dart';

import '../core/sections.dart';
import '../widgets/grid_backdrop.dart';
import '../widgets/mobile_nav_drawer.dart';
import '../widgets/site_header.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/experience_section.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';

// Must match the height SiteHeader renders at (60 content + 1 border = 61).
const double _stickyHeaderHeight = 61;

/// Single-page portfolio.
class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final List<NavSection> _sections = NavSections.create();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  SectionId _activeSection = SectionId.home;

  NavSection _section(SectionId id) =>
      _sections.firstWhere((s) => s.id == id);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  /// Determine which section is currently "active" based on scroll position.
  void _handleScroll() {
    if (!_scrollController.hasClients) return;

    // Anchor line just below the sticky header.
    const anchor = _stickyHeaderHeight + 8;

    SectionId? candidate;
    double smallestPositiveDistance = double.infinity;

    for (final s in _sections) {
      final ctx = s.key.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final y = box.localToGlobal(Offset.zero).dy;
      // We want the section whose top is just above (or at) the anchor.
      final distance = anchor - y;
      if (distance >= 0 && distance < smallestPositiveDistance) {
        smallestPositiveDistance = distance;
        candidate = s.id;
      }
    }

    final next = candidate ?? SectionId.home;
    if (next != _activeSection) {
      setState(() => _activeSection = next);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      endDrawer: MobileNavDrawer(
        sections: _sections,
        scrollController: _scrollController,
      ),
      body: GridBackdrop(
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          thickness: 6,
          radius: const Radius.circular(3),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // --- Sticky header ----------------------------------------
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyHeaderDelegate(
                  child: SiteHeader(
                    sections: _sections,
                    scrollController: _scrollController,
                    activeSection: _activeSection,
                    onMenuTap: () =>
                        _scaffoldKey.currentState?.openEndDrawer(),
                  ),
                ),
              ),

              // --- Hero -------------------------------------------------
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _section(SectionId.home).key,
                  child: HeroSection(
                    onSeeWork: () => scrollToSection(
                      _section(SectionId.projects).key,
                      controller: _scrollController,
                    ),
                    onSeeContact: () => scrollToSection(
                      _section(SectionId.contact).key,
                      controller: _scrollController,
                    ),
                  ),
                ),
              ),

              // --- About ------------------------------------------------
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _section(SectionId.about).key,
                  child: const AboutSection(),
                ),
              ),

              // --- Experience ------------------------------------------
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _section(SectionId.experience).key,
                  child: const ExperienceSection(),
                ),
              ),

              // --- Projects --------------------------------------------
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _section(SectionId.projects).key,
                  child: const ProjectsSection(),
                ),
              ),

              // --- Skills -----------------------------------------------
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _section(SectionId.skills).key,
                  child: const SkillsSection(),
                ),
              ),

              // --- Contact + Footer ------------------------------------
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _section(SectionId.contact).key,
                  child: const ContactSection(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Pins the [SiteHeader] to the top of the viewport while scrolling.
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _StickyHeaderDelegate({required this.child});

  @override
  double get minExtent => _stickyHeaderHeight;

  @override
  double get maxExtent => _stickyHeaderHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) =>
      oldDelegate.child != child;
}
