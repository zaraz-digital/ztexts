import 'dart:convert';
import 'dart:io';

import 'package:ztexts/texts.dart';
import 'package:ztexts/texts_fetcher.dart';
import 'package:http/http.dart' as http;

import 'package:ztexts/texts_utils.dart';

const keyAppId = 'appId';
const keyApiToken = 'apiToken';

class ApplangaFetcher extends TextsFetcher {
  late String _appId;
  late String _apiToken;

  ApplangaFetcher(Map<String, String> configuration) : super(configuration) {
    requireNotNull(configuration, [keyAppId, keyApiToken]);

    _appId = configuration[keyAppId]!;
    _apiToken = configuration[keyApiToken]!;
  }

  factory ApplangaFetcher.fromConfiguration(
      Map<String, String>? configuration) {
    if (configuration == null) {
      throw 'Applanga fetcher requires a valid configuration to be set!';
    }
    return ApplangaFetcher(configuration);
  }

  @override
  Future<Texts> fetch() async {
    var applangaResponse = await http.get(
      Uri.parse('https://api.applanga.com/v1/api?app=$_appId'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $_apiToken'},
    );

    var body = jsonDecode(applangaResponse.body);
    return _bodyToTexts(body);
  }

  Texts _bodyToTexts(Map<String, dynamic> body) {
    var version = body['__v'].toString();

    Map<String, dynamic> data = body['data'];
    var languages = <Language>[];
    for (var item in data.entries) {
      var languageCode = item.key;

      Map<String, dynamic> content = item.value['main'];
      var languageVersion = content['version'].toString();

      Map<String, dynamic> entries = content['entries'];
      var languageTranslations = <String, String>{};
      for (var entry in entries.entries) {
        languageTranslations[entry.key] = entry.value['v'];
      }

      languages.add(Language(
          code: languageCode,
          version: languageVersion,
          translations: languageTranslations));
    }

    return Texts(version: version, languages: languages);
  }
}
