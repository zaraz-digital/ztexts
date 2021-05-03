import 'dart:io';

import 'package:yaml/yaml.dart';

const configKey = 'ztexts';

class TextsConfig {
  final Map<String, Map<String, String>> _configuration;

  TextsConfig(this._configuration);

  Map<String, String> get(String componentKey) {
    return _configuration[componentKey];
  }

  static Future<TextsConfig> fromYaml(String yamlPath) async{
    var data = await File(yamlPath).readAsString();

    var yamlConfiguration = loadYaml(data);
    YamlMap toolConfiguration = yamlConfiguration[configKey];
    if(toolConfiguration == null) {
      throw 'Yaml file does not contain ztexts configuration. Make sure "ztexts" is a top-level key within the file.';
    }

    var configuration = <String, Map<String, String>>{};
    for(var item in toolConfiguration.entries) {
      var key = item.key.toString();
      YamlMap value = item.value;

      var componentConfiguration = <String, String>{};
      for (var component in value.entries) {
        componentConfiguration[component.key.toString()] = component.value.toString();
      }

      configuration[key] = componentConfiguration;
    }

    return TextsConfig(configuration);
  }
}