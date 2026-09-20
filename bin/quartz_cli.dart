// CLI application.
// ignore_for_file: avoid_print

import 'package:args/args.dart';

const String version = '0.1.0';

ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Show additional command output.',
    )
    ..addFlag('version', negatable: false, help: 'Print the tool version.');
}

void printUsage(ArgParser argParser) {
  print('Usage: dart cli.dart <flags> [arguments]');
  print(argParser.usage);
}

void main(List<String> arguments) {
  final argParser = buildParser();
  try {
    final results = argParser.parse(arguments);
    var verbose = false;

    if (results.flag('help')) {
      printUsage(argParser);
      return;
    }
    if (results.flag('version')) {
      print('cli version: $version');
      return;
    }
    if (results.flag('verbose')) {
      verbose = true;
    }

    print('Positional arguments: ${results.rest}');
    if (verbose) {
      print('[VERBOSE] All arguments: ${results.arguments}');
    }
  } on FormatException catch (e) {
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
