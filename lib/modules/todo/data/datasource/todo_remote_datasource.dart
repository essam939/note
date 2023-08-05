import 'package:dartz/dartz.dart';
import 'package:notes/core/services/dio_services.dart';
import 'package:notes/core/utilis/todo_db_helper.dart';
import 'package:notes/modules/todo/data/model/todo_item_model.dart';

abstract class BaseToDoRemoteDataSource {
  Future<Unit> createToDo(
      {required String name,
        required String description,
        required String date,
        required String color,
        required int id});
  Future<Unit> updateToDo(
      {required String name,
        required String description,
        required String date,
        required String color,
        required int id});
  Future<Unit> deleteToDo({required int id});

  Future<List<TodoItemModel>> getTodoList();
}

class ToDoRemoteDataSource extends BaseToDoRemoteDataSource {
  static final DioService _dioService = DioService();


  @override
  Future<Unit> createToDo(
      {required String name,
        required String description,
        required String date,
        required String color,
        required int id}) async {
    TodoDBHelper dbHelper = TodoDBHelper();
    TodoItemModel newItem = TodoItemModel(
      color: color,
      name: name,
      description: description,
      date: date,
      id: id,
    );
    await dbHelper.insertTodoItem(newItem);
    return Future.value(unit);
  }

  @override
  Future<Unit> updateToDo(
      {required String name,
        required String description,
        required String date,
        required String color,
        required int id}) async {
    TodoDBHelper dbHelper = TodoDBHelper();
    TodoItemModel newItem = TodoItemModel(
      color: color,
      name: name,
      description: description,
      date: date,
      id: id,
    );
    await dbHelper.updateTodoItem(newItem);
    return Future.value(unit);
  }

  @override
  Future<List<TodoItemModel>> getTodoList() async {
    TodoDBHelper dbHelper = TodoDBHelper();
    List<TodoItemModel> listOfTodoItem = await dbHelper.getTodoItems();
    return listOfTodoItem;
  }

  @override
  Future<Unit> deleteToDo({required int id}) async {
    TodoDBHelper dbHelper = TodoDBHelper();
    await dbHelper.deleteTodoItem(id);
    return Future.value(unit);
  }
}
