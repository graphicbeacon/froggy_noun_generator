import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final req = context.request;

  if (req.method != HttpMethod.get) {
    return Response(
      statusCode: HttpStatus.methodNotAllowed,
      body: 'Method not allowed on this route',
    );
  }

  final contents = await File('public/index.html').readAsString();
  return Response(
    body: contents,
    headers: {
      HttpHeaders.contentTypeHeader: ContentType.html.mimeType,
    },
  );
}
