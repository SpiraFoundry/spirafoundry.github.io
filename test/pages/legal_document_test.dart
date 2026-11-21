import 'package:spira_foundry/pages/legal_document.dart';
import 'package:test/test.dart';

void main() {
  group('parseLegalParagraphTokens', () {
    test('returns plain text token when paragraph has no links', () {
      expect(
        parseLegalParagraphTokens('Plain policy text without links.'),
        equals([(text: 'Plain policy text without links.', href: null)]),
      );
    });

    test('parses inline https and mailto links while preserving surrounding text', () {
      const paragraph =
          'Governed by the [Microsoft Privacy Statement](https://privacy.microsoft.com/) or [support](mailto:support@example.com).';

      expect(
        parseLegalParagraphTokens(paragraph),
        equals([
          (text: 'Governed by the ', href: null),
          (text: 'Microsoft Privacy Statement', href: 'https://privacy.microsoft.com/'),
          (text: ' or ', href: null),
          (text: 'support', href: 'mailto:support@example.com'),
          (text: '.', href: null),
        ]),
      );
    });

    test('ignores non-http/mailto schemes such as javascript links', () {
      const paragraph = 'Do not parse [bad](javascript:alert(1)) links.';

      expect(
        parseLegalParagraphTokens(paragraph),
        equals([(text: paragraph, href: null)]),
      );
    });
  });
}
