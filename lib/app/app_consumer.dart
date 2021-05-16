import 'dart:convert';
import 'dart:io';

import 'package:ztexts/texts.dart';
import 'package:ztexts/texts_consumer.dart';
import 'package:ztexts/texts_utils.dart';

import 'gen_lang/core_18n.dart';

const keyPath = 'outputPath';

class AppTextsConsumer extends TextsConsumer {
  late String _textsPath;
  late JsonEncoder _encoder;

  String _message = 'Texts successfully applied!';

  AppTextsConsumer(Map<String, String> configuration) : super(configuration) {
    requireNotNull(configuration, [keyPath]);
    _textsPath = configuration[keyPath]!;
    _encoder = JsonEncoder.withIndent('    ');
  }

  factory AppTextsConsumer.fromConfiguration(
      Map<String, String>? configuration) {
    if (configuration == null) {
      throw 'App texts consumer requires a valid configuration to be set!';
    }
    return AppTextsConsumer(configuration);
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
      handleGenerateI18nFiles(I18nOption(_textsPath, 'en', 'lib/generated'));
    } catch (exception) {
      _message = exception.toString();
    }
  }

  @override
  String getMessage() => _message;
}
