import 'dart:convert';

import 'package:path/path.dart';
import 'package:praktitask/home/data/models/todo_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    await db.execute('''
CREATE TABLE todos (
  id $idType,
  taskName $textType,
  description $textType,
  categoryCode $textType,
  date $textType,
  time $textType,
  isCompleted $intType DEFAULT 0
)
''');
  }

  // Contoh fungsi CRUD untuk TodoModel
  Future<TodoModel> createTodo(TodoModel todo) async {
    final db = await instance.database;
    await db.insert('todos', todo.toMap());
    return todo;
  }

  Future<List<TodoModel>> getAllTodosOrderedByDateAndTime(String? date) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps;
    if (date != null) {
      // Query untuk mengambil todos dengan tanggal tertentu dan diurutkan berdasarkan waktu
      maps = await db.query(
        'todos',
        where: 'date = ?', // Menambahkan kondisi where untuk filter tanggal
        whereArgs: [date], // Menyediakan nilai untuk kondisi where
        orderBy:
            'date ASC, time ASC', // Hanya perlu mengurutkan berdasarkan waktu karena tanggalnya sudah spesifik
      );
    } else {
      // Query untuk mengambil semua todos dengan urutan date dan time
      maps = await db.query(
        'todos',
        orderBy: 'date ASC, time ASC', // Mengurutkan berdasarkan tanggal dan waktu secara Ascending
      );
    }
    // Konversi list map ke list Todo
    return List.generate(maps.length, (i) {
      return TodoModel.fromMap(maps[i]);
    });
  }

  Future<TodoModel?> readTodo(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'todos',
      columns: ['id', 'taskName', 'description', 'categoryCode', 'date', 'time', 'isCompleted'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TodoModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<TodoModel>> searchTodos(String query) async {
    final db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      'todos',
      where: 'taskName LIKE ? OR description LIKE ?',
      whereArgs: [
        '%$query%',
        '%$query%'
      ], // Menggunakan wildcard untuk pencarian yang mengandung kata
    );
    if (query.isEmpty) {
      maps = await db.query(
        'todos',
        orderBy: 'date ASC, time ASC', // Mengurutkan berdasarkan tanggal dan waktu secara Ascending
      );
    }

    return List.generate(maps.length, (i) => TodoModel.fromMap(maps[i]));
  }

  Future<int> updateTodo(TodoModel todo) async {
    final db = await instance.database;
    return db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> deleteTodo(int id) async {
    final db = await instance.database;
    return await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
