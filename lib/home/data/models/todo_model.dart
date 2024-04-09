import 'package:equatable/equatable.dart';
import 'package:praktitask/home/domain/entities/todo_entity.dart';

class TodoModel extends Equatable {
  int? id;
  String taskName;
  String description;
  String categoryCode; // Menggunakan kode kategori sebagai referensi
  String date;
  String time;
  bool isCompleted;

  TodoEntity toEntity() => TodoEntity(
      id: id,
      taskName: taskName,
      description: description,
      categoryCode: categoryCode,
      date: date,
      isCompleted: isCompleted,
      time: time);

  TodoModel(
      {this.id,
      required this.taskName,
      required this.description,
      required this.categoryCode,
      required this.date,
      required this.isCompleted,
      required this.time});

  // Convert TodoModel object to Map object
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

  // Extract a TodoModel object from a Map object
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
        id: map['id'],
        taskName: map['taskName'],
        description: map['description'],
        categoryCode: map['categoryCode'],
        date: map['date'],
        time: map['time'],
        isCompleted: map['isCompleted'] == 1);
  }

  @override
  List<Object?> get props => [id, taskName, description, categoryCode, date, time];
}
