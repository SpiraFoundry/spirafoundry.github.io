import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../data/site_content.dart';
import 'project_card.dart';
import 'project_filters.dart';

class ProjectGrid extends StatefulComponent {
  const ProjectGrid({super.key});

  @override
  State<ProjectGrid> createState() => _ProjectGridState();
}

class _ProjectGridState extends State<ProjectGrid> {
  ProjectCategory selected = ProjectCategory.all;

  @override
  Component build(BuildContext context) {
    final visibleProjects = SiteContent.projectsForCategory(selected);

    return div(classes: 'section-stack', [
      div(classes: 'utilities-header', [
        div(classes: 'section-title-group', [
          h2(classes: 't-headline-lg section-heading', [.text(SiteContent.projectsHeading)]),
          p(classes: 't-body-md section-description', [.text(SiteContent.projectsDescription)]),
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
      if (visibleProjects.isEmpty)
        ProjectEmptyState(category: selected)
      else
        div(classes: 'projects-grid', [
          for (final project in visibleProjects) ProjectCard(key: ValueKey(project.slug), project: project),
        ]),
    ]);
  }
}
