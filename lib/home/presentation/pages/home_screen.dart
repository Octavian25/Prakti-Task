import 'package:flutter/material.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';
import 'package:praktitask/home/presentation/bloc/delete_todo_bloc/delete_todo_bloc.dart';
import 'package:praktitask/home/presentation/bloc/fetch_all_todos_bloc/fetch_all_todos_bloc.dart';
import 'package:praktitask/home/presentation/bloc/update_todo_bloc/update_todo_bloc.dart';
import 'package:praktitask/home/presentation/widgets/add_todo.dart';
import 'package:praktitask/home/presentation/widgets/empty_list.dart';
import 'package:praktitask/home/presentation/widgets/todo_card.dart';
import 'package:praktitask/utility/notification_handler.dart';
import 'package:praktitask/utility/permission_handler.dart';
import 'package:praktitask/utility/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ValueNotifier<String> filter = ValueNotifier("ALL");
  @override
  void initState() {
    context.read<FetchAllTodosBloc>().add(DoFetchAllTodos());
    requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteTodoBloc, DeleteTodoState>(
      listener: (context, state) {
        if (state is DeleteTodoSuccess) {
          context.read<FetchAllTodosBloc>().add(DoFetchAllTodos());
        }
      },
      child: BlocConsumer<UpdateTodoBloc, UpdateTodoState>(
        listener: (context, state) {
          if (state is UpdateTodoSuccess) {
            context.read<FetchAllTodosBloc>().add(DoFetchAllTodos());
          }
        },
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      content: AddNewTask(),
                    ),
                  );
                },
                child: const Icon(Icons.add)),
            body: BlocBuilder<FetchAllTodosBloc, FetchAllTodosState>(
              builder: (context, state) {
                if (state is FetchAllTodosSuccess) {
                  List<TodoEntity> listTodos = state.datas;
                  if (listTodos.isEmpty) {
                    return ValueListenableBuilder(
                      valueListenable: filter,
                      builder: (context, value, child) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.dg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.verticalSpacingDiagonal,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Your Tasks",
                                  style: bold.copyWith(fontSize: 14.sp),
                                ),
                                Text(
                                  state.dateSelected,
                                  style: normal.copyWith(fontSize: 11.sp),
                                ),
                              ],
                            ),
                            10.verticalSpacingDiagonal,
                            Wrap(
                              children: [
                                InkWell(
                                  onTap: () {
                                    filter.value = "ALL";
                                    context.read<FetchAllTodosBloc>().add(DoFetchAllTodos());
                                  },
                                  child: Ink(
                                    padding: EdgeInsets.symmetric(horizontal: 8.dg, vertical: 5.dg),
                                    child: Text(
                                      "ALL",
                                      style: TextStyle(
                                          color: value == "ALL" ? primary : null,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    filter.value = "ONGOING";
                                    context
                                        .read<FetchAllTodosBloc>()
                                        .add(DoFetchAllTodos(filter: "ONGOING"));
                                  },
                                  child: Ink(
                                    padding: EdgeInsets.symmetric(horizontal: 8.dg, vertical: 5.dg),
                                    child: Text(
                                      "Ongoing",
                                      style: TextStyle(
                                          color: value == "ONGOING" ? primary : null,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    filter.value = "COMPLETED";
                                    context
                                        .read<FetchAllTodosBloc>()
                                        .add(DoFetchAllTodos(filter: "COMPLETED"));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8.dg, vertical: 5.dg),
                                    child: Text(
                                      "Completed",
                                      style: TextStyle(
                                          color: value == "COMPLETED" ? primary : null,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            10.verticalSpacingDiagonal,
                            const EmptyList()
                          ],
                        ),
                      ),
                    );
                  } else {
                    return ValueListenableBuilder(
                      valueListenable: filter,
                      builder: (context, value, child) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.dg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.verticalSpacingDiagonal,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Your Tasks",
                                  style: bold.copyWith(fontSize: 14.sp),
                                ),
                                Text(
                                  state.dateSelected,
                                  style: normal.copyWith(fontSize: 11.sp),
                                ),
                              ],
                            ),
                            10.verticalSpacingDiagonal,
                            Wrap(
                              children: [
                                InkWell(
                                  onTap: () {
                                    filter.value = "ALL";
                                    context.read<FetchAllTodosBloc>().add(DoFetchAllTodos());
                                  },
                                  child: Ink(
                                    padding: EdgeInsets.symmetric(horizontal: 8.dg, vertical: 5.dg),
                                    child: Text(
                                      "ALL",
                                      style: TextStyle(
                                          color: value == "ALL" ? primary : null,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    filter.value = "ONGOING";
                                    context
                                        .read<FetchAllTodosBloc>()
                                        .add(DoFetchAllTodos(filter: "ONGOING"));
                                  },
                                  child: Ink(
                                    padding: EdgeInsets.symmetric(horizontal: 8.dg, vertical: 5.dg),
                                    child: Text(
                                      "Ongoing",
                                      style: TextStyle(
                                          color: value == "ONGOING" ? primary : null,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    filter.value = "COMPLETED";
                                    context
                                        .read<FetchAllTodosBloc>()
                                        .add(DoFetchAllTodos(filter: "COMPLETED"));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8.dg, vertical: 5.dg),
                                    child: Text(
                                      "Completed",
                                      style: TextStyle(
                                          color: value == "COMPLETED" ? primary : null,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            10.verticalSpacingDiagonal,
                            Expanded(
                                child: ListView.separated(
                              separatorBuilder: (context, index) => 10.verticalSpacingDiagonal,
                              itemBuilder: (context, index) {
                                return TodoCard(todoEntity: state.datas[index]);
                              },
                              itemCount: state.datas.length,
                            ))
                          ],
                        ),
                      ),
                    );
                  }
                } else {
                  return Container();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
