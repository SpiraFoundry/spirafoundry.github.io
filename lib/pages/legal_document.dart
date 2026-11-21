import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../data/site_content.dart';
import '../utils/scroll_reset.dart';

/// Clean, high-contrast legal document layout designed to be mounted at
/// permanent project paths such as `/<project-slug>/privacy-policy` or
/// `/<project-slug>/terms-of-use`.
class LegalDocumentPage extends StatefulComponent {
  const LegalDocumentPage({
    required this.projectName,
    required this.documentType,
    required this.effectiveDate,
    required this.summary,
    required this.sections,
    this.topbarTag,
    this.contactEmail,
    super.key,
  });

  final String projectName;
  final String documentType;
  final String effectiveDate;
  final String summary;
  final List<({String heading, String body})> sections;
  final String? topbarTag;
  final String? contactEmail;

  @override
  State<LegalDocumentPage> createState() => _LegalDocumentPageState();
}

class _LegalDocumentPageState extends State<LegalDocumentPage> {
  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      scrollToTop();
    }
  }

  @override
  Component build(BuildContext context) {
    return div(classes: 'legal-doc-page', [
      header(classes: 'legal-doc-topbar', [
        div(classes: 'legal-doc-container legal-doc-topbar__inner', [
          Link(
            to: '/',
            classes: 'legal-doc-backlink',
            child: Component.text('← ${SiteContent.orgName}'),
          ),
          span(classes: 'legal-doc-tag', [.text(component.topbarTag ?? component.documentType)]),
        ]),
      ]),
      main_(classes: 'legal-doc-container legal-doc-main', [
        div(classes: 'legal-doc-header', [
          p(classes: 'legal-doc-eyebrow', [.text('${SiteContent.orgName} · ${component.documentType}')]),
          h1(classes: 'legal-doc-title', [.text(component.projectName)]),
          p(classes: 'legal-doc-meta', [.text('Effective Date: ${component.effectiveDate}')]),
          p(classes: 'legal-doc-summary', [.text(component.summary)]),
        ]),
        div(classes: 'legal-doc-sections', [
          for (var i = 0; i < component.sections.length; i++)
            section(classes: 'legal-doc-section', [
              h2(classes: 'legal-doc-section__heading', [
                .text('${i + 1}. ${component.sections[i].heading}'),
              ]),
              ..._buildSectionBody(component.sections[i]),
            ]),
        ]),
      ]),
      footer(classes: 'legal-doc-footer', [
        div(classes: 'legal-doc-container legal-doc-footer__inner', [
          span(classes: 'legal-doc-footer__copy', [.text('${SiteContent.orgName} · ${component.documentType}')]),
          Link(
            to: '/',
            classes: 'legal-doc-backlink',
            child: Component.text('Return to ${SiteContent.orgName}'),
          ),
        ]),
      ]),
    ]);
  }

  List<Component> _buildSectionBody(({String heading, String body}) sectionData) {
    final paragraphs = sectionData.body.split('\n\n');
    final isContactSection = sectionData.heading == 'Contact';

    return [
      for (var i = 0; i < paragraphs.length; i++)
        p(classes: 'legal-doc-section__body', [
          ..._buildParagraphChildren(paragraphs[i]),
          if (isContactSection && i == paragraphs.length - 1)
            ...switch (component.contactEmail) {
              final email? => [
                .text(' Email us at '),
                _buildLegalLink(label: email, href: 'mailto:$email'),
                .text(' or reach out via the '),
                _buildLegalLink(label: '${SiteContent.orgName} GitHub organization', href: SiteContent.orgGithubUrl),
                .text('.'),
              ],
              null => const <Component>[],
            },
        ]),
    ];
  }

  List<Component> _buildParagraphChildren(String paragraph) {
    return [
      for (final token in parseLegalParagraphTokens(paragraph))
        switch (token.href) {
          final href? => _buildLegalLink(label: token.text, href: href),
          null => .text(token.text),
        },
    ];
  }

  Component _buildLegalLink({required String label, required String href}) {
    final isExternal = href.startsWith('https://') || href.startsWith('http://');
    return a(
      href: href,
      target: isExternal ? Target.blank : null,
      attributes: isExternal ? const {'rel': 'noopener noreferrer'} : null,
      classes: 'legal-doc-link',
      [.text(label)],
    );
  }
}

/// Token representing plain text or an inline hyperlink inside a legal paragraph.
typedef LegalTextToken = ({String text, String? href});

final _legalInlineLinkPattern = RegExp(r'\[([^\]]+)\]\(((?:https?://|mailto:)[^)]+)\)');

/// Splits [paragraph] into plain text and `[label](url)` link tokens for
/// `http://`, `https://`, and `mailto:` references.
List<LegalTextToken> parseLegalParagraphTokens(String paragraph) {
  final tokens = <LegalTextToken>[];
  var cursor = 0;

  for (final match in _legalInlineLinkPattern.allMatches(paragraph)) {
    if (match.start > cursor) {
      tokens.add((text: paragraph.substring(cursor, match.start), href: null));
    }
    tokens.add((text: match.group(1)!, href: match.group(2)!));
    cursor = match.end;
  }

  if (cursor < paragraph.length) {
    tokens.add((text: paragraph.substring(cursor), href: null));
  }

  return tokens;
}
