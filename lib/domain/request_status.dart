import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_status.g.dart';

/// Тип счетчика
@JsonSerializable(fieldRename: FieldRename.snake)
class RequestStatus {
  final int? id;
  final String title;
  @JsonKey(ignore: true)
  Color? color;

  RequestStatus({
    this.id,
    required this.title,
    this.color,
  });

  factory RequestStatus.fromJson(Map<String, dynamic> json) => _$RequestStatusFromJson(json);
}
