import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:froggy/language_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../routes/noun/generate.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockLanguageService extends Mock implements LanguageService {}

void main() {
  group('GET /noun/generate', () {
    test('responds with generated nouns by count', () {
      final context = _MockRequestContext();
      final service = _MockLanguageService();
      final request =
          Request.get(Uri.parse('http://localhost:8080/noun/generate?count=2'));

      when(() => context.request).thenReturn(request);
      when(() => context.read<LanguageService>()).thenReturn(service);
      when(() => service.generateNouns(2)).thenReturn(
        ['apple', 'banana'],
      );

      final response = route.onRequest(context);

      expect(response.statusCode, HttpStatus.ok);
      expect(response.body(), completion(equals('apple banana')));
    });

    test('responds with 400 if count is not a number', () {
      final context = _MockRequestContext();
      final service = _MockLanguageService();
      final request = Request.get(
        Uri.parse('http://localhost:8080/noun/generate?count=NaN'),
      );

      when(() => context.request).thenReturn(request);
      when(() => context.read<LanguageService>()).thenReturn(service);

      final response = route.onRequest(context);

      expect(response.statusCode, HttpStatus.badRequest);
      expect(
        response.body(),
        completion(
          equals('Query parameter `count` is not a number'),
        ),
      );
    });

    // TODO: Up for a challenge? Add more tests

    // TODO: responds with 400 if length is not a number

    // TODO: responds with 400 if syllableLength is not a number

    // TODO: responds with results containing firstLetter matches

    // TODO: responds with results containing lastLetter matches

    // TODO: responds with results containing length matches

    // TODO: responds with results containing syllableLength matches

    // TODO: responds with results containing comparison match
  });
}
