import 'dart:io';
import 'package:args/args.dart';

const String version = '0.0.6';

void main(List<String> arguments) async {
  final ArgParser argParser = ArgParser()
    ..addCommand('create')
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show usage information.')
    ..addFlag('version', negatable: false, help: 'Show version.');

  try {
    final ArgResults results = argParser.parse(arguments);

    if (results.flag('help') || arguments.isEmpty) {
      _printUsage(argParser);
      return;
    }

    if (results.flag('version')) {
      print('ScaffoldIo version: $version');
      return;
    }

    // Handle the "create" command
    if (results.command?.name == 'create') {
      final commandResults = results.command!;
      if (commandResults.rest.isEmpty) {
        print('❌ Please specify a template. Example: scaffoldio create ecommerce');
        print('Available templates: ecommerce, service');
        return;
      }

      final templateName = commandResults.rest.first;
      await _handleCreate(templateName);
    } else {
      _printUsage(argParser);
    }
  } catch (e) {
    print('❌ Error: $e');
  }
}

Future<void> _handleCreate(String template) async {
  final templates = {
    'ecommerce': 'https://github.com/HirenMakwana45/scaffoldio_ecommerce',
    'service': 'https://github.com/HirenMakwana45/scaffoldio_service',
  };

  final brickNames = {
    'ecommerce': 'scaffoldio_ecommerce',
    'service': 'scaffoldio_service',
  };

  if (!templates.containsKey(template)) {
    print('❌ Template "$template" not found.');
    return;
  }

  print('🚀 ScaffoldIo is checking for updates...');

  // 1. Add/Update the brick GLOBALLY
  final addProcess = await Process.start(
    'mason',
    ['add', '-g', brickNames[template]!, '--git-url', templates[template]!],
    runInShell: true,
    mode: ProcessStartMode.inheritStdio,
  );
  await addProcess.exitCode;

  print('📦 Generating $template files...');

  // 2. Run mason make (WITHOUT -g)
  // Mason is smart enough to find the global brick on its own!
  final makeProcess = await Process.start(
    'mason',
    [
      'make', 
      brickNames[template]!,
      '-o', '.', 
      '--on-conflict', 'overwrite', 
    ],
    runInShell: true,
    mode: ProcessStartMode.inheritStdio,
  );

  final exitCode = await makeProcess.exitCode;

  if (exitCode == 0) {
    print('\n✨ Success! Your $template code is now integrated.');
  } else {
    print('\n❌ Error: Generation failed.');
  }
}

void _printUsage(ArgParser parser) {
  print('ScaffoldIo CLI - Professional Flutter Scaffolding');
  print('Usage: scaffoldio <command> [arguments]\n');
  print('Commands:');
  print('  create <template>    Create a new project (e.g., ecommerce, service)');
  print('\nFlags:');
  print(parser.usage);
}