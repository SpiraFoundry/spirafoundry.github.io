import 'package:jaspr/jaspr.dart';

import 'legal_document.dart';

/// Reusable static privacy policy page template designed to be mounted at
/// permanent project paths such as `/<project-slug>/privacy-policy`.
class PrivacyPolicyPage extends StatelessComponent {
  const PrivacyPolicyPage({
    required this.projectName,
    required this.effectiveDate,
    required this.summary,
    required this.sections,
    this.contactEmail,
    super.key,
  });

  final String projectName;
  final String effectiveDate;
  final String summary;
  final List<({String heading, String body})> sections;
  final String? contactEmail;

  @override
  Component build(BuildContext context) {
    return LegalDocumentPage(
      projectName: projectName,
      documentType: 'Privacy Policy',
      topbarTag: 'Legal & Privacy',
      effectiveDate: effectiveDate,
      summary: summary,
      sections: sections,
      contactEmail: contactEmail,
    );
  }
}
