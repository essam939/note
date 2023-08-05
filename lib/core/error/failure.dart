// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:notes/core/network/auth_error_message_model.dart';

abstract class Failure extends Equatable {
  final ErrorMessageModel authErrorMessageModel;
 const Failure(this.authErrorMessageModel);
 

  @override
  List<Object> get props => [authErrorMessageModel];
}
