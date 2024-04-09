import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:praktitask/utility/database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../dummy_object.dart';
import '../helper/test_helper.mocks.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  test("createTodo inserts a todo into the database", () async {
    final dbHelper = DatabaseHelper.instance;
    await expectLater(await dbHelper.createTodo(testTodosModelWithoutID), testTodosModelWithoutID);
  });
  test("readTodo retrieves a todo by id from the database", () async {
    final dbHelper = DatabaseHelper.instance;
    await expectLater(
        await dbHelper.readTodo(testTodosModelWithoutID.id!), equals(testTodosModelWithoutID));
  });
  test("getAllTodosOrderedByDateAndTime retrieves a todo by date from the database", () async {
    final dbHelper = DatabaseHelper.instance;
    final result = await dbHelper.getAllTodosOrderedByDateAndTime(testTodosModelWithoutID.date);
    expect(result.length, greaterThan(0));
  });
  test(
      "getAllTodosOrderedByDateAndTime with parameter null retrieves a todo by date from the database",
      () async {
    final dbHelper = DatabaseHelper.instance;
    final result = await dbHelper.getAllTodosOrderedByDateAndTime(null);
    expect(result.length, greaterThan(0));
  });
  test("searchTodos retrieves a todo by date from the database", () async {
    final dbHelper = DatabaseHelper.instance;
    final result = await dbHelper.searchTodos(testTodosModelWithoutID.taskName);
    expect(result.length, greaterThan(0));
  });
  test("searchTodos with parameter empty retrieves a todo by date from the database", () async {
    final dbHelper = DatabaseHelper.instance;
    final result = await dbHelper.searchTodos("");
    expect(result.length, greaterThan(0));
  });
  test("updateTodo retrieves a todo by date from the database", () async {
    final dbHelper = DatabaseHelper.instance;
    final result = await dbHelper.updateTodo(testTodosModelWithoutID);
    expect(result, 1);
  });
  test("deleteTodo retrieves a todo by id from the database", () async {
    final dbHelper = DatabaseHelper.instance;
    final result = await dbHelper.deleteTodo(testTodosModelWithoutID.id!);
    expect(result, 1);
  });
  test("should call close on the database", () async {
    //arrange
    final dbhelper = MockDatabaseHelper();
    when(dbhelper.close()).thenAnswer((realInvocation) async => null);

    // Act
    await dbhelper.close();

    //assert
    verify(dbhelper.close()).called(1);
  });
}
