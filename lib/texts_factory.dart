import 'package:ztexts/app/app_consumer.dart';
import 'package:ztexts/applanga/applanga_fetcher.dart';
import 'package:ztexts/log/log_consumer.dart';
import 'package:ztexts/texts_config.dart';
import 'package:ztexts/texts_consumer.dart';
import 'package:ztexts/texts_fetcher.dart';

const sourceApplanga = 'applanga';

const destinationLog = 'log';
const destinationApp = 'apptexts';
const keyPath = 'path';

class TextsFactory {

  final TextsConfig textsConfig;

  TextsFactory(this.textsConfig);

  TextsFetcher getFetcher(String sourceKey) {
    var configuration = textsConfig.get(sourceKey);

    switch (sourceKey) {
      case sourceApplanga:
        return ApplangaFetcher(configuration);
      default:
        throw 'Source $sourceKey is unknown!';
    }
  }

  TextsConsumer getConsumer(String destinationKey) {
    var configuration = textsConfig.get(destinationKey);

    switch (destinationKey) {
      case destinationLog:
        return LogConsumer();
      case destinationApp:
        return AppTextsConsumer(configuration);
      default:
        throw 'Destination $destinationKey is unknown!';
    }
  }
}
