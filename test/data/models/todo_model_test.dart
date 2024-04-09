import 'package:flutter_test/flutter_test.dart';
import 'package:praktitask/home/data/models/todo_model.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';

import '../../dummy_object.dart';

void main() {
  test("should be a subclass of Todo Entity ", () async {
    final result = testTodosModel.toEntity();
    expect(result, testTodosEntity);
  });
  test("should return JsonMap from model given", () async {
    final result = testTodosModel.toMap();
    expect(result, testTodoModelMap);
  });
  test("should return TodoModel from JsonMap given", () async {
    final result = TodoModel.fromMap(testTodoModelMap);
    expect(result, testTodosModel);
  });
}
