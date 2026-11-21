/// Centralized site copy, projects, creator profiles, and navigation
/// for Spira Foundry.
library;

enum ProjectCategory {
  all('All Projects'),
  gaming('Gaming'),
  cloud('Cloud Tooling');

  const ProjectCategory(this.label);
  final String label;
}

class NavRouteItem {
  const NavRouteItem({
    required this.label,
    required this.path,
  });

  final String label;
  final String path;
}

class ProjectSlide {
  const ProjectSlide({
    required this.tag,
    required this.title,
    this.captionTitle,
    required this.description,
    required this.features,
    this.imageSrc,
  });

  final String tag;
  final String title;
  final String? captionTitle;
  final String description;
  final List<String> features;
  final String? imageSrc;
}

class ProjectEntry {
  const ProjectEntry({
    required this.name,
    required this.slug,
    required this.statusLabel,
    this.statusBadgeClass = 'status-badge--active',
    required this.icon,
    this.iconImageSrc,
    required this.description,
    required this.tags,
    required this.repoUrl,
    required this.categories,
    this.detailsPath = '/projects',
    this.supportEmail,
    this.privacyPolicyPath,
    this.termsOfUsePath,
    this.disclaimer,
    this.slides = const [],
  });

  final String name;
  final String slug;
  final String statusLabel;
  final String statusBadgeClass;
  final String icon;
  final String? iconImageSrc;
  final String description;
  final List<String> tags;
  final String repoUrl;
  final List<ProjectCategory> categories;
  final String detailsPath;
  final String? supportEmail;
  final String? privacyPolicyPath;
  final String? termsOfUsePath;
  final String? disclaimer;
  final List<ProjectSlide> slides;
}

class FounderEntry {
  const FounderEntry({
    required this.name,
    required this.initials,
    required this.role,
    required this.summary,
    required this.githubUrl,
    required this.accentCyan,
    this.avatarUrl,
  });

  final String name;
  final String initials;
  final String role;
  final String summary;
  final String githubUrl;
  final bool accentCyan;
  final String? avatarUrl;
}

abstract final class SiteContent {
  static const orgName = 'Spira Foundry';
  static const orgLogoSrc = 'images/spira-foundry-logos/sf-svg-6.svg';
  static const orgGithubUrl = 'https://github.com/SpiraFoundry';
  static const cainsCodexSupportEmail = 'spirafoundry.support+cainscodex@gmail.com';

  static const navRoutes = [
    NavRouteItem(label: 'Home', path: '/'),
    NavRouteItem(label: 'Projects', path: '/projects'),
  ];

  // About Spira Foundry (Hero)
  static const heroTitle = 'Spira Foundry';
  static const heroSubtitle =
      'An independent software duo building focused, lightweight tools and applications with clean interfaces and thoughtful design.';

  static const aboutSpiraTitle = 'About Spira Foundry';
  static const aboutSpiraBody =
      'Spira Foundry is a small software duo: two friends who love building projects together. We focus on crafting clean, performant, and delightful utility applications.';

  // Projects Section
  static const projectsHeading = 'Published Projects';
  static const projectsDescription = 'Apps and utilities we are building together.';

  static const projects = [
    ProjectEntry(
      name: "Cain's Codex",
      slug: 'spira-foundry/cains-codex',
      statusLabel: 'Coming Soon',
      statusBadgeClass: 'status-badge--beta',
      icon: 'auto_awesome',
      description: 'An upcoming companion application currently in development. More details coming soon.',
      tags: ['Coming Soon', 'macOS · Windows'],
      repoUrl: orgGithubUrl,
      categories: [ProjectCategory.all, ProjectCategory.gaming],
      detailsPath: '/projects',
      supportEmail: cainsCodexSupportEmail,
      privacyPolicyPath: '/cains-codex/privacy-policy',
      termsOfUsePath: '/cains-codex/terms-of-use',
      disclaimer: "Copyright © 2026 Adam M. All Rights Reserved. Cain's Codex is an unofficial fan-made companion application and is not affiliated with, endorsed, or sponsored by Blizzard Entertainment, Inc. Diablo II and Diablo II: Resurrected are trademarks or registered trademarks of Blizzard Entertainment, Inc.",
      slides: [
        ProjectSlide(
          tag: 'COMING SOON',
          title: 'Preview & Feature Showcase',
          captionTitle: 'Preview Details',
          description: "Screenshots and full feature details for Cain's Codex will be published here closer to launch.",
          features: [],
        ),
      ],
    ),
  ];

  // About Us Section
  static const aboutUsHeading = 'About';
  static const aboutUsDescription = 'Two friends building thoughtful, lightweight software together.';

  static const founders = [
    FounderEntry(
      name: 'Adam Moas',
      initials: 'AM',
      role: 'Co-Creator & Engineer',
      summary: 'Engineer with a background in quality engineering, performance and deployment testing, UI frontend and backend automation, microservices, and cloud infrastructure. Enjoys building developer tooling and lightweight utilities with clean, responsive interfaces.',
      githubUrl: orgGithubUrl,
      accentCyan: true,
    ),
    FounderEntry(
      name: 'Dale Smith',
      initials: 'DS',
      role: 'Co-Creator & Scientist',
      summary: 'Scientist and educator with a background in academia. Bringing experience from mathematics and physics to the tech industry. Passionate about optimising algorithms and exploring novel solutions to problems.',
      githubUrl: orgGithubUrl,
      accentCyan: false,
    ),
  ];

  // Footer
  static const footerTagline = 'Independent Software Duo';

  static List<ProjectEntry> projectsForCategory(ProjectCategory category) {
    return projects.where((project) => project.categories.contains(category)).toList(growable: false);
  }
}
