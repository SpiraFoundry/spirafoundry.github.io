import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components/about_foundry_card.dart';
import '../components/founder_card.dart';
import '../components/icons.dart';
import '../components/project_grid.dart';
import '../data/site_content.dart';

class Home extends StatelessComponent {
  const Home({super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'page-stack', [
      // Ambient Atmospheric Radiant Shimmers
      div(classes: 'ambient-shimmers', [
        div(classes: 'shimmer-orb shimmer-orb--cyan', []),
        div(classes: 'shimmer-orb shimmer-orb--blue', []),
        div(classes: 'shimmer-orb shimmer-orb--violet', []),
      ]),

      // 1. About Spira Foundry (Hero Section)
      section(classes: 'container hero-section', [
        div(classes: 'hero-col-left', [
          div(classes: 'hero-heading-block', [
            h1(classes: 't-display-lg hero-title', [.text(SiteContent.heroTitle)]),
            p(classes: 't-body-lg hero-subtitle', [.text(SiteContent.heroSubtitle)]),
          ]),
          const AboutFoundryCard(),
          div(classes: 'hero-actions', [
            Link(
              to: '/projects',
              classes: 'btn-primary-glow',
              child: Component.fragment([
                const MaterialIcon('apps', size: 18),
                span([.text('Explore Projects')]),
              ]),
            ),
            Link(
              to: '/about',
              classes: 'btn-ghost t-body-md',
              child: Component.fragment([
                const MaterialIcon('group', size: 18),
                span([.text('About Us')]),
              ]),
            ),
          ]),
        ]),
      ]),

      // 2. Projects Section
      section(id: 'projects', classes: 'utilities-section', [
        div(classes: 'container', [
          const ProjectGrid(),
        ]),
      ]),

      // 3. About Us Section
      section(id: 'about-us', classes: 'container founders-section', [
        div(classes: 'section-stack', [
          div(classes: 'section-center-header', [
            h2(classes: 't-headline-lg section-heading', [.text(SiteContent.aboutUsHeading)]),
            p(classes: 't-body-md section-description', [.text(SiteContent.aboutUsDescription)]),
          ]),
          div(classes: 'founders-grid', [
            for (final founder in SiteContent.founders) FounderCard(founder: founder),
          ]),
        ]),
      ]),
    ]);
  }
}
