import 'package:equatable/equatable.dart';

class ToDo extends Equatable {
  final String name;
  final String description;
  final String date;
  final String color;
  final int id;

 const ToDo(
      {required this.name,
      required this.description,
      required this.date,
        required this.id,
      required this.color});
  @override
  List<Object> get props => [name, description, date, color,id];
}
