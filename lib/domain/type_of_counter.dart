import 'package:flutter/material.dart';

/// Тип счетчика
class TypeOfCounter {
  final String _name;
  final IconData _icon;
  final Color _color;
  final String _unit;

  TypeOfCounter(this._name, this._icon, this._color, this._unit);

  get name => _name;

  get icon => _icon;

  get color => _color;

  get unit => _unit;
}
