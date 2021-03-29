import 'package:flutter/material.dart';
import 'package:housing/ui/res/colors.dart';

InputDecoration decorationOfTextField(String label, FocusNode? _focus, Icon? icon) {
  return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: _focus != null && _focus.hasFocus ? basicBlue : Colors.grey[600]),
      border: OutlineInputBorder(),
      contentPadding: const EdgeInsets.all(10),// : const EdgeInsets.only(left: 10),
      suffixIcon: icon);
}
