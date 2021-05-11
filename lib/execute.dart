import 'dart:io';

import 'package:ztexts/texts_config.dart';
import 'package:ztexts/texts_factory.dart';

//0 Success
//1 Warnings
//2 Errors
Future<void> execute(
    String configPath, String sourceKey, String destinationKey) async {
  try {
    if (!File(configPath).existsSync()) {
      throw 'Configuration file does not exist!';
    }

    //Initialize configuration and factory
    var textsConfig = await TextsConfig.fromYaml(configPath);
    var textsFactory = TextsFactory(textsConfig);

    // Initialize fetcher and consumer
    var fetcher = textsFactory.getFetcher(sourceKey);
    var consumer = textsFactory.getConsumer(destinationKey);

    //Fetch texts
    var texts = await fetcher.fetch();

    //Consume texts
    await consumer.consume(texts);

    _succeed(consumer.getMessage());
  } catch (exception) {
    _fail(exception.toString());
  }
}

void _fail(String msg) {
  stderr.writeln(msg);
  exitCode = 2;
}

void _succeed(String msg) {
  stdout.writeln(msg);
  exitCode = 0;
}
