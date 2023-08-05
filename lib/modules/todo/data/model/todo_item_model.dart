import 'package:notes/modules/todo/domain/entities/todo_item.dart';

class TodoItemModel extends ToDo{

  TodoItemModel({required super.color,required super.name,required super.description,required super.date, required super.id,});

  Map<String, dynamic> toMap() {
    return {
      'color': color,
      'status': name,
      'description': description,
      'date': date,
      'id':id
    };
  }

  static TodoItemModel fromMap(Map<String, dynamic> map) {
    return TodoItemModel(
        color: map['color'],
      name: map['status'],
      description: map['description'],
      date: map['date'],
      id: map['id']
    );
  }
}
