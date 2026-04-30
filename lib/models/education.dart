/// Represents an education or certification entry.
class Education {
  final String institution;
  final String degree;
  final String period;
  final List<String> notes;

  const Education({
    required this.institution,
    required this.degree,
    required this.period,
    this.notes = const [],
  });
}
