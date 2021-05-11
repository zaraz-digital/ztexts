void requireNotNull(Map<String, String> map, List<String> keys) {
  for (var key in keys) {
    if (!map.containsKey(key) || map[key] == null) {
      throw '$key should be defined!';
    }
  }
}
