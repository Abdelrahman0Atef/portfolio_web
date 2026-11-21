import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_web/core/theme/app_theme.dart';
import 'package:portfolio_web/data/cv_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('CvData has valid identity and experiences', () {
    expect(CvData.name, isNotEmpty);
    expect(CvData.role, isNotEmpty);
    expect(CvData.experiences, isNotEmpty);
    expect(CvData.experiences.first.company, 'Croco IT');
    expect(CvData.experiences.first.period, 'Feb 2025 — Oct 2026');
    expect(CvData.experiences.first.isCurrent, isFalse);
  });

  test('AppTheme dark returns valid theme', () {
    final theme = AppTheme.dark();
    expect(theme.brightness, isNotNull);
  });
}
