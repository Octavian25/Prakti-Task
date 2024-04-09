import 'package:flutter/material.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';
import 'package:praktitask/home/presentation/bloc/delete_todo_bloc/delete_todo_bloc.dart';
import 'package:praktitask/home/presentation/pages/home_screen.dart';
import 'package:praktitask/home/presentation/widgets/complete_todo_check.dart';
import 'package:praktitask/home/presentation/widgets/ongoing_todo_check.dart';
import 'package:praktitask/utility/styles.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoCard extends StatelessWidget {
  final TodoEntity todoEntity;
  const TodoCard({super.key, required this.todoEntity});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(todoEntity.id),
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            context.read<DeleteTodoBloc>().add(DoDeleteTodo(todoEntity.id!));
          },
          backgroundColor: Colors.red.shade300,
          borderRadius: BorderRadius.circular(15),
          icon: Icons.delete,
          label: "Delete",
        )
      ]),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: "#E7E7E7".toColor().withOpacity(0.6),
                  blurRadius: 5,
                  spreadRadius: 3,
                  offset: const Offset(0, 4))
            ],
            color: Colors.white,
            border: Border.all(color: "#E7E7E7".toColor().withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10)),
        width: 1.sw,
        padding: EdgeInsets.all(10.dg),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            todoEntity.isCompleted
                ? CompletedTodoChecklist(todoEntity: todoEntity)
                : OngoingTodoChecklist(todoEntity: todoEntity),
            10.horizontalSpaceDiagonal,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    todoEntity.taskName,
                    textAlign: TextAlign.start,
                    style: bold.copyWith(
                        decoration: todoEntity.isCompleted ? TextDecoration.lineThrough : null),
                  ),
                  Text(
                    todoEntity.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: normal.copyWith(
                        color: secondaryText,
                        fontSize: 12.sp,
                        decoration: todoEntity.isCompleted ? TextDecoration.lineThrough : null),
                  ),
                  20.verticalSpacingDiagonal,
                  Wrap(
                    children: [
                      Text(
                        "${todoEntity.date}, ",
                        style: normal.copyWith(
                            color: secondaryText,
                            fontSize: 10.sp,
                            decoration: todoEntity.isCompleted ? TextDecoration.lineThrough : null),
                      ),
                      Text(
                        todoEntity.time,
                        style: normal.copyWith(
                            color: secondaryText,
                            fontSize: 10.sp,
                            decoration: todoEntity.isCompleted ? TextDecoration.lineThrough : null),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: primary.withOpacity(0.2), borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.all(3.dg),
              child: Text(
                todoEntity.categoryCode,
                style: normal.copyWith(color: primary, fontSize: 10.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
