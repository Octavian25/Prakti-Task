part of 'delete_todo_bloc.dart';

@immutable
abstract class DeleteTodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class DeleteTodoInitial extends DeleteTodoState {}

class DeleteTodoLoadings extends DeleteTodoState {}

class DeleteTodoSuccess extends DeleteTodoState {
  final int datas;
  DeleteTodoSuccess(this.datas);
  @override
  List<Object?> get props => [datas];
}

class DeleteTodoFailure extends DeleteTodoState {
  final String message;
  DeleteTodoFailure(this.message);
  @override
  List<Object?> get props => [message];
}
