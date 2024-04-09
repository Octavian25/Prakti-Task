import 'package:flutter/material.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';
import 'package:praktitask/home/presentation/bloc/fetch_all_todos_bloc/fetch_all_todos_bloc.dart';
import 'package:praktitask/home/presentation/bloc/save_todo_bloc/save_todo_bloc.dart';
import 'package:praktitask/utility/custom_form_field.dart';
import 'package:praktitask/utility/custom_toast.dart';
import 'package:praktitask/utility/styles.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  // Fungsi untuk memformat TimeOfDay ke string format 24 jam (HH:mm)
  String _formatTime24H(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  GlobalKey<FormState> formState = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formState,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Create New Task",
              style: bold.copyWith(fontSize: 15.sp),
            ),
            20.verticalSpacingDiagonal,
            CustomFormField(controller: taskNameController, title: "Task name", hint: ""),
            10.verticalSpacingDiagonal,
            Text(
              "Description",
              style: normal.copyWith(fontSize: 12.sp),
            ),
            5.verticalSpacingDiagonal,
            TextFormField(
              style: normal.copyWith(fontSize: 13.sp),
              minLines: 3,
              maxLines: 3,
              controller: descriptionController,
              decoration: InputDecoration(
                  isDense: true,
                  hintText: "Add description..",
                  contentPadding: EdgeInsets.only(left: 16.dg, top: 7.dg, bottom: 7.dg),
                  border: OutlineInputBorder(borderSide: BorderSide(color: "#E7E7E7".toColor())),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: "#E7E7E7".toColor())),
                  focusedBorder:
                      const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54))),
            ),
            10.verticalSpacingDiagonal,
            CustomFormField(
                controller: categoryController, title: "Category", hint: "Design Category"),
            10.verticalSpacingDiagonal,
            CustomFormField(
              enabled: false,
              controller: dateController,
              title: "Date",
              hint: "dd/mm/yyyy",
              handleOnTap: () async {
                final DateTime? picked = await showDatePicker(
                    currentDate: DateTime.now(),
                    initialDate: DateTime.now(),
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(3000));
                if (picked != null) {
                  dateController.text =
                      picked.toLocal().toString().substring(0, 10).split("-").reversed.join("/");
                }
              },
            ),
            10.verticalSpacingDiagonal,
            CustomFormField(
              enabled: false,
              controller: timeController,
              title: "Time",
              hint: "hh:mm",
              handleOnTap: () async {
                TimeOfDay currentTime = TimeOfDay.now();
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: currentTime,
                );
                if (picked != null) {
                  if (picked.hour < currentTime.hour ||
                      (picked.hour == currentTime.hour && picked.minute < currentTime.minute)) {
                    if (!mounted) return;
                    CustomToast().success(context, "Please select a future time.");
                  } else {
                    timeController.text = _formatTime24H(picked);
                  }
                }
              },
            ),
            20.verticalSpacingDiagonal,
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: primary),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: primary))),
                      onPressed: () {
                        context.pop();
                      },
                      child: Text(
                        "Cancel",
                        style: normal.copyWith(fontSize: 11.sp),
                      )),
                ),
                5.horizontalSpaceDiagonal,
                BlocConsumer<SaveTodoBloc, SaveTodoState>(
                  listener: (context, state) {
                    if (state is SaveTodoSuccess) {
                      context.read<FetchAllTodosBloc>().add(DoFetchAllTodos());
                      context.pop();
                    } else if (state is SaveTodoFailure) {
                      print(state.message);
                    }
                  },
                  builder: (context, state) {
                    return Expanded(
                      child: FilledButton(
                          style: FilledButton.styleFrom(
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          onPressed: state is SaveTodoLoadings
                              ? null
                              : () {
                                  if (formState.currentState!.validate()) {
                                    TodoEntity todoEntity = TodoEntity(
                                        taskName: taskNameController.text,
                                        description: descriptionController.text,
                                        categoryCode: categoryController.text,
                                        date: dateController.text,
                                        isCompleted: false,
                                        time: timeController.text);
                                    context.read<SaveTodoBloc>().add(DoSaveTodo(todoEntity));
                                  }
                                },
                          child: Text(
                            "Create Task",
                            style: normal.copyWith(fontSize: 11.sp),
                          )),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
