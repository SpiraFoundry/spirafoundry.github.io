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
            effectiveDate: '2026-11-24',
            contactEmail: SiteContent.cainsCodexSupportEmail,
            summary: "This Privacy Policy covers both the Cain's Codex companion app (published by Adam M.) and the Cain's Codex web pages and support resources on the Spira Foundry website (spirafoundry.github.io). Cain's Codex works offline without requiring an internet connection or user account. Below, we explain how local app data, Microsoft Store diagnostics, website visits, support emails, and your privacy rights are handled.",
            sections: [
              (
                heading: 'App Data Collection',
                body: "Cain's Codex does not require an internet connection, does not require account registration or sign-in, and does not track you, show ads, or collect personal data from within the app.",
              ),
              (
                heading: 'Local Storage & Data Removal',
                body: "All of your app preferences, settings, and progression data (such as stash tracking, wishlists, crafted badges, themes, and custom shortcuts) are stored only on your own device. Adam M. cannot access, view, or back up this local data.\n\nYou are always in control of your local data. To erase all locally stored data, open Settings → Data Management inside Cain's Codex and use Reset Game Progression (selecting All) and Reset App Settings. Uninstalling the Microsoft Store app removes its local app data on Windows; on other platforms, unpackaged builds, or OS backups, clear your data in Settings → Data Management before uninstalling.",
              ),
              (
                heading: 'Microsoft Store & Windows Diagnostics',
                body: "Cain's Codex does not include built-in crash reporting or usage tracking. However, when you download, update, or run the Windows app through the Microsoft Store, Microsoft Corporation independently operates the Store and Windows diagnostic services, including Windows Error Reporting.\n\nIf the app crashes or freezes and diagnostic reporting is turned on in your Windows settings, Windows may send crash reports (such as crash dumps, error codes, stack traces, and basic OS or device details) to Microsoft. Through Microsoft Partner Center, Microsoft shares only de-identified, aggregated summaries with Adam M. (such as total installs, active-device counts, session counts, and grouped crash reports) along with public Store Ratings & Reviews. We use these summaries only to fix bugs and keep the app stable, and we never receive information that identifies you personally from those diagnostic summaries (aside from any public display name or details you choose to include in a Store review).\n\nMicrosoft's collection is governed by the [Microsoft Privacy Statement](https://privacy.microsoft.com/). You can review or change your Windows diagnostic settings at any time under Windows Settings → Privacy & security → Diagnostics & feedback.",
              ),
              (
                heading: 'Support Emails, Website Hosting & Cookies',
                body:
                    'This section applies when you visit our website (spirafoundry.github.io) or contact us for support.\n\nSupport Emails & GitHub Issues: If you email us at [${SiteContent.cainsCodexSupportEmail}](mailto:${SiteContent.cainsCodexSupportEmail}) or open an issue on GitHub, we receive your email address, display name, and whatever details you include in your message. Support emails are handled through Gmail (Google LLC) under the [Google Privacy Policy](https://policies.google.com/privacy). We use support messages only to help you, never sell or share them for marketing, and delete them when your request is resolved or whenever you ask.\n\nWebsite Hosting & Fonts: Our website is hosted on GitHub Pages (GitHub, Inc.), which automatically logs basic connection details (such as your IP address, browser type, and visit time) to deliver and protect the site under the [GitHub Privacy Statement](https://docs.github.com/en/site-policy/privacy-policies/github-general-privacy-statement). The site also loads web fonts and icons from Google Fonts (Google LLC), which receives basic browser connection details to serve those files under the [Google Privacy Policy](https://policies.google.com/privacy).\n\nCookies, Do Not Track & External Links: Our website does not use tracking, analytics, or advertising cookies. Because neither the app nor the website tracks you across other websites or sells your data, we honor browser Do Not Track (DNT) and Global Privacy Control (GPC) signals by default. Links on our site to external platforms (such as GitHub or the Microsoft Store) are governed by those platforms\' own privacy policies.',
              ),
              (
                heading: 'Regional & Global Privacy Rights',
                body:
                    "Your Rights Everywhere: Regardless of where you live, you can ask to see, correct, or delete any support emails we hold about you, or ask us to stop using them, by emailing [${SiteContent.cainsCodexSupportEmail}](mailto:${SiteContent.cainsCodexSupportEmail}). We respond to requests within one month (30 days) and never treat you differently for exercising your rights. Because Adam M. and our website and email providers (GitHub and Google) operate in the United States, visiting our website or emailing support from outside the United States transfers that information to the United States.\n\nUnited Kingdom & European Economic Area (UK / EU GDPR): If you are in the UK or EEA, your personal data is protected under the UK GDPR (and Data Protection Act 2018) or the EU GDPR. Adam M. is the data controller for any support emails you send us, which we process under our Legitimate Interests (Article 6(1)(f)) solely to reply to your request. Google LLC and GitHub, Inc. participate in the EU-U.S. Data Privacy Framework and the UK Extension to the Data Privacy Framework (and GitHub also maintains Standard Contractual Clauses and the UK International Data Transfer Addendum where applicable). In addition to the rights above, you have the right to data portability (where applicable) and the right to file a complaint with the UK Information Commissioner's Office (ICO) at [ico.org.uk](https://ico.org.uk) or your local EEA authority listed by the [European Data Protection Board](https://www.edpb.europa.eu/about-edpb/about-edpb/members_en).\n\nCanada (PIPEDA): If you are in Canada, any personal information you share is handled under PIPEDA and applicable provincial laws. By emailing support, you consent to our use of your email and message solely to assist you, and you may withdraw consent and ask us to delete your emails at any time. While your support emails and website connection logs are stored or processed in the United States by Google and GitHub, they are subject to U.S. laws and may be accessible to U.S. courts or authorities. Unresolved concerns may be directed to the Office of the Privacy Commissioner of Canada (OPC) at [priv.gc.ca](https://www.priv.gc.ca/).\n\nCalifornia (CCPA / CPRA) & Other U.S. States: Under California and other U.S. state privacy laws, we confirm that we do not sell personal information, share it for targeted advertising, profile users, or collect sensitive personal information. Aside from basic website connection logs handled by GitHub Pages and Google Fonts, the only personal information we ever receive is your email address and message if you choose to contact support.",
              ),
              (
                heading: "Children's Privacy",
                body:
                    "Cain's Codex and this website are not directed to children under 13 (or the minimum digital consent age in your country, if higher), and we do not knowingly collect personal information from children. If you believe a child has emailed us personal information, please contact [${SiteContent.cainsCodexSupportEmail}](mailto:${SiteContent.cainsCodexSupportEmail}) right away so we can delete it promptly.",
              ),
              (
                heading: 'Security & Legal Disclosures',
                body: "Local app data stays on your device and is protected by your device's own operating system and security settings. For support emails and our website, we rely on reasonable security measures, including HTTPS encryption on our website and the security protections provided by Gmail (Google LLC) and GitHub. However, no internet transmission (including email) or electronic storage is completely secure, so we cannot guarantee absolute security.\n\nLegal Disclosures: We will only disclose support correspondence to third parties if required by applicable law, court order, subpoena, or valid legal process, or when reasonably necessary to protect the safety, rights, or property of Adam M., our users, or the public, or to address fraud or abuse.",
              ),
              (
                heading: 'Data Retention',
                body: "Local app data stays on your device until you clear it in Settings → Data Management (or uninstall the Microsoft Store app on Windows). Aggregated Store and crash reports in Microsoft Partner Center follow Microsoft's retention schedules. Support emails are kept only as long as needed to resolve your request.",
              ),
              (
                heading: 'Changes to This Privacy Policy',
                body: "We may update this Privacy Policy from time to time as Cain's Codex, Microsoft Store requirements, or privacy laws change. Updates will be posted on this page with a new effective date and take effect when posted. Please check back occasionally to review any changes.",
              ),
              (
                heading: 'Contact',
                body: 'Questions about this Privacy Policy, your privacy rights, or requests to see or delete support emails?',
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
            effectiveDate: '2026-11-25',
            contactEmail: SiteContent.cainsCodexSupportEmail,
            summary: "These Terms of Use govern your access to and use of the Cain's Codex website, documentation, and support resources hosted on the Spira Foundry website. Your acquisition, installation, and use of the Cain's Codex Windows application through the Microsoft Store are governed separately by Microsoft's Standard Application License Terms (SALT).",
            sections: [
              (
                heading: 'Scope & Application License (Microsoft Store SALT)',
                body: "These Terms of Use apply to the Cain's Codex web pages, documentation, and support materials published on the Spira Foundry website.\n\nWhen you download or use the Cain's Codex Windows application via the Microsoft Store, your license to install and use the application is governed by Microsoft's [Standard Application License Terms](https://www.microsoft.com/en-us/servicesagreement) (SALT) and applicable Microsoft Store terms and Usage Rules, rather than a custom end-user license agreement on this website. If any conflict arises between these Terms of Use and Microsoft's SALT regarding the Windows application, Microsoft's SALT will control.",
              ),
              (
                heading: 'Unofficial Companion & Trademark Notice',
                body: "Cain's Codex, published by Adam M., is an unofficial fan-made companion application and is not affiliated with, endorsed, or sponsored by Blizzard Entertainment, Inc. Diablo II, Diablo II: Resurrected, and related names and terminology are trademarks or registered trademarks of Blizzard Entertainment, Inc.",
              ),
              (
                heading: 'Website & Documentation Permitted Use',
                body: "You may access and use this website and its documentation solely for personal, non-commercial reference and support purposes. You may not copy, republish, scrape, redistribute, or commercially exploit the website's original text, visual assets, or documentation, nor use the site for any unlawful purpose.",
              ),
              (
                heading: 'Intellectual Property',
                body: "Copyright © 2026 Adam M. All Rights Reserved. The Cain's Codex name, branding, visual assets, documentation, and website content remain the property of Adam M. to the extent permitted by applicable law. Third-party and open-source software or assets referenced or used in connection with the project remain governed by their respective licenses.",
              ),
              (
                heading: 'Disclaimer of Warranties',
                body: "This website, its documentation, and any companion reference materials or support responses are provided \"as is\" and \"as available\" without warranties of any kind, express, implied, or statutory, including implied warranties of accuracy, completeness, merchantability, fitness for a particular purpose, and non-infringement, to the maximum extent permitted by applicable law. Any product warranties or statutory remedies applicable to the Windows application distributed through the Microsoft Store are governed by Microsoft's Standard Application License Terms.",
              ),
              (
                heading: 'Limitation of Liability',
                body: "To the fullest extent permitted by applicable law, Adam M., Spira Foundry, and contributors shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of data or profits arising out of or related to your use of, or inability to use, this website, its documentation, or support materials. Any liability limitations applicable to the Windows application distributed through the Microsoft Store are governed by Microsoft's Standard Application License Terms.",
              ),
              (
                heading: 'Changes to These Terms',
                body: 'We may update these website Terms of Use from time to time as our documentation, support resources, or legal requirements evolve. Any updates will be posted at this URL with a revised effective date and apply to your use of the website and documentation from that date forward.',
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
