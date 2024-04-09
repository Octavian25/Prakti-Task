part of 'save_todo_bloc.dart';

@immutable
sealed class SaveTodoEvent {}

class DoSaveTodo extends SaveTodoEvent {
  final TodoEntity todoEntity;
  DoSaveTodo(this.todoEntity);
}
