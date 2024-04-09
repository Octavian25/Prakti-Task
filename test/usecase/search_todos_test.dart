import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/usecase/search_todos.dart';

import '../dummy_object.dart';
import '../helper/test_helper.mocks.dart';

void main() {
  late SearchTodosUsecase usecase;
  late MockHomeRepository mockHomeRepository;

  setUp(() async {
    mockHomeRepository = MockHomeRepository();
    usecase = SearchTodosUsecase(mockHomeRepository);
  });

  test("should return data from local storage from repository", () async {
    when(mockHomeRepository.searchTodos("query"))
        .thenAnswer((realInvocation) async => Right(testTodosEntityList));
    final result = await usecase.execute("query");
    expect(result, Right(testTodosEntityList));
  });
}
