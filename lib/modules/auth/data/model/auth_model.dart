import 'package:equatable/equatable.dart';
import 'package:notes/modules/auth/domain/entities/auth.dart';

class AuthModel extends Auth {
  const AuthModel({required super.user, required super.token});
  
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}
class User extends Equatable {
  int id;
  String name;
  String email;

  User({ required this.id,required this.name,required this.email});

  factory  User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name:  json['name'], email: json['email']);

  }
  @override
  List<Object> get props =>[id, name, email,];
}