import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';
import 'package:praktitask/home/domain/usecase/update_todo.dart';

part 'update_todo_event.dart';
part 'update_todo_state.dart';

class UpdateTodoBloc extends Bloc<UpdateTodoEvent, UpdateTodoState> {
  UpdateTodoUsecase updateTodoUsecase;
  UpdateTodoBloc(this.updateTodoUsecase) : super(UpdateTodoInitial()) {
    on<DoUpdateTodo>((event, emit) async {
      emit(UpdateTodoLoadings());
      var response = await updateTodoUsecase.execute(event.todoEntity);
      response.fold((l) {
        emit(UpdateTodoFailure(l.message));
      }, (r) {
        emit(UpdateTodoSuccess(r));
      });
    });
  }
}
