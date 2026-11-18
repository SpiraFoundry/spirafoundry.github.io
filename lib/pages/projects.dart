import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components/icons.dart';
import '../components/project_carousel.dart';
import '../components/project_filters.dart';
import '../components/project_icon.dart';
import '../data/site_content.dart';

class ProjectsPage extends StatefulComponent {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  ProjectCategory selected = ProjectCategory.all;

  @override
  Component build(BuildContext context) {
    final visibleProjects = SiteContent.projectsForCategory(selected);

    return div(classes: 'page-stack', [
      div(classes: 'ambient-shimmers', [
        div(classes: 'shimmer-orb shimmer-orb--cyan', []),
        div(classes: 'shimmer-orb shimmer-orb--blue', []),
      ]),
      section(classes: 'container subpage-hero', [
        div(classes: 'utilities-header', [
          div(classes: 'subpage-hero__inner', [
            h1(classes: 't-display-lg hero-title', [.text('Projects')]),
            p(classes: 't-body-lg hero-subtitle', [.text(SiteContent.projectsDescription)]),
          ]),
          ProjectFilterTabs(
            selected: selected,
            onSelect: (category) {
              setState(() {
                selected = category;
              });
            },
          ),
        ]),
      ]),
      section(classes: 'container subpage-section', [
        div(classes: 'section-stack', [
          if (visibleProjects.isEmpty)
            ProjectEmptyState(category: selected)
          else
            for (final project in visibleProjects)
              article(key: ValueKey(project.slug), classes: 'project-showcase-card', [
                div(classes: 'project-showcase-header', [
                  div(classes: 'project-identity', [
                    ProjectIcon(project: project, fallbackIconSize: 28),
                    div(classes: 'project-names', [
                      div(classes: 'founder-name-row', [
                        h2(classes: 't-headline-lg project-names__title', [.text(project.name)]),
                        span(classes: 'status-badge t-label-sm ${project.statusBadgeClass}', [
                          .text(project.statusLabel),
                        ]),
                      ]),
                    ]),
                  ]),
                  div(classes: 'project-showcase-actions', [
                    a(
                      classes: 'btn-ghost t-label-md',
                      href: project.repoUrl,
                      target: Target.blank,
                      attributes: const {'rel': 'noopener noreferrer'},
                      [
                        const MaterialIcon('code', size: 16),
                        span([.text('GitHub Repo')]),
                      ],
                    ),
                    if (project.privacyPolicyPath case final policyPath?)
                      Link(
                        to: policyPath,
                        classes: 'btn-elevated t-label-md',
                        child: Component.fragment([
                          const MaterialIcon('shield', size: 16),
                          span([.text('Privacy Policy')]),
                        ]),
                      ),
                    if (project.termsOfUsePath case final termsPath?)
                      Link(
                        to: termsPath,
                        classes: 'btn-elevated t-label-md',
                        child: Component.fragment([
                          const MaterialIcon('description', size: 16),
                          span([.text('Terms of Use')]),
                        ]),
                      ),
                    if (project.supportEmail case final email?)
                      a(
                        classes: 'btn-elevated t-label-md',
                        href: 'mailto:$email',
                        [
                          const MaterialIcon('mail', size: 16),
                          span([.text('Support')]),
                        ],
                      ),
                  ]),
                ]),
                p(classes: 't-body-lg story-copy__body', [.text(project.description)]),
                div(classes: 'tag-row', [
                  for (final tag in project.tags) span(classes: 'tech-tag t-label-sm', [.text(tag)]),
                ]),
                if (project.slides.isNotEmpty) ProjectCarousel(projectSlug: project.slug),
                if (project.disclaimer case final disclaimerText?)
                  p(classes: 'project-disclaimer t-body-sm', [.text(disclaimerText)]),
              ]),
        ]),
      ]),
    ]);
  }
}
