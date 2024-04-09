import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/usecase/save_todo.dart';
import 'package:praktitask/home/presentation/bloc/save_todo_bloc/save_todo_bloc.dart';

import '../../dummy_object.dart';
import '../../helper/test_helper.mocks.dart';
import 'save_todo_bloc_test.mocks.dart';

class MockBuildContext extends Mock implements BuildContext {}

@GenerateMocks([SaveTodoUsecase])
void main() {
  late SaveTodoBloc saveTodoBloc;
  late MockSaveTodoUsecase saveTodoUsecase;
  late MockHomeRepository mockHomeRepository;
  late MockBuildContext context;

  setUp(() {
    context = MockBuildContext();
    mockHomeRepository = MockHomeRepository();
    saveTodoUsecase = MockSaveTodoUsecase();
    saveTodoBloc = SaveTodoBloc(saveTodoUsecase, true);
  });

  test("initial state should be empty", () {
    expect(saveTodoBloc.state, SaveTodoInitial());
  });
  blocTest<SaveTodoBloc, SaveTodoState>(
    "should emit [loading, success] when data successfully saved",
    build: () {
      when(mockHomeRepository.saveTodo(testTodosEntity))
          .thenAnswer((realInvocation) async => Right(testTodosEntity));
      when(saveTodoUsecase.execute(testTodosEntity))
          .thenAnswer((realInvocation) async => Right(testTodosEntity));
      return saveTodoBloc;
    },
    act: (bloc) => bloc.add(DoSaveTodo(testTodosEntity)),
    wait: 1.seconds,
    expect: () => [SaveTodoLoadings(), SaveTodoSuccess(testTodosEntity)],
    verify: (bloc) {
      verify(saveTodoUsecase.execute(testTodosEntity));
    },
  );

  blocTest<SaveTodoBloc, SaveTodoState>(
    "should emit [loading, failure] when data failed saved",
    build: () {
      when(mockHomeRepository.saveTodo(testTodosEntity))
          .thenThrow((realInvocation) async => CommonException(''));
      when(saveTodoUsecase.execute(testTodosEntity))
          .thenAnswer((realInvocation) async => const Left(DatabaseFailure('')));
      return saveTodoBloc;
    },
    act: (bloc) => bloc.add(DoSaveTodo(testTodosEntity)),
    wait: 1.seconds,
    expect: () => [SaveTodoLoadings(), SaveTodoFailure("")],
    verify: (bloc) {
      verify(saveTodoUsecase.execute(testTodosEntity));
    },
  );
}
