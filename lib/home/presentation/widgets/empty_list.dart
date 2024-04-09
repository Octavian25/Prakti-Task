import 'package:flutter/material.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/presentation/pages/home_screen.dart';
import 'package:praktitask/home/presentation/widgets/add_todo.dart';
import 'package:praktitask/utility/styles.dart';

class EmptyList extends StatefulWidget {
  const EmptyList({
    super.key,
  });

  @override
  State<EmptyList> createState() => _EmptyListState();
}

class _EmptyListState extends State<EmptyList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Center(
              child: Text(
            "You don't have any tasks added",
            style: bold,
          )),
          const Center(child: Text("Click on the + icon to add task")),
          20.verticalSpacingDiagonal,
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  content: AddNewTask(),
                ),
              );
            },
            borderRadius: BorderRadius.circular(15),
            child: Ink(
              width: 1.sw,
              height: 0.2.sh,
              decoration: BoxDecoration(
                  color: primary.withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline_rounded,
                    color: primary,
                    size: 50.sp,
                  ),
                  10.verticalSpacingDiagonal,
                  Text(
                    "Add your daily tasks",
                    style: bold.copyWith(color: primary),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
