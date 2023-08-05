import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:notes/core/error/failure.dart';
import 'package:notes/core/utilis/enums.dart';
import 'package:notes/modules/todo/domain/entities/todo_item.dart';
import 'package:notes/modules/todo/domain/usecase/create_note_usecase.dart';
import 'package:notes/modules/todo/domain/usecase/delete_note_usecase.dart';
import 'package:notes/modules/todo/domain/usecase/get_note_usecase.dart';
import 'package:notes/modules/todo/domain/usecase/update_note_usecase.dart';
import 'package:notes/modules/todo/presintaion/controller/todo_event.dart';
import 'package:notes/modules/todo/presintaion/controller/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, ToDoState> {
  final CreateNoteUseCase createNoteUseCase;
  final GetNoteUseCase getNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  TodoBloc(this.createNoteUseCase, this.getNoteUseCase, this.deleteNoteUseCase,
      this.updateNoteUseCase)
      : super(ToDoState()) {
    on<TodoEvent>((event, emit) async {
      if (event is CreateNoteEvent) {
        try {
          emit(state.copyWith(
            createNoteState: RequestState.loading,
          ));
          Either<Failure, Unit> result = await createNoteUseCase(
              name: event.name,
              date: event.date,
              description: event.description,
              id: event.id,
              color: event.color);
          result.fold(
            (Failure l) => emit(state.copyWith(
                createNoteState: RequestState.error,
                message: l.authErrorMessageModel.en)),
            (Unit r) {
              emit(state.copyWith(createNoteState: RequestState.loaded));
            },
          );
        } on Exception catch (e) {
          emit(state.copyWith(
              createNoteState: RequestState.error, message: "error"));
        }
      } else if (event is UpdateNoteEvent) {
        try {
          emit(state.copyWith(
            updateNoteState: RequestState.loading,
          ));
          Either<Failure, Unit> result = await updateNoteUseCase(
              name: event.name,
              date: event.date,
              description: event.description,
              id: event.id,
              color: event.color);
          result.fold(
            (Failure l) => emit(state.copyWith(
                updateNoteState: RequestState.error,
                message: l.authErrorMessageModel.en)),
            (Unit r) {
              emit(state.copyWith(updateNoteState: RequestState.loaded));
            },
          );
        } on Exception catch (e) {
          emit(state.copyWith(
              updateNoteState: RequestState.error, message: "error"));
        }
      } else if (event is GetToDoListEvent) {
        try {
          emit(state.copyWith(
            getNoteState: RequestState.loading,
          ));
          Either<Failure, List<ToDo>> result = await getNoteUseCase();
          result.fold(
            (Failure l) => emit(state.copyWith(
                getNoteState: RequestState.error,
                message: l.authErrorMessageModel.en)),
            (List<ToDo> r) {
              emit(state.copyWith(
                  toDoListResponse: r, getNoteState: RequestState.loaded));
            },
          );
        } on Exception catch (e) {
          emit(state.copyWith(
              getNoteState: RequestState.error, message: "error"));
        }
      } else if (event is DeleteNoteEvent) {
        try {
          emit(state.copyWith(
            deleteNoteState: RequestState.loading,
          ));
          Either<Failure, Unit> result = await deleteNoteUseCase(
            id: event.id,
          );
          result.fold(
            (Failure l) => emit(state.copyWith(
                deleteNoteState: RequestState.error,
                message: l.authErrorMessageModel.en)),
            (Unit r) {
              emit(state.copyWith(deleteNoteState: RequestState.loaded));
            },
          );
        } on Exception catch (e) {
          emit(state.copyWith(
              deleteNoteState: RequestState.error, message: "error"));
        }
      }
    });
  }
}
