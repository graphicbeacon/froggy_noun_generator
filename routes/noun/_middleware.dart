import 'package:dart_frog/dart_frog.dart';
import 'package:english_words/english_words.dart';
import 'package:froggy/language_service.dart';

Handler middleware(Handler handler) => handler.use(
      provider<LanguageService>((_) => const LanguageService(nouns)),
    );
