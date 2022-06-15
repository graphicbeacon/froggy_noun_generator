import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../routes/hello.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('GET /hello', () {
    test('responds with a 200 containing provided string', () {
      final context = _MockRequestContext();
      when(() => context.read<String>()).thenReturn('provided string');
      final response = route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(
        response.body(),
        completion(
          equals(
            json.encode({'message': 'Hello World provided string'}),
          ),
        ),
      );
    });
  });
}
