import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'counter_type.g.dart';

/// Тип счетчика
@JsonSerializable(fieldRename: FieldRename.snake)
class CounterType {
  final int? id;
  final String title;
  @JsonKey(ignore: true)
  IconData? icon;
  @JsonKey(ignore: true)
  Color? color;
  @JsonKey(ignore: true)
  String? unit;

  CounterType({
    this.id,
    required this.title,
    this.icon,
    this.color,
    this.unit,
  });

  factory CounterType.fromJson(Map<String, dynamic> json) => _$CounterTypeFromJson(json);

  Map<String, dynamic> toJson() => _$CounterTypeToJson(this);
}
