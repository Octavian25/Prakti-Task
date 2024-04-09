import 'package:flutter/material.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';
import 'package:praktitask/home/presentation/bloc/update_todo_bloc/update_todo_bloc.dart';

class OngoingTodoChecklist extends StatelessWidget {
  final TodoEntity todoEntity;
  const OngoingTodoChecklist({super.key, required this.todoEntity});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.read<UpdateTodoBloc>().add(DoUpdateTodo(todoEntity.completed()));
        },
        child: Ink(
          height: 15.dg,
          width: 15.dg,
          decoration:
              BoxDecoration(shape: BoxShape.circle, border: Border.all(color: "#E7E7E7".toColor())),
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
