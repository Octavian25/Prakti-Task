import 'package:flutter_test/flutter_test.dart';
import 'package:praktitask/home/data/models/todo_model.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';

import '../dummy_object.dart';

void main() {
  test("should be a subclass of Todo Model ", () async {
    final result = testTodosEntity.toModel();
    expect(result, testTodosModel);
  });
  test("should return TodoEntity with isCompleted true ", () async {
    final result = testTodosEntity.completed();
    expect(result, testTodosEntityCompleted);
  });
  test("should return TodoEntity with isCompleted false ", () async {
    final result = testTodosEntity.onGoing();
    expect(result, testTodosEntityOngoing);
  });
  test("should return JsonMap from model given", () async {
    final result = testTodosEntity.toMap();
    expect(result, testTodoModelMap);
  });
  test("should return TodoEntity from JsonMap given", () async {
    final result = TodoEntity.fromMap(testTodoModelMap);
    expect(result, testTodosEntity);
  });
}
