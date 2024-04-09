import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';
import 'package:praktitask/home/domain/repository/repository.dart';

class SearchTodosUsecase {
  HomeRepository homeRepository;
  SearchTodosUsecase(this.homeRepository);
  Future<Either<Failure, List<TodoEntity>>> execute(String query) {
    return homeRepository.searchTodos(query);
  }
}
