import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../data/site_content.dart';
import 'icons.dart';
import 'project_icon.dart';

class ProjectCard extends StatelessComponent {
  const ProjectCard({
    required this.project,
    super.key,
  });

  final ProjectEntry project;

  @override
  Component build(BuildContext context) {
    return article(classes: 'project-card', [
      div(classes: 'project-card__body', [
        div(classes: 'project-identity', [
          ProjectIcon(project: project),
          div(classes: 'project-names', [
            h3(classes: 't-headline-md project-names__title', [.text(project.name)]),
          ]),
        ]),
        p(classes: 't-body-md project-description', [.text(project.description)]),
        div(classes: 'tag-row', [
          for (final tag in project.tags) span(classes: 'tech-tag t-label-sm', [.text(tag)]),
        ]),
      ]),
      div(classes: 'project-card__footer', [
        a(
          classes: 'card-link-muted t-label-md',
          href: project.repoUrl,
          target: Target.blank,
          attributes: const {'rel': 'noopener noreferrer'},
          [
            const MaterialIcon('code', size: 16),
            span([.text('GitHub Repo')]),
          ],
        ),
        div(classes: 'project-card__footer-right', [
          if (project.privacyPolicyPath case final policyPath?)
            Link(
              to: policyPath,
              classes: 'card-link-muted t-label-md',
              child: span([.text('Privacy')]),
            ),
          if (project.termsOfUsePath case final termsPath?)
            Link(
              to: termsPath,
              classes: 'card-link-muted t-label-md',
              child: span([.text('Terms')]),
            ),
          if (project.supportEmail case final email?)
            a(
              href: 'mailto:$email',
              classes: 'card-link-muted t-label-md',
              [
                span([.text('Support')]),
              ],
            ),
          Link(
            to: project.detailsPath,
            classes: 'card-link-cyan t-label-md',
            child: Component.fragment([
              span([.text('View Project')]),
              const MaterialIcon('arrow_outward', size: 16),
            ]),
          ),
        ]),
      ]),
    ]);
  }
}
