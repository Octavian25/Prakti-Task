part of 'fetch_all_todos_bloc.dart';

@immutable
abstract class FetchAllTodosState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class FetchAllTodosInitial extends FetchAllTodosState {}

class FetchAllTodosLoadings extends FetchAllTodosState {}

class FetchAllTodosSuccess extends FetchAllTodosState {
  final List<TodoEntity> datas;
  final String dateSelected;
  FetchAllTodosSuccess(this.datas, this.dateSelected);
  @override
  List<Object?> get props => [datas, dateSelected];
}

class FetchAllTodosFailure extends FetchAllTodosState {
  final String message;
  FetchAllTodosFailure(this.message);
  @override
  List<Object?> get props => [message];
}
