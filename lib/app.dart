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
            effectiveDate: '2026-11-20',
            contactEmail: SiteContent.cainsCodexSupportEmail,
            summary: "Cain's Codex, published by Adam M., is an unofficial, offline-first companion app for Diablo II: Resurrected. It is designed to run locally on your device without requiring an internet connection, does not include any analytics SDKs, and requires no user account sign-ups. This Privacy Policy explains how your local app data is handled and what platform-level information Microsoft may independently collect when you install or use the app through the Microsoft Store.",
            sections: [
              (
                heading: 'Data Collection',
                body: "Cain's Codex itself operates 100% offline with zero network calls. The application contains no analytics, advertising, or crash-reporting SDKs and does not collect, transmit, sell, or share personal data or tracking identifiers.",
              ),
              (
                heading: 'Local Storage & Data Removal',
                body: "Every stash edit, wishlist item, crafted badge, selected theme, and custom keyboard shortcut is stored locally on your device.\n\nYou can clear locally stored app data directly within Cain's Codex using the provided options in the Settings screen.",
              ),
              (
                heading: 'Microsoft Store & Windows Platform Diagnostics',
                body: "When you install or use Cain's Codex through the Microsoft Store on Windows, Microsoft may independently collect store and operating system diagnostic information, including app acquisitions, aggregated active-device and session usage metrics, and crash or unresponsiveness reports via Windows Error Reporting.\n\nMicrosoft makes aggregated and anonymized summaries of these metrics (Acquisitions, Usage, and Health reports, along with public Store Ratings & Reviews) available to Adam M. through Microsoft Partner Center solely to monitor app reliability, compatibility, and performance, never direct personally identifiable user records from the app. This platform-level collection is governed by the [Microsoft Privacy Statement](https://privacy.microsoft.com/). You can review and manage your Windows diagnostic data preferences at any time under Windows Settings → Privacy & security → Diagnostics & feedback.",
              ),
              (
                heading: 'Support Inquiries & Website Hosting',
                body: 'If you email support or open an issue on GitHub, we receive the email address, display name, and message details you choose to provide. Support correspondence is used solely to respond to your inquiry, is never sold or shared for marketing, and is deleted upon request.\n\nThis Privacy Policy page is hosted on GitHub Pages, which automatically processes standard HTTP request metadata (such as IP address, user-agent, and request timestamp) to deliver and secure the site under the [GitHub Privacy Statement](https://docs.github.com/en/site-policy/privacy-policies/github-general-privacy-statement).',
              ),
              (
                heading: "Children's Privacy",
                body: "Cain's Codex does not collect or solicit personal information from anyone, including children of any age.",
              ),
              (
                heading: 'Data Retention & Policy Updates',
                body: "Local app data remains on your device until you clear or uninstall the app. Platform-level metrics surfaced in Microsoft Partner Center are retained by Microsoft according to its retention schedules, and support correspondence is kept only as long as needed to resolve your request.\n\nWe may update this Privacy Policy from time to time as Cain's Codex, storefront requirements, or applicable laws evolve. Any updates will be posted at this URL with a revised effective date and take effect when posted. We encourage you to review this page periodically.",
              ),
              (
                heading: 'Contact',
                body: 'Questions about this Privacy Policy or requests to delete support correspondence?',
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
