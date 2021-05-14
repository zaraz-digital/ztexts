import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:ztexts/applanga/applanga_fetcher.dart';
import 'package:ztexts/texts.dart';

void main() {
  group('Applanga ', () {
    test('Fetches successfully', () async {
      var httpClient = MockClient((request) async {
        return Response(
            json.encode({
              '_id': 'someid',
              '__v': 10,
              'draftModeEnabled': true,
              'collectMissingEnabled': true,
              'baseLanguage': 'en',
              'name': 'Playground',
              'data': {
                'en': {
                  'main': {
                    'version': 6,
                    'entries': {
                      'welcome': {'v': 'Welcome!'},
                      'generic_error': {'v': 'Oops! Something went wrong'},
                      'greeting': {'v': 'Hi there, \${yourName}'}
                    }
                  }
                },
                'fr': {
                  'main': {
                    'version': 7,
                    'entries': {
                      'welcome': {'v': 'Bienvenu'},
                      'generic_error': {'v': 'Oops! Je suis fatigue! Hahaha'},
                      'greeting': {'v': 'Bonjour, \${yourName}'}
                    }
                  }
                }
              }
            }),
            200,
            headers: {'content-type': 'application/json'});
      });
      var configuration = <String, String>{'appId': 'asdf', 'apiToken': 'ghjk'};

      var applangaFetcher = ApplangaFetcher(configuration, httpClient);
      var result = await applangaFetcher.fetch();

      expect(
          result,
          equals(Texts(version: '10', languages: <Language>[
            Language(version: '6', code: 'en', translations: <String, String>{
              'welcome': 'Welcome!',
              'generic_error': 'Oops! Something went wrong',
              'greeting': 'Hi there, \${yourName}'
            }),
            Language(version: '7', code: 'fr', translations: <String, String>{
              'welcome': 'Bienvenu',
              'generic_error': 'Oops! Je suis fatigue! Hahaha',
              'greeting': 'Bonjour, \${yourName}'
            }),
          ])));
    });
  });
}
