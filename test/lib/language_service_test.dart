import 'package:english_words/english_words.dart';
import 'package:froggy/language_service.dart';
import 'package:test/test.dart';

class $LanguageService extends LanguageService {
  const $LanguageService(super.data);

  /// Override needed for aid deterministic testing
  @override
  List<String> shuffle(List<String> data) => data;
}

void main() {
  group('LanguageService', () {
    group('generateNouns()', () {
      late List<String> data;

      setUp(() {
        data = [
          'apple',
          'artist',
          'banana',
          'businessman',
          'carrot',
          'dewberry',
          'eggnog',
        ];
      });

      test('returns a list of nouns', () {
        const service = LanguageService(nouns);

        expect(service.generateNouns(2), hasLength(2));
        expect(service.generateNouns(4), hasLength(4));
      });

      test('filters by first and last letter', () {
        final service = $LanguageService(data);

        expect(
          service.generateNouns(2, firstLetter: 'a', lastLetter: 'e'),
          equals(['apple']),
        );
        expect(
          service.generateNouns(2, firstLetter: 'a'),
          equals(['apple', 'artist']),
        );
        expect(
          service.generateNouns(3, firstLetter: 'c', lastLetter: 't'),
          equals(['carrot']),
        );
        expect(
          service.generateNouns(3, lastLetter: 't'),
          equals(['artist', 'carrot']),
        );
      });

      test('filters by length and comparison', () {
        final service = $LanguageService(data);

        expect(
          service.generateNouns(2, length: 6),
          equals(['artist', 'banana']),
        );
        expect(
          service.generateNouns(
            2,
            length: 6,
            comparison: Comparison.greaterThan,
          ),
          equals(['businessman', 'dewberry']),
        );
        expect(
          service.generateNouns(
            3,
            length: 6,
            comparison: Comparison.lessThan,
          ),
          equals(['apple']),
        );
      });

      test('filters by syllable length and comparison', () {
        final service = $LanguageService(data);

        expect(
          service.generateNouns(2, syllableLength: 3),
          equals(['banana', 'dewberry']),
        );
        expect(
          service.generateNouns(
            2,
            syllableLength: 3,
            comparison: Comparison.greaterThan,
          ),
          equals(['businessman']),
        );
        expect(
          service.generateNouns(
            3,
            syllableLength: 3,
            comparison: Comparison.lessThan,
          ),
          equals(['apple', 'artist', 'carrot']),
        );
      });
    });
  });
}
