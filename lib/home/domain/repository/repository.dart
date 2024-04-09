import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, TodoEntity>> saveTodo(TodoEntity todoEntity);
  Future<Either<Failure, List<TodoEntity>>> fetchAllTodos(String? date);
  Future<Either<Failure, List<TodoEntity>>> searchTodos(String query);
  Future<Either<Failure, int>> deleteTodo(int id);
  Future<Either<Failure, int>> updateTodo(TodoEntity todoEntity);
}
