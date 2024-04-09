part of 'search_todos_bloc.dart';

@immutable
abstract class SearchTodosState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SearchTodosInitial extends SearchTodosState {}

class SearchTodosLoadings extends SearchTodosState {}

class SearchTodosSuccess extends SearchTodosState {
  final List<TodoEntity> datas;
  SearchTodosSuccess(this.datas);
  @override
  List<Object?> get props => [datas];
}

class SearchTodosFailure extends SearchTodosState {
  final String message;
  SearchTodosFailure(this.message);
  @override
  List<Object?> get props => [message];
}
