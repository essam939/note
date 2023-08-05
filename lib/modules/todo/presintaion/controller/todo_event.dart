import 'package:equatable/equatable.dart';

abstract class TodoEvent  extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}
class CreateNoteEvent extends TodoEvent {
  String name;
  String description;
  String date;
  int id;
  String color;

  CreateNoteEvent(
      {required this.name,
        required this.description,
        required this.date,
        required this.id,
        required this.color});
}
class UpdateNoteEvent extends TodoEvent {
  String name;
  String description;
  String date;
  int id;
  String color;

  UpdateNoteEvent(
      {required this.name,
        required this.description,
        required this.date,
        required this.id,
        required this.color});
}
class DeleteNoteEvent extends TodoEvent {
  int id;

  DeleteNoteEvent({required this.id});
}
class GetToDoListEvent extends TodoEvent {
  GetToDoListEvent();
}