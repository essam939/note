import 'dart:async';
import 'dart:io';
import 'package:notes/modules/todo/data/model/todo_item_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class TodoDBHelper {
  static final TodoDBHelper _instance = TodoDBHelper._internal();

  factory TodoDBHelper() => _instance;

  TodoDBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "todo.db");
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  void _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        color TEXT,
        status TEXT,
        description TEXT,
        date TEXT
      )
    ''');
  }

  Future<int> insertTodoItem(TodoItemModel todoItem) async {
    final db = await database;
    return await db.insert('todos', todoItem.toMap());
  }

  Future<List<TodoItemModel>> getTodoItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (i) {
      return TodoItemModel.fromMap(maps[i]);
    });
  }

  Future<int> updateTodoItem(TodoItemModel todoItem) async {
    final db = await database;
    return await db.update('todos', todoItem.toMap(),
        where: 'id = ?', whereArgs: [todoItem.id]);
  }

  Future<int> deleteTodoItem(int id) async {
    final db = await database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
