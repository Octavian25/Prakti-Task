import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';
import 'package:praktitask/home/domain/repository/repository.dart';

class FetchAllTodosUsecase {
  HomeRepository homeRepository;
  FetchAllTodosUsecase(this.homeRepository);
  Future<Either<Failure, List<TodoEntity>>> execute(String? date) {
    return homeRepository.fetchAllTodos(date);
  }
}
