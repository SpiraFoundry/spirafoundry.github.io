import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/about_foundry_card.dart';
import '../components/founder_card.dart';
import '../data/site_content.dart';

class About extends StatelessComponent {
  const About({super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'page-stack', [
      div(classes: 'ambient-shimmers', [
        div(classes: 'shimmer-orb shimmer-orb--cyan', []),
        div(classes: 'shimmer-orb shimmer-orb--blue', []),
      ]),
      section(classes: 'container subpage-hero', [
        div(classes: 'subpage-hero__inner', [
          h1(classes: 't-display-lg hero-title', [.text('About Us')]),
          p(classes: 't-body-lg hero-subtitle', [.text(SiteContent.aboutUsDescription)]),
        ]),
      ]),
      section(classes: 'container subpage-section', [
        div(classes: 'section-stack', [
          const AboutFoundryCard(),
          div(classes: 'founders-grid', [
            for (final founder in SiteContent.founders) FounderCard(founder: founder),
          ]),
        ]),
      ]),
    ]);
  }
}
