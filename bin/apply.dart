import 'package:args/args.dart';
import 'package:ztexts/execute.dart';

void main(List<String> arguments) {

  var argParser = ArgParser()
    ..addOption('from', help: 'Pass source of texts')
    ..addOption('to', help: 'Pass destination of texts')
    ..addOption('config', defaultsTo: 'pubspec.yaml', help: 'Set path to the yaml configuration file. '
        'Make sure that "ztexts" is a top-level key within this file')
  ;

  var argResults = argParser.parse(arguments);

  String sourceKey = argResults['from'];
  String destinationKey = argResults['to'];
  String configPath = argResults['config'];

  execute(configPath, sourceKey, destinationKey);
}
