import 'package:praktitask/home/data/models/todo_model.dart';
import 'package:praktitask/utility/database.dart';

abstract class HomeLocalDataSource {
  Future<TodoModel> saveTodo(TodoModel todo);
  Future<List<TodoModel>> fetchAllTodos(String? date);
  Future<List<TodoModel>> searchTodos(String query);
  Future<int> updateTodo(TodoModel todoModel);
  Future<int> deleteTodo(int id);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final DatabaseHelper databaseHelper;
  HomeLocalDataSourceImpl(this.databaseHelper);
  @override
  Future<int> deleteTodo(int id) async {
    try {
      var response = await databaseHelper.deleteTodo(id);
      return response;
    } catch (e) {
      throw Exception("Error deleting Todo data");
    }
  }

  @override
  Future<List<TodoModel>> fetchAllTodos(String? date) async {
    try {
      var response = await databaseHelper.getAllTodosOrderedByDateAndTime(date);
      return response;
    } catch (e) {
      throw Exception("Error Fetching all Todos");
    }
  }

  @override
  Future<TodoModel> saveTodo(TodoModel todo) async {
    try {
      var response = await databaseHelper.createTodo(todo);
      return response;
    } catch (e) {
      throw Exception("Error creating Todo");
    }
  }

  @override
  Future<int> updateTodo(TodoModel todoModel) async {
    try {
      var response = await databaseHelper.updateTodo(todoModel);
      return response;
    } catch (e) {
      throw Exception("Error Update Todos data");
    }
  }

  @override
  Future<List<TodoModel>> searchTodos(String query) async {
    try {
      var response = await databaseHelper.searchTodos(query);
      return response;
    } catch (e) {
      throw Exception("Error Search Todos data");
    }
  }
}
