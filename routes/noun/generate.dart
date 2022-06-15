import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:froggy/language_service.dart';

Response onRequest(RequestContext context) {
  final service = context.read<LanguageService>();
  final params = context.request.uri.queryParameters;

  final count = params['count'];
  final firstLetter = params['firstLetter'];
  final lastLetter = params['lastLetter'];
  final length = params['length'];
  final syllableLength = params['syllableLength'];
  final comparison = params['comparison'];

  if (count == null || int.tryParse(count) == null) {
    return Response(
      statusCode: HttpStatus.badRequest,
      body: 'Query parameter `count` is not a number',
    );
  }

  if (length != null && int.tryParse(length) == null) {
    return Response(
      statusCode: HttpStatus.badRequest,
      body: 'Query parameter `length` must be a number',
    );
  }

  if (syllableLength != null && int.tryParse(syllableLength) == null) {
    return Response(
      statusCode: HttpStatus.badRequest,
      body: 'Query parameter `syllableLength` must be a number',
    );
  }

  return Response(
    body: service
        .generateNouns(
          int.parse(count),
          firstLetter: firstLetter,
          lastLetter: lastLetter,
          length: length != null ? int.parse(length) : null,
          syllableLength:
              syllableLength != null ? int.parse(syllableLength) : null,
          comparison: Comparison.fromString(comparison),
        )
        .join(' '),
  );
}
