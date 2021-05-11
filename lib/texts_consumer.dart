import 'package:ztexts/texts.dart';

abstract class TextsConsumer {
  final Map<String, String> _configuration;

  TextsConsumer(this._configuration);

  Future consume(Texts texts);

  String getMessage();

  @override
  String toString() {
    return 'TextsConsumer{_configuration: $_configuration}';
  }
}
