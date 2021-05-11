RegExp ARG_REG_EXP = RegExp(r'\${\w+}');
const String DEFAULT_PLURAL_ARGS = 'howMany';
const String DEFAULT_GENDER_ARG = 'targetGender';

List<String> getArgs(Iterable<Match> allMatch, String? defaultArg) {
  var args = <String>[];
  if (null != defaultArg) {
    args.add(defaultArg);
  }

  for (var match in allMatch) {
    var arg = match.input.substring(match.start + 2, match.end - 1);
    if (!args.contains(arg)) {
      args.add(arg);
    }
  }

  return args;
}

String? normalizedSpecialCharacters(String? message) {
  if (null != message) {
    var normalizedJson = message.replaceAll(r'\', r'\\');
    return normalizedJson.replaceAll(r'\\"', r'\\\"');
  }
  return null;
}

String? normalizedJsonMessage(String? message) {
  if (null != message) {
    return message;
  }
  return null;
}

String generateArg(arg) {
  return null != arg ? '"$arg"' : 'null';
}

String extraArgsFromGender(String male, String female, String other) {
  var plurals = [male, female, other];
  Iterable<Match> theMostMatch = [];

  for (var plural in plurals) {
    Iterable<Match> allMatch = ARG_REG_EXP.allMatches(plural);
    if ((allMatch.length > theMostMatch.length)) {
      theMostMatch = allMatch;
    }
  }

  var builder = StringBuffer();
  var args = getArgs(theMostMatch, DEFAULT_GENDER_ARG);
  for (var i = 0; i < args.length; i++) {
    if (i != 0) {
      builder.write(', ');
    }
    builder.write(args[i]);
  }

  return builder.toString();
}

String extraArgsFromPlural(String zero, String one, String two, String few,
    String many, String other) {
  var plurals = [zero, one, two, few, many, other];
  Iterable<Match> theMostMatch = [];

  for (var plural in plurals) {
    Iterable<Match> allMatch = ARG_REG_EXP.allMatches(plural);
    if ((allMatch.length > theMostMatch.length)) {
      theMostMatch = allMatch;
    }
  }

  var builder = StringBuffer();
  var args = getArgs(theMostMatch, DEFAULT_PLURAL_ARGS);
  for (var i = 0; i < args.length; i++) {
    if (i != 0) {
      builder.write(', ');
    }
    builder.write(args[i]);
  }

  return builder.toString();
}

String extraArgsFromMessage(String message) {
  var builder = StringBuffer();
  var args = getArgs(ARG_REG_EXP.allMatches(message), null);

  for (var i = 0; i < args.length; i++) {
    if (i != 0) {
      builder.write(', ');
    }
    builder.write(args[i]);
  }
  return builder.toString();
}
