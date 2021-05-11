import 'package:args/args.dart';
import 'package:ztexts/execute.dart';

void main(List<String> arguments) {
  var argParser = ArgParser()
    ..addOption('from', mandatory: true, help: 'Pass source of texts')
    ..addOption('to', mandatory: true, help: 'Pass destination of texts')
    ..addOption('config',
        defaultsTo: 'pubspec.yaml',
        help: 'Set path to the yaml configuration file. '
            'Make sure that "ztexts" is a top-level key within this file');

  if (_isHelpCommand(arguments)) {
    print(argParser.usage);
    return;
  }

  var argResults = argParser.parse(arguments);

  String sourceKey = argResults['from'];
  String destinationKey = argResults['to'];
  String configPath = argResults['config'];

  execute(configPath, sourceKey, destinationKey);
}

bool _isHelpCommand(List<String> args) {
  return args.length == 1 && (args[0] == '--help' || args[0] == '-h');
}
