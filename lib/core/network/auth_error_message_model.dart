import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final String en;
  final String ar;

  const ErrorMessageModel(
      {required this.en,
        required this.ar,
      });

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
        en: json["en"],
        ar: json["ar"],);
  }

  @override
  List<Object?> get props => [en, ar,];
}
