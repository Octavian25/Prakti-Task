import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';
import 'package:praktitask/home/domain/usecase/save_todo.dart';
import 'package:praktitask/utility/notification_handler.dart';

part 'save_todo_event.dart';
part 'save_todo_state.dart';

class SaveTodoBloc extends Bloc<SaveTodoEvent, SaveTodoState> {
  SaveTodoUsecase saveTodoUsecase;
  bool isTesting = false;
  SaveTodoBloc(this.saveTodoUsecase, this.isTesting) : super(SaveTodoInitial()) {
    on<DoSaveTodo>((event, emit) async {
      emit(SaveTodoLoadings());
      var response = await saveTodoUsecase.execute(event.todoEntity);
      response.fold((l) {
        emit(SaveTodoFailure(l.message));
      }, (r) {
        if (!isTesting) {
          DateTime dateTime = DateTime.parse(
              "${event.todoEntity.date.split("/").reversed.join("-")} ${event.todoEntity.time}");
          NotificationHandler().createScheduleNotification(dateTime);
        }

        emit(SaveTodoSuccess(r));
      });
    });
  }
}
