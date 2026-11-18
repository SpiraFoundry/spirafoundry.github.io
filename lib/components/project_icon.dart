import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../data/site_content.dart';
import 'icons.dart';

class ProjectIcon extends StatelessComponent {
  const ProjectIcon({
    required this.project,
    this.fallbackIconSize = 26,
    super.key,
  });

  final ProjectEntry project;
  final int fallbackIconSize;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'project-icon-box',
      [
        if (project.iconImageSrc case final iconSrc?)
          img(
            src: iconSrc,
            alt: '${project.name} icon',
            classes: 'project-icon-img',
          )
        else
          MaterialIcon(project.icon, size: fallbackIconSize),
      ],
    );
  }
}
