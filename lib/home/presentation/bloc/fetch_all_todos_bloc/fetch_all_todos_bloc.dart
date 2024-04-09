import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';
import 'package:praktitask/home/domain/usecase/fetch_all_todos.dart';

part 'fetch_all_todos_event.dart';
part 'fetch_all_todos_state.dart';

class FetchAllTodosBloc extends Bloc<FetchAllTodosEvent, FetchAllTodosState> {
  FetchAllTodosUsecase fetchAllTodosUsecase;
  FetchAllTodosBloc(this.fetchAllTodosUsecase) : super(FetchAllTodosInitial()) {
    DateTime lastDate;
    on<DoFetchAllTodos>((event, emit) async {
      lastDate = event.date ?? DateTime.now();
      emit(FetchAllTodosLoadings());
      var response = await fetchAllTodosUsecase
          .execute(lastDate.toIso8601String().substring(0, 10).split("-").reversed.join("/"));
      // Menggunakan format 'd MMMM, EEEE' dengan asumsi penggunaan bahasa Inggris
      var selectedDate = DateFormat('d MMMM, EEEE', 'en_US').format(lastDate);
      response.fold((l) {
        emit(FetchAllTodosFailure(l.message));
      }, (r) {
        List<TodoEntity> result = r;
        if (event.filter != null && event.filter == "ONGOING") {
          result = r.toList().filter((element) => element.isCompleted == false).toList();
        } else if (event.filter != null && event.filter == "COMPLETED") {
          result = r.toList().filter((element) => element.isCompleted == true).toList();
        }
        emit(FetchAllTodosSuccess(result, selectedDate));
      });
    });
  }
}
