import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/usecase/delete_todo.dart';
import 'package:praktitask/home/domain/usecase/update_todo.dart';
import 'package:praktitask/home/presentation/bloc/delete_todo_bloc/delete_todo_bloc.dart';
import 'package:praktitask/home/presentation/bloc/update_todo_bloc/update_todo_bloc.dart';

import '../../dummy_object.dart';
import '../../helper/test_helper.mocks.dart';
import 'update_bloc_test.mocks.dart';

class MockBuildContext extends Mock implements BuildContext {}

@GenerateMocks([UpdateTodoUsecase])
void main() {
  late UpdateTodoBloc updateTodoBloc;
  late MockUpdateTodoUsecase updateTodoUsecase;
  late MockHomeRepository mockHomeRepository;
  late MockBuildContext context;

  setUp(() {
    context = MockBuildContext();
    mockHomeRepository = MockHomeRepository();
    updateTodoUsecase = MockUpdateTodoUsecase();
    updateTodoBloc = UpdateTodoBloc(updateTodoUsecase);
  });

  test("initial state should be empty", () {
    expect(updateTodoBloc.state, UpdateTodoInitial());
  });
  blocTest<UpdateTodoBloc, UpdateTodoState>(
    "should emit [loading, success] when data is updated successfully",
    build: () {
      when(mockHomeRepository.updateTodo(testTodosEntity))
          .thenAnswer((realInvocation) async => const Right(1));
      when(updateTodoUsecase.execute(testTodosEntity))
          .thenAnswer((realInvocation) async => const Right(1));
      return updateTodoBloc;
    },
    act: (bloc) => bloc.add(DoUpdateTodo(testTodosEntity)),
    wait: 1.seconds,
    expect: () => [UpdateTodoLoadings(), UpdateTodoSuccess(1)],
    verify: (bloc) {
      verify(updateTodoUsecase.execute(testTodosEntity));
    },
  );

  blocTest<UpdateTodoBloc, UpdateTodoState>(
    "should emit [loading, failure] when data is updated failed",
    build: () {
      when(mockHomeRepository.updateTodo(testTodosEntity))
          .thenThrow((realInvocation) async => CommonException(''));
      when(updateTodoUsecase.execute(testTodosEntity))
          .thenAnswer((realInvocation) async => const Left(DatabaseFailure('')));
      return updateTodoBloc;
    },
    act: (bloc) => bloc.add(DoUpdateTodo(testTodosEntity)),
    wait: 1.seconds,
    expect: () => [UpdateTodoLoadings(), UpdateTodoFailure("")],
    verify: (bloc) {
      verify(updateTodoUsecase.execute(testTodosEntity));
    },
  );
}
