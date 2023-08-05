// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:notes/modules/auth/data/model/auth_model.dart';

class Auth extends Equatable {
 final User user;
 final String token;

  const Auth({required this.user,required this.token});


  @override
  List<Object> get props => [user, token];
}



