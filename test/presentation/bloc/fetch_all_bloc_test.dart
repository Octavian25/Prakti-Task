import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/usecase/fetch_all_todos.dart';
import 'package:praktitask/home/presentation/bloc/delete_todo_bloc/delete_todo_bloc.dart';
import 'package:praktitask/home/presentation/bloc/fetch_all_todos_bloc/fetch_all_todos_bloc.dart';

import '../../dummy_object.dart';
import '../../helper/test_helper.mocks.dart';
import 'fetch_all_bloc_test.mocks.dart';

class MockBuildContext extends Mock implements BuildContext {}

@GenerateMocks([FetchAllTodosUsecase])
void main() {
  late FetchAllTodosBloc fetchAllTodosBloc;
  late MockFetchAllTodosUsecase fetchAllTodosUsecase;
  late MockHomeRepository mockHomeRepository;
  late MockBuildContext context;

  setUp(() {
    context = MockBuildContext();
    mockHomeRepository = MockHomeRepository();
    fetchAllTodosUsecase = MockFetchAllTodosUsecase();
    fetchAllTodosBloc = FetchAllTodosBloc(fetchAllTodosUsecase);
  });

  test("initial state should be empty", () {
    expect(fetchAllTodosBloc.state, FetchAllTodosInitial());
  });
  var selectedDateText =
      DateTime.parse("2012-02-27").toIso8601String().substring(0, 10).split("-").reversed.join("/");
  blocTest<FetchAllTodosBloc, FetchAllTodosState>(
    "should emit [loading, success] when fetched data is successfully",
    build: () {
      when(mockHomeRepository.fetchAllTodos(selectedDateText))
          .thenAnswer((realInvocation) async => Right(testTodosEntityList));
      when(fetchAllTodosUsecase.execute(selectedDateText))
          .thenAnswer((realInvocation) async => Right(testTodosEntityList));
      return fetchAllTodosBloc;
    },
    act: (bloc) => bloc.add(DoFetchAllTodos(date: DateTime.parse("2012-02-27"), filter: "ALL")),
    wait: 1.seconds,
    expect: () => [
      FetchAllTodosLoadings(),
      FetchAllTodosSuccess(testTodosEntityList,
          DateFormat('d MMMM, EEEE', 'en_US').format(DateTime.parse("2012-02-27")))
    ],
    verify: (bloc) {
      verify(fetchAllTodosUsecase.execute(selectedDateText));
    },
  );

  blocTest<FetchAllTodosBloc, FetchAllTodosState>(
    "should emit [loading, success] when fetched data is successfully",
    build: () {
      when(mockHomeRepository.fetchAllTodos(selectedDateText))
          .thenAnswer((realInvocation) async => Right(testTodosEntityList));
      when(fetchAllTodosUsecase.execute(selectedDateText))
          .thenAnswer((realInvocation) async => Right(testTodosEntityList));
      return fetchAllTodosBloc;
    },
    act: (bloc) => bloc.add(DoFetchAllTodos(date: DateTime.parse("2012-02-27"), filter: "ONGOING")),
    wait: 1.seconds,
    expect: () => [
      FetchAllTodosLoadings(),
      FetchAllTodosSuccess(
          testTodosEntityList.toList().filter((element) => element.isCompleted == false).toList(),
          DateFormat('d MMMM, EEEE', 'en_US').format(DateTime.parse("2012-02-27")))
    ],
    verify: (bloc) {
      verify(fetchAllTodosUsecase.execute(selectedDateText));
    },
  );

  blocTest<FetchAllTodosBloc, FetchAllTodosState>(
    "should emit [loading, success] when fetched data is successfully",
    build: () {
      when(mockHomeRepository.fetchAllTodos(selectedDateText))
          .thenAnswer((realInvocation) async => Right(testTodosEntityList));
      when(fetchAllTodosUsecase.execute(selectedDateText))
          .thenAnswer((realInvocation) async => Right(testTodosEntityList));
      return fetchAllTodosBloc;
    },
    act: (bloc) =>
        bloc.add(DoFetchAllTodos(date: DateTime.parse("2012-02-27"), filter: "COMPLETED")),
    wait: 1.seconds,
    expect: () => [
      FetchAllTodosLoadings(),
      FetchAllTodosSuccess(
          testTodosEntityList.toList().filter((element) => element.isCompleted == true).toList(),
          DateFormat('d MMMM, EEEE', 'en_US').format(DateTime.parse("2012-02-27")))
    ],
    verify: (bloc) {
      verify(fetchAllTodosUsecase.execute(selectedDateText));
    },
  );

  blocTest<FetchAllTodosBloc, FetchAllTodosState>(
    "should emit [loading, failure] when fetched data is failed",
    build: () {
      when(mockHomeRepository.fetchAllTodos(selectedDateText))
          .thenThrow((realInvocation) async => CommonException(''));
      when(fetchAllTodosUsecase.execute(selectedDateText))
          .thenAnswer((realInvocation) async => const Left(DatabaseFailure('')));
      return fetchAllTodosBloc;
    },
    act: (bloc) => bloc.add(DoFetchAllTodos(date: DateTime.parse("2012-02-27"), filter: "ALL")),
    wait: 1.seconds,
    expect: () => [FetchAllTodosLoadings(), FetchAllTodosFailure("")],
    verify: (bloc) {
      verify(fetchAllTodosUsecase.execute(selectedDateText));
    },
  );
}
