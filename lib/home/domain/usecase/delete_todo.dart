import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';
import 'package:praktitask/home/domain/repository/repository.dart';

class DeleteTodoUsecase {
  HomeRepository homeRepository;
  DeleteTodoUsecase(this.homeRepository);
  Future<Either<Failure, int>> execute(int id) {
    return homeRepository.deleteTodo(id);
  }
}
