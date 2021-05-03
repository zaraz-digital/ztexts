import 'dart:io';

import 'package:ztexts/texts.dart';
import 'package:ztexts/texts_consumer.dart';

class LogConsumer implements TextsConsumer {
  @override
  Future consume(Texts texts) async {
    stdout.writeln('Texts: $texts');
  }

  @override
  String getMessage() {
    return 'Texts successfully printed to console';
  }

}