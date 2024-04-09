import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:praktitask/home/domain/usecase/delete_todo.dart';

part 'delete_todo_event.dart';
part 'delete_todo_state.dart';

class DeleteTodoBloc extends Bloc<DeleteTodoEvent, DeleteTodoState> {
  DeleteTodoUsecase deleteTodoUsecase;
  DeleteTodoBloc(this.deleteTodoUsecase) : super(DeleteTodoInitial()) {
    on<DoDeleteTodo>((event, emit) async {
      emit(DeleteTodoLoadings());
      var response = await deleteTodoUsecase.execute(event.id);
      response.fold((l) {
        emit(DeleteTodoFailure(l.message));
      }, (r) {
        emit(DeleteTodoSuccess(r));
      });
    });
  }
}
