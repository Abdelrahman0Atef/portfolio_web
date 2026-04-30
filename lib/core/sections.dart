import 'package:flutter/widgets.dart';

/// Identifiers for each scrollable section.
enum SectionId { home, about, experience, projects, skills, contact }

class NavSection {
  final SectionId id;
  final String label;
  final GlobalKey key;
  NavSection(this.id, this.label) : key = GlobalKey(debugLabel: id.name);
}

class NavSections {
  static List<NavSection> create() => [
        NavSection(SectionId.home, 'Home'),
        NavSection(SectionId.about, 'About'),
        NavSection(SectionId.experience, 'Experience'),
        NavSection(SectionId.projects, 'Projects'),
        NavSection(SectionId.skills, 'Skills'),
        NavSection(SectionId.contact, 'Contact'),
      ];
}

Future<void> scrollToSection(
  GlobalKey key, {
  required ScrollController controller,
  double headerOffset = 68,
  Duration duration = const Duration(milliseconds: 650),
  Curve curve = Curves.easeInOutCubic,
}) async {
  final ctx = key.currentContext;
  if (ctx == null || !controller.hasClients) return;

  final renderBox = ctx.findRenderObject() as RenderBox?;
  if (renderBox == null) return;

  // Compute the target by adding the section's current screen-space Y to
  // the current scroll offset, then subtracting the sticky-header height.
  final position = renderBox.localToGlobal(Offset.zero).dy;
  final target = controller.offset + position - headerOffset;

  await controller.animateTo(
    target.clamp(0.0, controller.position.maxScrollExtent),
    duration: duration,
    curve: curve,
  );
}
