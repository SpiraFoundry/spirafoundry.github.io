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
              p(classes: 'legal-doc-section__body', [
                .text(component.sections[i].body),
                if (component.contactEmail case final email? when component.sections[i].heading == 'Contact') ...[
                  .text(' Email us at '),
                  a(href: 'mailto:$email', classes: 'legal-doc-link', [.text(email)]),
                  .text(' or reach out via the '),
                  a(
                    href: SiteContent.orgGithubUrl,
                    target: Target.blank,
                    attributes: const {'rel': 'noopener noreferrer'},
                    classes: 'legal-doc-link',
                    [.text('${SiteContent.orgName} GitHub organization')],
                  ),
                  .text('.'),
                ],
              ]),
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
}
