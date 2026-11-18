/// The entrypoint for the **server** environment.
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

import 'app.dart';
import 'data/site_content.dart';
import 'main.server.options.dart';

const _baseHref = String.fromEnvironment('BASE_HREF', defaultValue: '/');

void main() {
  Jaspr.initializeApp(
    options: defaultServerOptions,
  );

  runApp(
    Document(
      title: SiteContent.orgName,
      lang: 'en',
      base: _baseHref,
      meta: const {
        'description': SiteContent.heroSubtitle,
      },
      head: [
        const link(rel: 'icon', type: 'image/svg+xml', href: 'images/spira-foundry-logos/sf-svg-5.svg'),
        const link(rel: 'icon', type: 'image/png', attributes: {'sizes': '32x32'}, href: 'favicon-32x32.png'),
        const link(rel: 'shortcut icon', href: 'favicon.ico'),
        const link(rel: 'apple-touch-icon', attributes: {'sizes': '180x180'}, href: 'apple-touch-icon.png'),
        const link(rel: 'preconnect', href: 'https://fonts.googleapis.com'),
        const link(
          rel: 'preconnect',
          href: 'https://fonts.gstatic.com',
          attributes: {'crossorigin': ''},
        ),
        const link(
          rel: 'stylesheet',
          href: 'https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600&family=Plus+Jakarta+Sans:wght@400;500;600;700&family=Sora:wght@600;700&display=swap',
        ),
        const link(
          rel: 'stylesheet',
          href: 'https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&display=swap',
        ),
        const link(rel: 'stylesheet', href: 'styles.css'),
        const script(src: 'js/shader.js', defer: true),
      ],
      body: const App(),
    ),
  );
}
