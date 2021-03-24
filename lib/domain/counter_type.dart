import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'counter_type.g.dart';

/// Тип счетчика
@JsonSerializable(fieldRename: FieldRename.snake)
class CounterType {
  final int? id;
  final String title;
  final String measure;
  @JsonKey(ignore: true)
  IconData? icon;
  @JsonKey(ignore: true)
  Color? color;

  CounterType({
    this.id,
    required this.title,
    required this.measure,
    this.icon,
    this.color,
  });

  factory CounterType.fromJson(Map<String, dynamic> json) => _$CounterTypeFromJson(json);
}
