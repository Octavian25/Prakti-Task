import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';
import 'package:praktitask/home/domain/repository/repository.dart';

class SaveTodoUsecase {
  HomeRepository homeRepository;
  SaveTodoUsecase(this.homeRepository);
  Future<Either<Failure, TodoEntity>> execute(TodoEntity todoEntity) {
    return homeRepository.saveTodo(todoEntity);
  }
}
