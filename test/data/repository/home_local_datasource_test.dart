import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/data/repository/home_repository.dart';

import '../../dummy_object.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late HomeRepositoryImpl repository;
  late MockHomeLocalDataSource mockHomeLocalDataSource;
  late MockHomeRemoteDataSource mockHomeRemoteDataSource;

  setUp(() {
    mockHomeLocalDataSource = MockHomeLocalDataSource();
    mockHomeRemoteDataSource = MockHomeRemoteDataSource();
    repository = HomeRepositoryImpl(mockHomeLocalDataSource, mockHomeRemoteDataSource);
  });

  group("Get Todos", () {
    test("should return local data when the call to local data source is successful", () async {
      //arrange
      when(mockHomeLocalDataSource.fetchAllTodos(testTodosModelWithoutID.date))
          .thenAnswer((realInvocation) async => testTodosModelList);
      //act
      final result = await repository.fetchAllTodos(testTodosModelWithoutID.date);
      //assert
      verify(mockHomeLocalDataSource.fetchAllTodos(testTodosModelWithoutID.date));
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTodosEntityList);
    });
    test("should throw CommonException when the call to local data source is failed", () async {
      //arrange
      when(mockHomeLocalDataSource.fetchAllTodos(testTodosModelWithoutID.date))
          .thenThrow(CommonException(''));
      //act
      final result = await repository.fetchAllTodos(testTodosModelWithoutID.date);
      //assert
      verify(mockHomeLocalDataSource.fetchAllTodos(testTodosModelWithoutID.date));
      expect(result, equals(const Left(CommonFailure(''))));
    });
  });

  group("Delete Todos", () {
    test("should return != 0 when the call to local data source is successful", () async {
      //arrange
      when(mockHomeLocalDataSource.deleteTodo(1)).thenAnswer((realInvocation) async => 1);
      //act
      final result = await repository.deleteTodo(1);
      //assert
      verify(mockHomeLocalDataSource.deleteTodo(1));
      final resultList = result.getOrElse(() => 1);
      expect(resultList, 1);
    });
    test("should throw CommonException when the call to local data source is failed", () async {
      //arrange
      when(mockHomeLocalDataSource.deleteTodo(1)).thenThrow(CommonException(''));
      //act
      final result = await repository.deleteTodo(1);
      //assert
      verify(mockHomeLocalDataSource.deleteTodo(1));
      expect(result, equals(const Left(CommonFailure(''))));
    });
  });

  group("Save Todos", () {
    test("should Entity when the call to local data source is successful", () async {
      //arrange
      when(mockHomeLocalDataSource.saveTodo(testTodosModel))
          .thenAnswer((realInvocation) async => testTodosModel);
      //act
      final result = await repository.saveTodo(testTodosEntity);
      //assert
      verify(mockHomeLocalDataSource.saveTodo(testTodosModel));
      final resultList = result.getOrElse(() => testTodosEntity);
      expect(resultList, testTodosEntity);
    });
    test("should throw CommonException when the call to local data source is failed", () async {
      //arrange
      when(mockHomeLocalDataSource.saveTodo(testTodosModel)).thenThrow(CommonException(''));
      //act
      final result = await repository.saveTodo(testTodosEntity);
      //assert
      verify(mockHomeLocalDataSource.saveTodo(testTodosModel));
      expect(result, equals(const Left(CommonFailure(''))));
    });
  });

  group("Update Todos", () {
    test("should Entity when the call to local data source is successful", () async {
      //arrange
      when(mockHomeLocalDataSource.updateTodo(testTodosModel))
          .thenAnswer((realInvocation) async => 1);
      //act
      final result = await repository.updateTodo(testTodosEntity);
      //assert
      verify(mockHomeLocalDataSource.updateTodo(testTodosModel));
      final resultList = result.getOrElse(() => 1);
      expect(resultList, 1);
    });
    test("should throw CommonException when the call to local data source is failed", () async {
      //arrange
      when(mockHomeLocalDataSource.updateTodo(testTodosModel)).thenThrow(CommonException(''));
      //act
      final result = await repository.updateTodo(testTodosEntity);
      //assert
      verify(mockHomeLocalDataSource.updateTodo(testTodosModel));
      expect(result, equals(const Left(CommonFailure(''))));
    });
  });

  group("Search Todos", () {
    test("should Entity when the call to local data source is successful", () async {
      //arrange
      when(mockHomeLocalDataSource.searchTodos("query"))
          .thenAnswer((realInvocation) async => testTodosModelList);
      //act
      final result = await repository.searchTodos("query");
      //assert
      verify(mockHomeLocalDataSource.searchTodos("query"));
      final resultList = result.getOrElse(() => testTodosEntityList);
      expect(resultList, testTodosEntityList);
    });
    test("should throw CommonException when the call to local data source is failed", () async {
      //arrange
      when(mockHomeLocalDataSource.searchTodos("query")).thenThrow(CommonException(''));
      //act
      final result = await repository.searchTodos("query");
      //assert
      verify(mockHomeLocalDataSource.searchTodos("query"));
      expect(result, equals(const Left(CommonFailure(''))));
    });
  });
}
