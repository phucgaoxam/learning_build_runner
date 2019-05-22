import 'package:todo_reporter/todo_reporter.dart';
import 'package:flutter/material.dart';

part 'example_one.g.dart';

@Todo('completed implementation of one')
class ExampleOne {
  final String name;
  final String login;

  ExampleOne(this.name, this.login);
}