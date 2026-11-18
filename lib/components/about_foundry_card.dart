import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../data/site_content.dart';

class AboutFoundryCard extends StatelessComponent {
  const AboutFoundryCard({super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'glass-card', [
      div(classes: 'glass-card__tint', []),
      div(classes: 'story-row', [
        div(classes: 'story-icon-box', [
          img(
            src: SiteContent.orgLogoSrc,
            alt: '${SiteContent.orgName} Logo',
            classes: 'story-icon-img',
          ),
        ]),
        div(classes: 'story-copy', [
          span(classes: 't-headline-sm story-copy__title', [.text(SiteContent.aboutSpiraTitle)]),
          p(classes: 't-body-md story-copy__body', [.text(SiteContent.aboutSpiraBody)]),
        ]),
      ]),
    ]);
  }
}
