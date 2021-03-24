import 'package:housing/domain/counter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'indication.g.dart';

/// Поданные показания
@JsonSerializable(fieldRename: FieldRename.snake)
class Indication {
  final int? id;
  final int meter;
  final int value;
  final int? previousValue;
  final DateTime? date;
  @JsonKey(ignore: true)
  final Counter? counter;

  Indication({
    this.id,
    required this.meter,
    required this.value,
    this.previousValue,
    this.date,
    this.counter,
  });

  factory Indication.fromJson(Map<String, dynamic> json) => _$IndicationFromJson(json);

  Map<String, dynamic> toJson() => _$IndicationToJson(this);
}
