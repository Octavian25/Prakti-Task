import 'package:flutter/material.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';
import 'package:praktitask/home/domain/usecase/search_todos.dart';
import 'package:praktitask/home/presentation/bloc/search_todos_bloc/search_todos_bloc.dart';
import 'package:praktitask/home/presentation/widgets/todo_card.dart';
import 'package:praktitask/utility/custom_form_field.dart';
import 'package:praktitask/utility/styles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ValueNotifier<String> queryNotifier = ValueNotifier("");

  @override
  void initState() {
    searchController.addListener(() {
      context.read<SearchTodosBloc>().add(DoSearchTodos(searchController.text));
      queryNotifier.value = searchController.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFormField(controller: searchController, title: "", hint: "Seach Here.."),
            10.verticalSpaceFromWidth,
            ValueListenableBuilder(
              valueListenable: queryNotifier,
              builder: (context, value, child) {
                if (value.isNotEmpty) {
                  return Text(
                    "Showing Result For: $value",
                    style: normal.copyWith(fontSize: 11.sp),
                  );
                } else {
                  return Container();
                }
              },
            ),
            10.verticalSpaceFromWidth,
            BlocBuilder<SearchTodosBloc, SearchTodosState>(
              builder: (context, state) {
                if (state is SearchTodosSuccess) {
                  List<TodoEntity> todos = state.datas;
                  if (todos.isEmpty) {
                    return const EmptySearch();
                  } else {
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => TodoCard(
                          todoEntity: todos[index],
                        ),
                        itemCount: todos.length,
                        separatorBuilder: (context, index) => 10.verticalSpacingDiagonal,
                      ),
                    );
                  }
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class EmptySearch extends StatelessWidget {
  const EmptySearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: SizedBox(
          width: 0.6.sw,
          child: Text(
            "Try type on search box, and the result will shown here",
            textAlign: TextAlign.center,
            style: TextStyle(color: secondaryText),
          )),
    ));
  }
}
