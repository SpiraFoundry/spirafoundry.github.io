import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../data/site_content.dart';
import 'icons.dart';

class MobileNav extends StatefulComponent {
  const MobileNav({
    required this.activePath,
    super.key,
  });

  final String activePath;

  @override
  State<MobileNav> createState() => _MobileNavState();
}

class _MobileNavState extends State<MobileNav> {
  bool isOpen = false;

  @override
  void didUpdateComponent(MobileNav oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (component.activePath != oldComponent.activePath && isOpen) {
      isOpen = false;
    }
  }

  @override
  Component build(BuildContext context) {
    return div(classes: 'mobile-nav-wrap', [
      button(
        classes: 'mobile-menu-btn',
        attributes: {
          'aria-label': isOpen ? 'Close navigation menu' : 'Open navigation menu',
          'aria-expanded': isOpen ? 'true' : 'false',
        },
        onClick: () {
          setState(() {
            isOpen = !isOpen;
          });
        },
        [MaterialIcon(isOpen ? 'close' : 'menu', size: 20)],
      ),
      if (isOpen)
        nav(classes: 'mobile-drawer', [
          for (final route in SiteContent.navRoutes)
            Link(
              to: route.path,
              classes: component.activePath == route.path ? 'mobile-drawer__link is-active' : 'mobile-drawer__link',
              child: Component.text(route.label),
            ),
          a(
            classes: 'mobile-drawer__link',
            href: SiteContent.orgGithubUrl,
            target: Target.blank,
            attributes: const {'rel': 'noopener noreferrer'},
            [.text('View on GitHub ↗')],
          ),
        ]),
    ]);
  }
}
