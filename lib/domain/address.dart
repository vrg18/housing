import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

/// Адрес
@JsonSerializable(fieldRename: FieldRename.snake)
class Address {
  int? id;
  final String street;
  final String house;
  final String? building;
  final String? apartment;
  final bool isMain;

  Address({
    this.id,
    required this.street,
    required this.house,
    this.building,
    this.apartment,
    required this.isMain,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  String toString() {
    return '$street, $house${building != null && building!.isNotEmpty ? (', $building') : ''}'
        '${apartment != null && apartment!.isNotEmpty ? (', $apartment') : ''}';
  }
}
