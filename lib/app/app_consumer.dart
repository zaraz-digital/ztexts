import 'dart:convert';
import 'dart:io';

import 'package:ztexts/texts.dart';
import 'package:ztexts/texts_consumer.dart';

const keyPath = 'outputPath';

class AppTextsConsumer extends TextsConsumer {
  String _textsPath;
  JsonEncoder _encoder;
  String _message = 'Not executed';

  AppTextsConsumer(Map<String, String> configuration) : super(configuration) {
    _textsPath = configuration[keyPath];
    _encoder = JsonEncoder.withIndent('    ');
  }

  @override
  Future consume(Texts texts) async {
    Directory(_textsPath).createSync(recursive: true);

    for (var language in texts.languages) {
      var languageCode = language.code;
      var content = _encoder.convert(language.translations);
      var translationsFile = File('$_textsPath/string_$languageCode.json');
      translationsFile.createSync();
      translationsFile.writeAsStringSync(content);
    }

    try {
      var processResult = Process.runSync(
          'dart', ['run', 'gen_lang:generate', '--source-dir=$_textsPath']);
      _message = processResult.stdout.toString();
    } catch (exception) {
      _message = exception.toString();
    }
  }

  @override
  String getMessage() => _message;
}
