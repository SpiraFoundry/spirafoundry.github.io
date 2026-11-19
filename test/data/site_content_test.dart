import 'dart:io';

import 'package:spira_foundry/data/site_content.dart';
import 'package:test/test.dart';

void main() {
  File resolveWebAsset(String relativeHref) {
    final decoded = Uri.decodeFull(relativeHref);
    return File.fromUri(Directory.current.uri.resolve('web/$decoded'));
  }

  group('SiteContent navigation', () {
    test('defines unique, valid navigation routes', () {
      expect(SiteContent.navRoutes, isNotEmpty);

      final paths = SiteContent.navRoutes.map((route) => route.path).toList();
      expect(paths.toSet().length, equals(paths.length));

      for (final route in SiteContent.navRoutes) {
        expect(route.label.trim(), isNotEmpty);
        expect(route.path, startsWith('/'));
      }

      expect(paths, containsAll(['/', '/projects']));
    });
  });

  group('SiteContent projects', () {
    test('defines valid project metadata and categories', () {
      expect(SiteContent.projects, isNotEmpty);

      final slugs = SiteContent.projects.map((p) => p.slug).toList();
      expect(slugs.toSet().length, equals(slugs.length));

      for (final project in SiteContent.projects) {
        expect(project.name.trim(), isNotEmpty);
        expect(project.slug.trim(), isNotEmpty);
        expect(project.statusLabel.trim(), isNotEmpty);
        expect(project.description.trim(), isNotEmpty);
        expect(project.tags, isNotEmpty);
        expect(project.repoUrl, startsWith('https://'));
        expect(project.detailsPath, startsWith('/'));
        expect(project.categories, contains(ProjectCategory.all));
        expect(project.categories.length, greaterThan(1));

        if (project.supportEmail case final email?) {
          expect(email, contains('@'));
        }
        if (project.privacyPolicyPath != null) {
          expect(project.privacyPolicyPath, startsWith('/'));
        }
        if (project.termsOfUsePath != null) {
          expect(project.termsOfUsePath, startsWith('/'));
        }
      }
    });

    test('filters projects by category', () {
      expect(SiteContent.projectsForCategory(ProjectCategory.all), equals(SiteContent.projects));
      expect(
        SiteContent.projectsForCategory(ProjectCategory.gaming).map((p) => p.slug),
        contains('spira-foundry/cains-codex'),
      );
      expect(SiteContent.projectsForCategory(ProjectCategory.cloud), isEmpty);
    });

    test('project slides contain complete copy and existing web assets', () {
      for (final project in SiteContent.projects) {
        if (project.iconImageSrc != null) {
          expect(
            resolveWebAsset(project.iconImageSrc!).existsSync(),
            isTrue,
            reason: 'Missing project icon asset: ${project.iconImageSrc}',
          );
        }

        for (final slide in project.slides) {
          expect(slide.tag.trim(), isNotEmpty);
          expect(slide.title.trim(), isNotEmpty);
          expect(slide.description.trim(), isNotEmpty);

          if (slide.imageSrc != null) {
            expect(slide.features, isNotEmpty);
            expect(
              resolveWebAsset(slide.imageSrc!).existsSync(),
              isTrue,
              reason: 'Missing slide screenshot asset: ${slide.imageSrc}',
            );
          }
        }
      }
    });
  });

  group('SiteContent founders', () {
    test('defines valid creator profiles and initials', () {
      expect(SiteContent.founders.length, equals(2));

      for (final founder in SiteContent.founders) {
        expect(founder.name.trim(), isNotEmpty);
        expect(founder.initials.length, equals(2));
        expect(founder.initials, equals(founder.initials.toUpperCase()));
        expect(founder.role.trim(), isNotEmpty);
        expect(founder.summary.trim(), isNotEmpty);
        expect(founder.githubUrl, startsWith('https://'));
      }
    });
  });

  group('Core web assets', () {
    test('logo, favicon, stylesheet, and shader assets exist under web/', () {
      final requiredAssets = [
        SiteContent.orgLogoSrc,
        'favicon.ico',
        'favicon-32x32.png',
        'apple-touch-icon.png',
        'images/spira-foundry-logos/sf-svg-5.svg',
        'styles.css',
        'js/shader.js',
      ];

      for (final asset in requiredAssets) {
        expect(
          resolveWebAsset(asset).existsSync(),
          isTrue,
          reason: 'Missing required web asset: web/$asset',
        );
      }
    });
  });
}
