part of 'update_todo_bloc.dart';

@immutable
sealed class UpdateTodoEvent {}

class DoUpdateTodo extends UpdateTodoEvent {
  final TodoEntity todoEntity;
  DoUpdateTodo(this.todoEntity);
}
