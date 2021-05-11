class Texts {
  final String? version;
  final List<Language> languages;

  Texts({this.version, required this.languages});

  @override
  String toString() {
    return 'Texts{version: $version, languages: $languages}';
  }
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
}
