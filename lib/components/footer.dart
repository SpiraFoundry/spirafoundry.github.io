import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../data/site_content.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Component build(BuildContext context) {
    return footer(classes: 'site-footer', [
      div(classes: 'container site-footer__inner', [
        div(classes: 'site-footer__brand', [
          div(classes: 'site-footer__title-row', [
            span(classes: 't-headline-sm site-footer__title', [.text(SiteContent.orgName)]),
          ]),
          p(classes: 't-body-sm site-footer__tagline', [.text(SiteContent.footerTagline)]),
        ]),
        div(classes: 'site-footer__links', [
          for (final route in SiteContent.navRoutes)
            Link(
              to: route.path,
              classes: 'footer-link t-label-sm',
              child: Component.text(route.label.toUpperCase()),
            ),
          a(
            classes: 'footer-link t-label-sm',
            href: SiteContent.orgGithubUrl,
            target: Target.blank,
            attributes: const {'rel': 'noopener noreferrer'},
            [.text('GITHUB')],
          ),
        ]),
      ]),
    ]);
  }
}
