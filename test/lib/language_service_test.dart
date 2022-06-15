import 'package:froggy/language_service.dart';
import 'package:test/test.dart';

void main() {
  group('LanguageService', () {
    test('generateNouns returns a list of nouns', () {
      final service = LanguageService();

      expect(service.generateNouns(2), hasLength(2));
      expect(service.generateNouns(4), hasLength(4));
    });
  });
}
