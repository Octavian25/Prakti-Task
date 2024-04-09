import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/data/datasource/home_local_datasource.dart';
import 'package:praktitask/home/data/datasource/home_remote_datasource.dart';
import 'package:praktitask/home/data/repository/home_repository.dart';
import 'package:praktitask/home/domain/repository/repository.dart';
import 'package:praktitask/home/domain/usecase/delete_todo.dart';
import 'package:praktitask/home/domain/usecase/fetch_all_todos.dart';
import 'package:praktitask/home/domain/usecase/save_todo.dart';
import 'package:praktitask/home/domain/usecase/search_todos.dart';
import 'package:praktitask/home/domain/usecase/update_todo.dart';
import 'package:praktitask/home/presentation/bloc/delete_todo_bloc/delete_todo_bloc.dart';
import 'package:praktitask/home/presentation/bloc/fetch_all_todos_bloc/fetch_all_todos_bloc.dart';
import 'package:praktitask/home/presentation/bloc/save_todo_bloc/save_todo_bloc.dart';
import 'package:praktitask/home/presentation/bloc/search_todos_bloc/search_todos_bloc.dart';
import 'package:praktitask/home/presentation/bloc/update_todo_bloc/update_todo_bloc.dart';
import 'package:praktitask/utility/database.dart';

var locator = GetIt.instance;

void init() {
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);

  locator.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(locator(), locator()));
  locator.registerLazySingleton<HomeLocalDataSource>(() => HomeLocalDataSourceImpl(locator()));
  locator.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl());
  locator.registerLazySingleton(() => SaveTodoUsecase(locator()));
  locator.registerLazySingleton(() => UpdateTodoUsecase(locator()));
  locator.registerLazySingleton(() => DeleteTodoUsecase(locator()));
  locator.registerLazySingleton(() => FetchAllTodosUsecase(locator()));
  locator.registerLazySingleton(() => SearchTodosUsecase(locator()));

  locator.registerLazySingleton(() => DeleteTodoBloc(locator()));
  locator.registerLazySingleton(() => FetchAllTodosBloc(locator()));
  locator.registerLazySingleton(() => SaveTodoBloc(locator(), false));
  locator.registerLazySingleton(() => UpdateTodoBloc(locator()));
  locator.registerLazySingleton(() => SearchTodosBloc(locator()));
}
