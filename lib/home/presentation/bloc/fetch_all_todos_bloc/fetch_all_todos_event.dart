part of 'fetch_all_todos_bloc.dart';

@immutable
sealed class FetchAllTodosEvent {}

class DoFetchAllTodos extends FetchAllTodosEvent {
  final DateTime? date;
  final String? filter;
  DoFetchAllTodos({this.date, this.filter});
}
