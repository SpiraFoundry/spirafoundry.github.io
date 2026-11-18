import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../data/site_content.dart';
import 'icons.dart';

class FounderCard extends StatelessComponent {
  const FounderCard({
    required this.founder,
    super.key,
  });

  final FounderEntry founder;

  @override
  Component build(BuildContext context) {
    final orbClass = founder.accentCyan
        ? 'founder-card__orb founder-card__orb--cyan'
        : 'founder-card__orb founder-card__orb--blue';
    final avatarClass = founder.accentCyan
        ? 'founder-avatar founder-avatar--cyan'
        : 'founder-avatar founder-avatar--blue';

    return article(classes: 'founder-card', [
      div(classes: orbClass, []),
      div(classes: 'founder-card__content', [
        div(classes: 'founder-card__header', [
          div(classes: 'founder-identity', [
            div(classes: avatarClass, [
              if (founder.avatarUrl case final url?)
                img(src: url, alt: founder.name, classes: 'w-full h-full')
              else
                span(classes: 'founder-avatar__initials', [.text(founder.initials)]),
            ]),
            div(classes: 'founder-meta', [
              div(classes: 'founder-name-row', [
                span(classes: 't-headline-md founder-name', [.text(founder.name)]),
              ]),
              span(classes: 't-label-sm founder-role', [.text(founder.role)]),
            ]),
          ]),
          a(
            classes: 'icon-btn',
            href: founder.githubUrl,
            target: Target.blank,
            attributes: {
              'rel': 'noopener noreferrer',
              'aria-label': '${founder.name} on GitHub',
            },
            [const MaterialIcon('code', size: 18)],
          ),
        ]),
        p(classes: 't-body-md story-copy__body', [.text(founder.summary)]),
      ]),
    ]);
  }
}
