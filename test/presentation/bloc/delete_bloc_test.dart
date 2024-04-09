import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/usecase/delete_todo.dart';
import 'package:praktitask/home/presentation/bloc/delete_todo_bloc/delete_todo_bloc.dart';

import '../../helper/test_helper.mocks.dart';
import 'delete_bloc_test.mocks.dart';

class MockBuildContext extends Mock implements BuildContext {}

@GenerateMocks([DeleteTodoUsecase])
void main() {
  late DeleteTodoBloc deleteTodoBloc;
  late MockDeleteTodoUsecase deleteTodoUsecase;
  late MockHomeRepository mockHomeRepository;
  late MockBuildContext context;

  setUp(() {
    context = MockBuildContext();
    mockHomeRepository = MockHomeRepository();
    deleteTodoUsecase = MockDeleteTodoUsecase();
    deleteTodoBloc = DeleteTodoBloc(deleteTodoUsecase);
  });

  test("initial state should be empty", () {
    expect(deleteTodoBloc.state, DeleteTodoInitial());
  });
  blocTest<DeleteTodoBloc, DeleteTodoState>(
    "should emit [loading, success] when data is deleted successfully",
    build: () {
      when(mockHomeRepository.deleteTodo(1)).thenAnswer((realInvocation) async => const Right(1));
      when(deleteTodoUsecase.execute(1)).thenAnswer((realInvocation) async => const Right(1));
      return deleteTodoBloc;
    },
    act: (bloc) => bloc.add(DoDeleteTodo(1)),
    wait: 1.seconds,
    expect: () => [DeleteTodoLoadings(), DeleteTodoSuccess(1)],
    verify: (bloc) {
      verify(deleteTodoUsecase.execute(1));
    },
  );

  blocTest<DeleteTodoBloc, DeleteTodoState>(
    "should emit [loading, failure] when data is deleted failed",
    build: () {
      when(mockHomeRepository.deleteTodo(1))
          .thenThrow((realInvocation) async => CommonException(''));
      when(deleteTodoUsecase.execute(1))
          .thenAnswer((realInvocation) async => const Left(DatabaseFailure('')));
      return deleteTodoBloc;
    },
    act: (bloc) => bloc.add(DoDeleteTodo(1)),
    wait: 1.seconds,
    expect: () => [DeleteTodoLoadings(), DeleteTodoFailure("")],
    verify: (bloc) {
      verify(deleteTodoUsecase.execute(1));
    },
  );
}
