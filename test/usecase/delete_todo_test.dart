import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/usecase/delete_todo.dart';

import '../helper/test_helper.mocks.dart';

void main() {
  late DeleteTodoUsecase usecase;
  late MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = DeleteTodoUsecase(mockHomeRepository);
  });

  test('should delete todo data from the repository', () async {
    when(mockHomeRepository.deleteTodo(1)).thenAnswer((realInvocation) async => const Right(1));
    final result = await usecase.execute(1);
    expect(result, const Right(1));
  });
}
