import 'package:praktitask/home/data/models/todo_model.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';

final testTodosModelList = [
  TodoModel(
      id: 1,
      taskName: "test",
      description: "test",
      categoryCode: "testing",
      date: "2023-02-27",
      isCompleted: false,
      time: "15:55"),
  TodoModel(
      id: 2,
      taskName: "test",
      description: "test",
      categoryCode: "testing",
      date: "2023-02-27",
      isCompleted: true,
      time: "15:50"),
];
final testTodosEntityList = [
  TodoEntity(
      id: 1,
      taskName: "test",
      description: "test",
      categoryCode: "testing",
      date: "2023-02-27",
      isCompleted: false,
      time: "15:55"),
  TodoEntity(
      id: 2,
      taskName: "test",
      description: "test",
      categoryCode: "testing",
      date: "2023-02-27",
      isCompleted: true,
      time: "15:50"),
];

final testTodosModel = TodoModel(
    id: 1,
    taskName: "test",
    description: "test",
    categoryCode: "testing",
    date: "2023-02-27",
    isCompleted: false,
    time: "15:55");

final testTodosModelWithoutID = TodoModel(
    id: 925,
    taskName: "test",
    description: "test",
    categoryCode: "testing",
    date: "2023-02-27",
    isCompleted: false,
    time: "15:55");

final testTodoModelMap = {
  "id": 1,
  "taskName": "test",
  "description": "test",
  "categoryCode": "testing",
  "date": "2023-02-27",
  "isCompleted": 0,
  "time": "15:55"
};

final testTodosEntity = TodoEntity(
    id: 1,
    taskName: "test",
    description: "test",
    categoryCode: "testing",
    date: "2023-02-27",
    isCompleted: false,
    time: "15:55");

final testTodosEntityCompleted = TodoEntity(
    id: 1,
    taskName: "test",
    description: "test",
    categoryCode: "testing",
    date: "2023-02-27",
    isCompleted: true,
    time: "15:55");

final testTodosEntityOngoing = TodoEntity(
    id: 1,
    taskName: "test",
    description: "test",
    categoryCode: "testing",
    date: "2023-02-27",
    isCompleted: false,
    time: "15:55");
