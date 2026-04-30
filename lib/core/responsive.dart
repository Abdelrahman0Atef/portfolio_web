import 'package:flutter/widgets.dart';

/// Responsive breakpoints.
class Breakpoints {
  Breakpoints._();

  /// Pure phones — single column, compressed type.
  static const double sm = 640;

  /// Large phones / small tablets — single column, comfortable.
  static const double md = 900;

  /// Tablets / small laptops — sidebar nav appears, two-column projects.
  static const double lg = 1180;

  /// Desktops — sidebar nav and full grid.
  static const double xl = 1440;

  static const double wideThreshold = 1700;
}

enum ScreenSize { sm, md, lg, xl }

extension ScreenSizeX on BuildContext {
  /// Current screen-size bucket.
  ScreenSize get screen {
    final w = MediaQuery.of(this).size.width;
    if (w < Breakpoints.sm) return ScreenSize.sm;
    if (w < Breakpoints.md) return ScreenSize.md;
    if (w < Breakpoints.lg) return ScreenSize.lg;
    return ScreenSize.xl;
  }

  bool get isPhone => screen == ScreenSize.sm || screen == ScreenSize.md;
  bool get isCompact => screen == ScreenSize.sm;
  bool get isDesktop => screen == ScreenSize.lg || screen == ScreenSize.xl;

  /// Pick a value that varies by screen size. Falls through from xl to sm.
  T responsive<T>({required T sm, T? md, T? lg, T? xl}) {
    switch (screen) {
      case ScreenSize.xl:
        return xl ?? lg ?? md ?? sm;
      case ScreenSize.lg:
        return lg ?? md ?? sm;
      case ScreenSize.md:
        return md ?? sm;
      case ScreenSize.sm:
        return sm;
    }
  }

  /// Horizontal page padding that scales with the viewport.
  EdgeInsets get pagePadding {
    final width = MediaQuery.of(this).size.width;

    // Base padding per breakpoint.
    final base = responsive<double>(
      sm: 18,
      md: 28,
      lg: 44,
      xl: 60,
    );

    if (width > Breakpoints.wideThreshold) {
      final extra = (width - Breakpoints.wideThreshold) * 0.05;
      return EdgeInsets.symmetric(horizontal: base + extra);
    }

    return EdgeInsets.symmetric(horizontal: base);
  }
}

class ContentColumn extends StatelessWidget {
  final Widget child;

  /// Optional max width.
  final double? maxWidth;

  const ContentColumn({super.key, required this.child, this.maxWidth});

  @override
  Widget build(BuildContext context) {
    final padded = Padding(
      padding: context.pagePadding,
      child: child,
    );

    // No maxWidth → fluid: take the full viewport width.
    if (maxWidth == null) {
      return SizedBox(width: double.infinity, child: padded);
    }

    // Constrained variant — only when a section explicitly opts in.
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth!),
        child: padded,
      ),
    );
  }
}
