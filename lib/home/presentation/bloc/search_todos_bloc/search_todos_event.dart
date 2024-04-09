part of 'search_todos_bloc.dart';

@immutable
sealed class SearchTodosEvent {}

class DoSearchTodos extends SearchTodosEvent {
  final String query;
  DoSearchTodos(this.query);
}
