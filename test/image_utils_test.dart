import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_web/core/image_utils.dart';
import 'package:portfolio_web/data/cv_data.dart';
import 'package:portfolio_web/widgets/avatar_orb.dart';
import 'package:portfolio_web/widgets/project_card.dart';
import 'package:portfolio_web/widgets/project_thumbnail.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('webSafeCacheWidth', () {
    test('returns null when isWeb is true to avoid WebGL black box issue', () {
      expect(webSafeCacheWidth(800, isWeb: true), isNull);
      expect(webSafeCacheWidth(280, isWeb: true), isNull);
      expect(webSafeCacheWidth(52, isWeb: true), isNull);
    });

    test('preserves cacheWidth when isWeb is false for mobile memory optimization', () {
      expect(webSafeCacheWidth(800, isWeb: false), 800);
      expect(webSafeCacheWidth(280, isWeb: false), 280);
      expect(webSafeCacheWidth(52, isWeb: false), 52);
    });

    test('returns null when given null width regardless of platform', () {
      expect(webSafeCacheWidth(null, isWeb: true), isNull);
      expect(webSafeCacheWidth(null, isWeb: false), isNull);
    });

    test('defaults isWeb parameter to kIsWeb', () {
      // In Dart VM test environment, kIsWeb is false
      expect(webSafeCacheWidth(800), kIsWeb ? isNull : 800);
    });
  });

  group('Asset Integrity', () {
    test('all project main images and gallery images exist on disk', () {
      for (final project in CvData.projects) {
        if (project.image != null) {
          final file = File(project.image!);
          expect(
            file.existsSync(),
            isTrue,
            reason: 'Project image missing: ${project.image}',
          );
        }
        for (final galleryImage in project.gallery) {
          final file = File(galleryImage);
          expect(
            file.existsSync(),
            isTrue,
            reason: 'Gallery image missing: $galleryImage',
          );
        }
      }
    });

    test('profile avatar image exists on disk', () {
      final file = File('assets/images/MyPic/01-profile.jpeg');
      expect(file.existsSync(), isTrue, reason: 'Profile image missing');
    });
  });

  group('ProjectThumbnail Widget', () {
    testWidgets('renders fallback art when image is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProjectThumbnail(
              image: null,
              index: 1,
              fallbackLabel: 'ECOMMERCE',
            ),
          ),
        ),
      );

      expect(find.text('01'), findsOneWidget);
      expect(find.text('ECOMMERCE'), findsOneWidget);
      expect(find.byType(Image), findsNothing);
    });

    testWidgets('renders Image widget when image path is provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProjectThumbnail(
              image: 'assets/images/almasryIntegration/01-dashboard-order-status.png',
              index: 1,
              fallbackLabel: 'ECOMMERCE',
            ),
          ),
        ),
      );

      final imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);

      final imageWidget = tester.widget<Image>(imageFinder);
      expect(imageWidget.fit, BoxFit.contain);
    });
  });

  group('ProjectCard Widget', () {
    testWidgets('renders project card with thumbnail and gallery preview', (tester) async {
      final project = CvData.projects.first;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                width: 400,
                height: 600,
                child: ProjectCard(
                  project: project,
                  index: 1,
                  thumbHeight: 280,
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('AlMasry Integration'), findsOneWidget);
      expect(find.byType(ProjectThumbnail), findsOneWidget);
    });
  });

  group('AvatarOrb Widget', () {
    testWidgets('renders AvatarOrb with image path without error', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AvatarOrb(
              size: 100,
              imagePath: 'assets/images/MyPic/01-profile.jpeg',
            ),
          ),
        ),
      );

      expect(find.byType(AvatarOrb), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });
  });
}
