/// Represents a single work experience entry.
class Experience {
  final String company;
  final String role;
  final String period;
  final String? location;
  final List<String> bullets;
  final bool isCurrent;

  const Experience({
    required this.company,
    required this.role,
    required this.period,
    required this.bullets,
    this.location,
    this.isCurrent = false,
  });
}
