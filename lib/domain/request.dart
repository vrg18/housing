import 'package:housing/domain/request_status.dart';
import 'package:json_annotation/json_annotation.dart';

import 'address.dart';

part 'request.g.dart';

/// Заявки
@JsonSerializable(fieldRename: FieldRename.snake)
class Request {
  int? id;
  final String text;
  final String subject;
  final String surname;
  final String name;
  final String? patronymic;
  final String phone;
  final String? email;
  final DateTime? createdAt;
  final DateTime? completedAt;
  @JsonKey(name: 'task_status')
  int? status;
  final int? user;
  final String? attachment;
  final Address address;
  @JsonKey(ignore: true)
  RequestStatus? requestStatus;

  Request({
    this.id,
    required this.text,
    required this.subject,
    required this.surname,
    required this.name,
    this.patronymic,
    required this.phone,
    this.email,
    this.createdAt,
    this.completedAt,
    this.status,
    this.user,
    this.attachment,
    required this.address,
    this.requestStatus,
  });

  // Выводим ФИО
  String toPersonName() {
    return '$surname $name${patronymic != null ? ' ' + patronymic! : ''}';
  }

  factory Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);
}
