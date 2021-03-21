import 'package:housing/domain/counter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'indication.g.dart';

/// Поданные показания
@JsonSerializable(fieldRename: FieldRename.snake)
class Indication {
  final int? id;
  @JsonKey(name: 'meter')
  final Counter counter;
  final int value;
  final int? previousValue;
  final DateTime date;

  Indication({
    this.id,
    required this.counter,
    required this.value,
    this.previousValue,
    required this.date,
  });

  factory Indication.fromJson(Map<String, dynamic> json) => _$IndicationFromJson(json);

  Map<String, dynamic> toJson() => _$IndicationToJson(this);
}
