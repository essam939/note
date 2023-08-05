import 'package:dartz/dartz.dart';
import 'package:notes/core/error/failure.dart';
import 'package:notes/modules/auth/domain/repository/base_auth_repository.dart';
import 'package:notes/modules/todo/domain/repository/base_todo_repository.dart';

class DeleteNoteUseCase {
  BaseToDoRepository baseToDoRepository;
  DeleteNoteUseCase(this.baseToDoRepository);
  Future<Either<Failure, Unit>> call({
    required int id,
  }) async {
    return await baseToDoRepository.deleteToDo(id: id);
  }
}
