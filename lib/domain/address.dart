import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';

/// Адрес
@JsonSerializable(fieldRename: FieldRename.snake)
class Address {
  final int? id;
  final String street;
  final String house;
  final String? building;
  final String? apartment;

  Address({
    this.id,
    required this.street,
    required this.house,
    this.building,
    this.apartment,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
