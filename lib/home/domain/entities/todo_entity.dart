import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:praktitask/home/data/models/todo_model.dart';

class TodoEntity extends Equatable {
  int? id;
  String taskName;
  String description;
  String categoryCode; // Menggunakan kode kategori sebagai referensi
  String date;
  String time;
  bool isCompleted;

  TodoEntity completed() => TodoEntity(
      id: id,
      taskName: taskName,
      description: description,
      categoryCode: categoryCode,
      date: date,
      isCompleted: true,
      time: time);
  TodoEntity onGoing() => TodoEntity(
      id: id,
      taskName: taskName,
      description: description,
      categoryCode: categoryCode,
      date: date,
      isCompleted: false,
      time: time);

  TodoModel toModel() => TodoModel(
      id: id,
      taskName: taskName,
      description: description,
      categoryCode: categoryCode,
      date: date,
      isCompleted: isCompleted,
      time: time);

  TodoEntity(
      {this.id,
      required this.taskName,
      required this.description,
      required this.categoryCode,
      required this.date,
      required this.isCompleted,
      required this.time});

  // Convert TodoEntity object to Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskName': taskName,
      'description': description,
      'categoryCode': categoryCode,
      'date': date,
      'time': time,
      'isCompleted': isCompleted ? 1 : 0
    };
  }

  // Extract a TodoEntity object from a Map object
  factory TodoEntity.fromMap(Map<String, dynamic> map) {
    return TodoEntity(
        id: map['id'],
        taskName: map['taskName'],
        description: map['description'],
        categoryCode: map['categoryCode'],
        date: map['date'],
        time: map['time'],
        isCompleted: map['isCompleted'] == 1);
  }

  @override
  List<Object?> get props => [id, taskName, description, categoryCode, date, time, isCompleted];
}
