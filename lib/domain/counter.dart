import 'package:json_annotation/json_annotation.dart';
import 'package:housing/domain/address.dart';

import 'counter_type.dart';
part 'counter.g.dart';

/// Конкретный счетчик
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Counter {
  final int? id;
  final String title;
  @JsonKey(name: 'meters_type')
  final int type;
  final previousValue;
  final Address address;
  @JsonKey(ignore: true)
  CounterType? counterType;

  Counter({
    this.id,
    required this.title,
    required this.type,
    required this.previousValue,
    required this.address,
    this.counterType,
  });

  factory Counter.fromJson(Map<String, dynamic> json) => _$CounterFromJson(json);

  Map<String, dynamic> toJson() => _$CounterToJson(this);
}