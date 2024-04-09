part of 'save_todo_bloc.dart';

@immutable
abstract class SaveTodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SaveTodoInitial extends SaveTodoState {}

class SaveTodoLoadings extends SaveTodoState {}

class SaveTodoSuccess extends SaveTodoState {
  final TodoEntity datas;
  SaveTodoSuccess(this.datas);
  @override
  List<Object?> get props => [datas];
}

class SaveTodoFailure extends SaveTodoState {
  final String message;
  SaveTodoFailure(this.message);
  @override
  List<Object?> get props => [message];
}
