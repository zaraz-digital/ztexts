import 'package:ztexts/texts.dart';

abstract class TextsFetcher {
  final Map<String, String> _configuration;

  TextsFetcher(this._configuration);

  Future<Texts> fetch();

  @override
  String toString() {
    return 'TextsFetcher{_configuration: $_configuration}';
  }
}
