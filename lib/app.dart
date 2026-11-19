import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/footer.dart';
import 'components/header.dart';
import 'data/site_content.dart';
import 'pages/home.dart';
import 'pages/legal_document.dart';
import 'pages/privacy_policy.dart';
import 'pages/projects.dart';
import 'utils/scroll_reset.dart';

@client
class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return Router(
      routes: [
        Route(
          path: '/cains-codex/privacy-policy',
          title: "Privacy Policy · Cain's Codex · ${SiteContent.orgName}",
          builder: (context, state) => const PrivacyPolicyPage(
            projectName: "Cain's Codex",
            effectiveDate: '2026-11-14',
            contactEmail: SiteContent.cainsCodexSupportEmail,
            summary: "Cain's Codex is a 100% offline companion app for Diablo II: Resurrected built with zero network calls, zero analytics, and no user accounts.",
            sections: [
              (
                heading: 'Data Collection',
                body: "Cain's Codex runs 100% offline with zero network calls. It does not collect, sell, or transmit personal data, usage analytics, crash telemetry, or tracking identifiers to external servers.",
              ),
              (
                heading: 'Local Storage',
                body: 'Every stash edit, wishlist item, crafted badge, selected theme (Codex or Classic), and custom keyboard shortcut is auto-saved locally on your device under your control.',
              ),
              (
                heading: 'Third-Party Services & Storefronts',
                body: "Cain's Codex contains no third-party analytics, ad networks, or tracking SDKs. Storefronts you download the app from (such as the Microsoft Store) handle download, billing, and update activity under their own privacy policies.",
              ),
              (
                heading: "Children's Privacy",
                body: "Cain's Codex does not collect or solicit personal information from anyone, including children of any age.",
              ),
              (
                heading: 'Policy Updates',
                body: 'Any updates to this Privacy Policy will be posted on this page with a revised effective date.',
              ),
              (
                heading: 'Contact',
                body: 'Questions about this policy?',
              ),
            ],
          ),
        ),
        Route(
          path: '/cains-codex/terms-of-use',
          title: "Terms of Use · Cain's Codex · ${SiteContent.orgName}",
          builder: (context, state) => const LegalDocumentPage(
            projectName: "Cain's Codex",
            documentType: 'Terms of Use',
            topbarTag: 'Legal & Terms',
            effectiveDate: '2026-11-14',
            contactEmail: SiteContent.cainsCodexSupportEmail,
            summary: "These Terms of Use govern your use of Cain's Codex, an offline-first companion application for Diablo II: Resurrected distributed for macOS and Windows, including builds obtained via the Microsoft Store. By installing or using the application, you agree to these terms.",
            sections: [
              (
                heading: 'License & Permitted Use',
                body: "Copyright © 2026 Adam M. All Rights Reserved. You are granted a personal, non-exclusive, non-transferable, revocable license to install and use Cain's Codex on supported devices in accordance with applicable storefront rules (including the Microsoft Store Standard Application License Terms when distributed through the Microsoft Store) and these Terms.",
              ),
              (
                heading: 'Unofficial Companion & Trademark Notice',
                body: "Cain's Codex is an unofficial fan-made companion application and is not affiliated with, endorsed, or sponsored by Blizzard Entertainment, Inc. Diablo II and Diablo II: Resurrected are trademarks or registered trademarks of Blizzard Entertainment, Inc.",
              ),
              (
                heading: 'Restrictions',
                body: "You may not redistribute, sell, rent, sublicense, or use Cain's Codex for unlawful purposes, except as expressly permitted by an applicable storefront agreement.",
              ),
              (
                heading: 'Intellectual Property',
                body: "Cain's Codex, its original artwork, documentation, and assets remain the property of Adam M. Third-party and open-source components remain governed by their respective licenses.",
              ),
              (
                heading: 'Third-Party Storefronts',
                body: 'When downloaded via the Microsoft Store or another third-party distribution platform, that platform’s terms of sale, update mechanisms, and developer policies also apply to your acquisition and use of the application.',
              ),
              (
                heading: 'Disclaimer of Warranties',
                body: "Cain's Codex is provided \"as is\" and \"as available\" without warranties of any kind, express, implied, or statutory, including implied warranties of merchantability, fitness for a particular purpose, and non-infringement, to the maximum extent permitted by law.",
              ),
              (
                heading: 'Limitation of Liability',
                body: "To the fullest extent permitted by applicable law, Adam M., Spira Foundry, and contributors shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of data or profits arising from your use of or inability to use Cain's Codex.",
              ),
              (
                heading: 'Updates & Changes to Terms',
                body: "We keep the latest Terms of Use posted on this page as Cain's Codex or storefront requirements evolve. Updated terms apply to new downloads and updated builds (including via the Microsoft Store) as of the effective date shown above.",
              ),
              (
                heading: 'Contact',
                body: 'Questions about these Terms of Use?',
              ),
            ],
          ),
        ),
        ShellRoute(
          builder: (context, state, child) => _RouteShell(
            location: state.location,
            child: child,
          ),
          routes: [
            Route(
              path: '/',
              title: SiteContent.orgName,
              builder: (context, state) => const Home(),
            ),
            Route(
              path: '/projects',
              title: 'Projects · ${SiteContent.orgName}',
              builder: (context, state) => const ProjectsPage(),
            ),
          ],
        ),
      ],
    );
  }
}

class _RouteShell extends StatefulComponent {
  const _RouteShell({
    required this.location,
    required this.child,
  });

  final String location;
  final Component child;

  @override
  State<_RouteShell> createState() => _RouteShellState();
}

class _RouteShellState extends State<_RouteShell> {
  @override
  void didUpdateComponent(_RouteShell oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (component.location != oldComponent.location) {
      scrollToTop();
    }
  }

  @override
  Component build(BuildContext context) {
    return div(classes: 'app-shell', [
      div(classes: 'shader-backdrop', [
        div(classes: 'shader-canvas-wrap', [
          Component.element(
            tag: 'canvas',
            id: 'shader-canvas-ANIMATION_13',
            classes: 'shader-canvas',
          ),
        ]),
        div(classes: 'shader-fade', []),
      ]),
      Header(activePath: component.location),
      main_(classes: 'site-main', [component.child]),
      const Footer(),
    ]);
  }
}
