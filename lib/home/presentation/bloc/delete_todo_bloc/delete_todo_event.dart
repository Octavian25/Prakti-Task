part of 'delete_todo_bloc.dart';

@immutable
sealed class DeleteTodoEvent {}

class DoDeleteTodo extends DeleteTodoEvent {
  final int id;
  DoDeleteTodo(this.id);
}
