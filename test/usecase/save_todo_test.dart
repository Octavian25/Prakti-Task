import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/usecase/save_todo.dart';

import '../dummy_object.dart';
import '../helper/test_helper.mocks.dart';

void main() {
  late SaveTodoUsecase usecase;
  late MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = SaveTodoUsecase(mockHomeRepository);
  });

  test("should save data to local storage from the repository", () async {
    when(mockHomeRepository.saveTodo(testTodosEntity))
        .thenAnswer((realInvocation) async => Right(testTodosEntity));
    final result = await usecase.execute(testTodosEntity);
    expect(result, Right(testTodosEntity));
  });
}
