/// Адрес
class Address {
  final String street;
  final String house;
  final String? housing;
  final String? apartment;

  Address({required this.street, required this.house, this.housing, this.apartment});
}
