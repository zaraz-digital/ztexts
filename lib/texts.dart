import 'package:collection/collection.dart';

class Texts {
  final String? version;
  final List<Language> languages;

  Texts({this.version, required this.languages});

  @override
  String toString() {
    return 'Texts{version: $version, languages: $languages}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Texts &&
          runtimeType == other.runtimeType &&
          version == other.version &&
          ListEquality().equals(languages, other.languages);

  @override
  int get hashCode => version.hashCode ^ languages.hashCode;
}

class Language {
  final String? version;

  final String code;
  final Map<String, String> translations;

  Language({this.version, required this.code, required this.translations});

  @override
  String toString() {
    return 'Language{version: $version, code: $code, translations: $translations}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Language &&
          runtimeType == other.runtimeType &&
          version == other.version &&
          code == other.code &&
          MapEquality().equals(translations, other.translations);

  @override
  int get hashCode => version.hashCode ^ code.hashCode ^ translations.hashCode;
}
