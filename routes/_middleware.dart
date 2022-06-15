import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  // return (context) async {
  //   print('Default handler');

  //   return await handler(context);
  // };
  return handler.use(requestLogger()).use(
    (handler) {
      print('Default handler');
      return handler;
    },
  ).use(provider<String>((context) => 'This was provided :)'));
}
