import 'package:build/build.dart';
import 'package:generator/src/todo_reporter_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder todoReporter(BuilderOptions options) => SharedPartBuilder([ToDoReporterGenerator()], 'todo_reporter');