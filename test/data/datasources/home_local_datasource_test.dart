import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:praktitask/home/data/datasource/home_local_datasource.dart';

import '../../dummy_object.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late HomeLocalDataSourceImpl datasoure;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    datasoure = HomeLocalDataSourceImpl(mockDatabaseHelper);
  });

  group("Fetch All Todos", () {
    test("should return todos list when data is found", () async {
      const date = "2024-03-27";
      //arrange
      when(mockDatabaseHelper.getAllTodosOrderedByDateAndTime(date))
          .thenAnswer((realInvocation) async => testTodosModelList);
      //act
      final result = await datasoure.fetchAllTodos(date);
      //assert
      expect(result, testTodosModelList);
    });
    test("should return empty list when data is empty", () async {
      const date = "2024-03-27";
      //arrange
      when(mockDatabaseHelper.getAllTodosOrderedByDateAndTime(date))
          .thenAnswer((realInvocation) async => []);
      //act
      final result = await datasoure.fetchAllTodos(date);
      //assert
      expect(result, []);
    });
    test("should throw Exception when data is not found", () async {
      const date = "2024-03-27";
      //arrange
      when(mockDatabaseHelper.getAllTodosOrderedByDateAndTime(date))
          .thenThrow(Exception("Error Fetching all Todos"));
      //act&assert
      await expectLater(datasoure.fetchAllTodos(date), throwsA(isA<Exception>()));
    });
  });

  group("save todo", () {
    test("should return TodoModel when insert to database is success", () async {
      //arrange
      when(mockDatabaseHelper.createTodo(testTodosModel))
          .thenAnswer((realInvocation) async => testTodosModel);

      //act
      final result = await datasoure.saveTodo(testTodosModel);
      expect(result, testTodosModel);
    });
    test("should throw Exception when insert to database is failed", () async {
      // Arrange
      when(mockDatabaseHelper.createTodo(testTodosModel))
          .thenThrow(Exception("Error creating Todo"));

      // Act & Assert
      await expectLater(datasoure.saveTodo(testTodosModel), throwsA(isA<Exception>()));
    });
  });

  group("edit todo", () {
    test("should return besides 0 when update to database is success", () async {
      //arrange
      when(mockDatabaseHelper.updateTodo(testTodosModel)).thenAnswer((realInvocation) async => 1);

      //act
      final result = await datasoure.updateTodo(testTodosModel);
      expect(result, 1);
    });
    test("should throw Exception when update to database is failed", () async {
      //arrange
      when(mockDatabaseHelper.createTodo(testTodosModel)).thenThrow(Exception());
      //act & assert
      await expectLater(datasoure.updateTodo(testTodosModel), throwsA(isA<Exception>()));
    });
  });

  group("delete todo", () {
    test("should return besides 0 when delete to database is success", () async {
      //arrange
      when(mockDatabaseHelper.deleteTodo(1)).thenAnswer((realInvocation) async => 1);
      //act
      final result = await datasoure.deleteTodo(1);
      expect(result, 1);
    });
    test("should throw Exception when delete to database is failed", () async {
      //arrange
      when(mockDatabaseHelper.deleteTodo(1)).thenThrow(Exception());
      //act & assert
      await expectLater(datasoure.deleteTodo(1), throwsA(isA<Exception>()));
    });
  });

  group("search todo", () {
    test("should return TodoModel when searched data on database is founded", () async {
      //arrange
      when(mockDatabaseHelper.searchTodos("test"))
          .thenAnswer((realInvocation) async => testTodosModelList);
      //act
      final result = await datasoure.searchTodos("test");
      expect(result, testTodosModelList);
    });
    test("should throw Exception when searched data on database is not found", () async {
      // Arrange
      when(mockDatabaseHelper.searchTodos("test")).thenThrow(Exception("Error Search Todos data"));
      // Act & Assert
      await expectLater(datasoure.searchTodos("test"), throwsA(isA<Exception>()));
    });
  });
}
