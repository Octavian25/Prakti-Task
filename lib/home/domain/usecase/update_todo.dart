import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';
import 'package:praktitask/home/domain/repository/repository.dart';

class UpdateTodoUsecase {
  HomeRepository homeRepository;
  UpdateTodoUsecase(this.homeRepository);
  Future<Either<Failure, int>> execute(TodoEntity todoEntity) {
    return homeRepository.updateTodo(todoEntity);
  }
}
