import 'package:dartz/dartz.dart';
import 'package:os_basecode/os_basecode.dart';

import 'package:os_basecode/utilities/failure.dart';

import 'package:praktitask/home/domain/entities/todo_entity.dart';

import '../datasource/home_local_datasource.dart';
import '../datasource/home_remote_datasource.dart';
import '../../domain/repository/repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeLocalDataSource homeLocalDataSource;
  HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImpl(this.homeLocalDataSource, this.homeRemoteDataSource);

  @override
  Future<Either<Failure, int>> deleteTodo(int id) async {
    try {
      var response = await homeLocalDataSource.deleteTodo(id);
      return Right(response);
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCF01] We got some problem with our service, please try again'));
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> fetchAllTodos(String? date) async {
    try {
      var response = await homeLocalDataSource.fetchAllTodos(date);
      return Right(response.map((e) => e.toEntity()).toList());
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCF02] We got some problem with our service, please try again'));
    }
  }

  @override
  Future<Either<Failure, TodoEntity>> saveTodo(TodoEntity todoEntity) async {
    try {
      var response = await homeLocalDataSource.saveTodo(todoEntity.toModel());
      return Right(response.toEntity());
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCF03] We got some problem with our service, please try again'));
    }
  }

  @override
  Future<Either<Failure, int>> updateTodo(TodoEntity todoEntity) async {
    try {
      var response = await homeLocalDataSource.updateTodo(todoEntity.toModel());
      return Right(response);
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCF04] We got some problem with our service, please try again'));
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> searchTodos(String query) async {
    try {
      var response = await homeLocalDataSource.searchTodos(query);
      return Right(response.map((e) => e.toEntity()).toList());
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCF05] We got some problem with our service, please try again'));
    }
  }
}
