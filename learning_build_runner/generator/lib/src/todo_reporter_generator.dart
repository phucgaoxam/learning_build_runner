import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:todo_reporter/todo_reporter.dart';
import 'package:analyzer/dart/element/element.dart';

class ToDoReporterGenerator extends GeneratorForAnnotation<Todo> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    return _generateWidgetSource(element);
  }

  String _generateWidgetSource(Element element) {
    var visitor = ModelVisitor();
    element.visitChildren(visitor);

    StringBuffer classBuffer = StringBuffer();
    var widgetName = '${visitor.className}Widget';
    classBuffer.writeln("class $widgetName extends StatelessWidget{");

    for (var name in visitor.fields.keys) {
      classBuffer.writeln("final ${visitor.fields[name]} $name;");
    }

    classBuffer.writeln('$widgetName(');
    for (var parameterName in visitor.fields.keys) {
      classBuffer.writeln("this.$parameterName,");
    }
    classBuffer.writeln(');');
    classBuffer.writeln("}");
    return classBuffer.toString();
  }
}

class ModelVisitor extends SimpleElementVisitor {
  DartType className;
  Map<String, DartType> fields = {};

  @override
  visitConstructorElement(ConstructorElement element) {
    assert(className == null);
    className = element.type.returnType;
  }

  @override
  visitFieldElement(FieldElement element) {
    fields[element.name] = element.type;
  }
}