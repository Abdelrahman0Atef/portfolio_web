/// Represents a portfolio project entry.
class Project {
  final String name;
  final String tagline;
  final String description;
  final List<String> tech;
  final List<String> highlights;
  final ProjectPlatforms platforms;
  final String role; // e.g. "Solo developer", "Team contributor"
  final String category; // e.g. "E-commerce", "Healthcare"

  /// Optional path to an image asset rendered as the card thumbnail and detail-dialog hero.
  final String? image;

  final List<String> gallery;

  const Project({
    required this.name,
    required this.tagline,
    required this.description,
    required this.tech,
    required this.highlights,
    required this.role,
    required this.category,
    this.platforms = const ProjectPlatforms(),
    this.image,
    this.gallery = const [],
  });
}

class ProjectPlatforms {
  final bool googlePlay;
  final bool appStore;

  /// Optional store URLs.
  final String? googlePlayUrl;
  final String? appStoreUrl;

  const ProjectPlatforms({
    this.googlePlay = false,
    this.appStore = false,
    this.googlePlayUrl,
    this.appStoreUrl,
  });

  bool get hasAny => googlePlay || appStore;
}
