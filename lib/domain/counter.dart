import 'package:housing/domain/address.dart';
import 'package:housing/domain/type_of_counter.dart';
import 'package:housing/domain/client.dart';

/// Конкретный счетчика
class Counter {
  final String _name;
  final TypeOfCounter _type;
  final Client _client;
  final Address _address;

  Counter(this._name, this._type, this._client, this._address);

  get name => _name;

  get type => _type;

  get client => _client;

  get address => _address;
}
