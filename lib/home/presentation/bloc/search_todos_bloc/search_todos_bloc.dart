import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';
import 'package:praktitask/home/domain/usecase/search_todos.dart';

part 'search_todos_event.dart';
part 'search_todos_state.dart';

class SearchTodosBloc extends Bloc<SearchTodosEvent, SearchTodosState> {
  SearchTodosUsecase searchTodosUsecase;
  SearchTodosBloc(this.searchTodosUsecase) : super(SearchTodosInitial()) {
    on<DoSearchTodos>((event, emit) async {
      emit(SearchTodosLoadings());
      var response = await searchTodosUsecase.execute(event.query);
      response.fold((l) {
        emit(SearchTodosFailure(l.message));
      }, (r) {
        emit(SearchTodosSuccess(r));
      });
    }, transformer: debounce(1.seconds));
  }
}
