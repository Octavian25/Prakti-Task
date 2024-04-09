import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/usecase/delete_todo.dart';
import 'package:praktitask/home/domain/usecase/search_todos.dart';
import 'package:praktitask/home/presentation/bloc/delete_todo_bloc/delete_todo_bloc.dart';
import 'package:praktitask/home/presentation/bloc/search_todos_bloc/search_todos_bloc.dart';

import '../../dummy_object.dart';
import '../../helper/test_helper.mocks.dart';
import 'search_todos_bloc_test.mocks.dart';

class MockBuildContext extends Mock implements BuildContext {}

@GenerateMocks([SearchTodosUsecase])
void main() {
  late SearchTodosBloc searchTodosBloc;
  late MockSearchTodosUsecase searchTodosUsecase;
  late MockHomeRepository mockHomeRepository;
  late MockBuildContext context;

  setUp(() {
    context = MockBuildContext();
    mockHomeRepository = MockHomeRepository();
    searchTodosUsecase = MockSearchTodosUsecase();
    searchTodosBloc = SearchTodosBloc(searchTodosUsecase);
  });

  test("initial state should be empty", () {
    expect(searchTodosBloc.state, SearchTodosInitial());
  });
  blocTest<SearchTodosBloc, SearchTodosState>(
    "should emit [loading, success] when data is search successfully",
    build: () {
      when(mockHomeRepository.searchTodos(""))
          .thenAnswer((realInvocation) async => Right(testTodosEntityList));
      when(searchTodosUsecase.execute(""))
          .thenAnswer((realInvocation) async => Right(testTodosEntityList));
      return searchTodosBloc;
    },
    act: (bloc) => bloc.add(DoSearchTodos("")),
    wait: 1.seconds,
    expect: () => [SearchTodosLoadings(), SearchTodosSuccess(testTodosEntityList)],
    verify: (bloc) {
      verify(searchTodosUsecase.execute(""));
    },
  );

  blocTest<SearchTodosBloc, SearchTodosState>(
    "should emit [loading, failure] when data is search failed",
    build: () {
      when(mockHomeRepository.searchTodos(""))
          .thenThrow((realInvocation) async => CommonException(''));
      when(searchTodosUsecase.execute(""))
          .thenAnswer((realInvocation) async => const Left(DatabaseFailure('')));
      return searchTodosBloc;
    },
    act: (bloc) => bloc.add(DoSearchTodos("")),
    wait: 1.seconds,
    expect: () => [SearchTodosLoadings(), SearchTodosFailure("")],
    verify: (bloc) {
      verify(searchTodosUsecase.execute(""));
    },
  );
}
