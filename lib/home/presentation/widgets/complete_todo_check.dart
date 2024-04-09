import 'package:flutter/material.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';
import 'package:praktitask/home/presentation/bloc/update_todo_bloc/update_todo_bloc.dart';
import 'package:praktitask/utility/styles.dart';

class CompletedTodoChecklist extends StatelessWidget {
  final TodoEntity todoEntity;
  const CompletedTodoChecklist({super.key, required this.todoEntity});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.read<UpdateTodoBloc>().add(DoUpdateTodo(todoEntity.onGoing()));
        },
        child: Ink(
          height: 15.dg,
          width: 15.dg,
          decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
          child: Icon(
            Icons.check,
            size: 10.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
