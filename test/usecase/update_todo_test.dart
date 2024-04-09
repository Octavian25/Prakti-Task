import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/usecase/update_todo.dart';

import '../dummy_object.dart';
import '../helper/test_helper.mocks.dart';

void main() {
  late UpdateTodoUsecase usecase;
  late MockHomeRepository mockHomeRepository;

  setUp(() async {
    mockHomeRepository = MockHomeRepository();
    usecase = UpdateTodoUsecase(mockHomeRepository);
  });

  test("should return entity when update local from repository", () async {
    when(mockHomeRepository.updateTodo(testTodosEntity))
        .thenAnswer((realInvocation) async => const Right(1));
    final result = await usecase.execute(testTodosEntity);
    expect(result, const Right(1));
  });
}
