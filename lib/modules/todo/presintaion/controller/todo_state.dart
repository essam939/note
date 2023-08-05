// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:notes/core/utilis/enums.dart';
import 'package:notes/modules/auth/domain/entities/auth.dart';
import 'package:notes/modules/todo/domain/entities/todo_item.dart';

class ToDoState extends Equatable {
  final RequestState createNoteState;
  final RequestState updateNoteState;
  final RequestState deleteNoteState;
  final RequestState getNoteState;
  final List<ToDo>? toDoListResponse;
  final String message;

  ToDoState({
    this.createNoteState = RequestState.initState,
    this.updateNoteState = RequestState.initState,
    this.deleteNoteState = RequestState.initState,
    this.getNoteState = RequestState.initState,
    this.toDoListResponse,
    this.message = '',
  });

  ToDoState copyWith({
    RequestState? loginState,
    RequestState? createNoteState,
    RequestState? updateNoteState,
    RequestState? deleteNoteState,
    RequestState? getNoteState,
    List<ToDo>? toDoListResponse,
    Auth? userResponse,
    String? message,
  }) {
    return ToDoState(
      getNoteState: getNoteState ?? this.getNoteState,
      toDoListResponse: toDoListResponse ?? this.toDoListResponse,
      createNoteState: createNoteState ?? this.createNoteState,
      updateNoteState: updateNoteState ?? this.updateNoteState,
      deleteNoteState: deleteNoteState ?? this.deleteNoteState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    message,
    createNoteState,
    getNoteState,
    toDoListResponse,
    deleteNoteState,
    updateNoteState,
  ];
}
