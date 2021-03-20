import 'package:housing/domain/counter.dart';

/// Поданные показания
class Indication {
  final Counter _counter;
  final DateTime _date;
  final double _value;

  Indication(this._counter, this._date, this._value);

  get counter => _counter;

  get date => _date;

  get value => _value;
}