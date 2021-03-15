import 'package:flutter/services.dart';

/// Форматтер для телефонного номера
class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(_, TextEditingValue newValue) {
    int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    final StringBuffer newText = new StringBuffer();

    if (newTextLength >= 12) {
      newText.write('+');
      newTextLength--;
    } else if (newTextLength == 1 && newValue.text[0] != '7') {
      newText.write('+7');
      if (newValue.selection.end >= 1) selectionIndex += 2;
    } else if (newTextLength >= 2) {
      newText.write('+');
      if (newValue.selection.end >= 2) selectionIndex++;
    } else if (newTextLength == 1 && newValue.text[0] == '7') {
      newText.write('+');
      if (newValue.selection.end >= 1) selectionIndex++;
    }

    if (newTextLength > 0) newText.write(newValue.text.substring(0, newTextLength));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
