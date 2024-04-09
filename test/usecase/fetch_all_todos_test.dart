import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/usecase/fetch_all_todos.dart';

import '../dummy_object.dart';
import '../helper/test_helper.mocks.dart';

void main() {
  late FetchAllTodosUsecase usecase;
  late MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = FetchAllTodosUsecase(mockHomeRepository);
  });

  test("should get all todos from the repository", () async {
    when(mockHomeRepository.fetchAllTodos(null))
        .thenAnswer((realInvocation) async => Right(testTodosEntityList));
    final result = await usecase.execute(null);
    expect(result, Right(testTodosEntityList));
  });
}
