import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../data/site_content.dart';
import 'icons.dart';
import 'mobile_nav.dart';

class Header extends StatelessComponent {
  const Header({this.activePath, super.key});

  final String? activePath;

  bool _isRouteActive(String activePath, String routePath) {
    if (routePath.contains('#')) {
      return false;
    }
    if (routePath == '/') {
      return activePath == '/' || activePath.isEmpty;
    }
    return activePath == routePath || activePath.startsWith('$routePath/');
  }

  @override
  Component build(BuildContext context) {
    final currentPath = activePath ?? context.url;

    return header(classes: 'site-header', [
      div(classes: 'container site-header__inner', [
        Link(
          to: '/',
          classes: 'brand-link',
          child: Component.fragment([
            img(
              src: SiteContent.orgLogoSrc,
              alt: '${SiteContent.orgName} Logo',
              classes: 'brand-link__emblem',
            ),
            span(classes: 'brand-link__title', [.text(SiteContent.orgName)]),
          ]),
        ),
        nav(
          classes: 'main-nav',
          attributes: const {'aria-label': 'Primary Navigation'},
          [
            for (final route in SiteContent.navRoutes)
              Link(
                to: route.path,
                classes: _isRouteActive(currentPath, route.path) ? 'main-nav__link is-active' : 'main-nav__link',
                attributes: _isRouteActive(currentPath, route.path) ? const {'aria-current': 'page'} : null,
                child: Component.text(route.label),
              ),
          ],
        ),
        div(classes: 'header-actions', [
          a(
            classes: 'github-pill t-label-md',
            href: SiteContent.orgGithubUrl,
            target: Target.blank,
            attributes: const {'rel': 'noopener noreferrer'},
            [
              const MaterialIcon('terminal', size: 16),
              span([.text('GitHub')]),
            ],
          ),
          MobileNav(activePath: currentPath),
        ]),
      ]),
    ]);
  }
}
