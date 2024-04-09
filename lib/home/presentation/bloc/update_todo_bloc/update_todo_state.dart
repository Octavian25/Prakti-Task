part of 'update_todo_bloc.dart';

@immutable
abstract class UpdateTodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class UpdateTodoInitial extends UpdateTodoState {}

class UpdateTodoLoadings extends UpdateTodoState {}

class UpdateTodoSuccess extends UpdateTodoState {
  final int datas;
  UpdateTodoSuccess(this.datas);
  @override
  List<Object?> get props => [datas];
}

class UpdateTodoFailure extends UpdateTodoState {
  final String message;
  UpdateTodoFailure(this.message);
  @override
  List<Object?> get props => [message];
}
