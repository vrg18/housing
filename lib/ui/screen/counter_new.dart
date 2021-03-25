import 'package:flutter/material.dart';
import 'package:housing/data/service/counter_service.dart';
import 'package:housing/domain/counter.dart';
import 'package:housing/domain/counter_type.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:housing/ui/widget/top_bar.dart';
import 'package:provider/provider.dart';

/// Страница создания нового счетчиков
class CounterNew extends StatefulWidget {
  @override
  _CounterNewState createState() => _CounterNewState();
}

class _CounterNewState extends State<CounterNew> {
  late final TextEditingController _titleController;
  late final FocusNode _titleFocus;
  late final FocusNode _typeFocus;
  late final FocusNode _addressFocus;
  late Map<String, dynamic> _selectedValues;
  late bool _isCounterReady;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _titleFocus = FocusNode();
    _titleFocus.addListener(() => setState(() {}));
    _typeFocus = FocusNode();
    _typeFocus.addListener(() => setState(() {}));
    _addressFocus = FocusNode();
    _addressFocus.addListener(() => setState(() {}));
    _selectedValues = {
      'Type': null,
      'Address': null,
    };
    _isCounterReady = false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _titleFocus.dispose();
    _typeFocus.dispose();
    _addressFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        mainIcon: Icons.chevron_left,
        mainCallback: _returnToPreviousScreen,
        iconMessage: backTooltipMessage,
      ),
      body: Padding(
        padding: const EdgeInsets.all(basicBorderSize),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                newCounterLabel,
                style: inputInAccountStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: heightOfButtonsAndTextFields,
                child: TextField(
                  controller: _titleController,
                  focusNode: _titleFocus,
                  autofocus: true,
                  decoration: _decorationOfTextField(counterNameLabel, _titleFocus, null),
                  onChanged: (text) => _setIsCounterReady(),
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_typeFocus),
                ),
              ),
              const SizedBox(height: 16),
              _customDropdownButton('Type', _typeFocus, counterTypeLabel, context.read<CounterService>().counterTypes),
              const SizedBox(height: 16),
              _customDropdownButton('Address', _addressFocus, addressLabel, context.read<CounterService>().addresses),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    child: Text(
                      addAddressLabel,
                      textAlign: TextAlign.center,
                    ),
                    style: blueButtonStyle,
                    onPressed: () {},
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: Text(
                  saveCounterLabel,
                  style: _isCounterReady ? activeButtonLabelStyle : inactiveButtonLabelStyle,
                ),
                onPressed: _isCounterReady ? () => _gotoSaveCounter() : null,
                style: TextButton.styleFrom(
                  backgroundColor: _isCounterReady ? null : inactiveBackgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customDropdownButton(String selected, FocusNode focus, String label, List<dynamic> items) {
    return SizedBox(
      height: 60,
      child: DropdownButtonFormField(
        value: _selectedValues[selected],
        focusNode: focus,
        style: dropdownButtonStyle,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: focus.hasFocus ? basicBlue : Colors.grey[600]),
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          focus.nextFocus();
          _selectedValues[selected] = value!;
          _setIsCounterReady();
        },
        items: items.asMap().values.map((e) => DropdownMenuItem(value: e, child: _dropdownMenuItem(e))).toList(),
      ),
    );
  }

  Widget _dropdownMenuItem(dynamic value) {
    return value is CounterType
        ? Row(
            children: [
              Icon(
                value.icon,
                color: value.color,
              ),
              const SizedBox(width: 4),
              Text(value.title),
            ],
          )
        : Text(value.toString());
  }

  InputDecoration _decorationOfTextField(String label, FocusNode? _focus, Icon? icon) {
    return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: _focus != null && _focus.hasFocus ? basicBlue : Colors.grey[600]),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.only(left: 10),
        suffixIcon: icon);
  }

  void _setIsCounterReady() {
    setState(() => _isCounterReady =
        _titleController.text.isNotEmpty && _selectedValues['Type'] != null && _selectedValues['Address'] != null);
  }

  // Возврат на предыдущий экран с сохранением
  void _gotoSaveCounter() {
    Navigator.pop(
        context,
        Counter(
          title: _titleController.text,
          type: _selectedValues['Type'].id,
          counterType: _selectedValues['Type'],
          address: _selectedValues['Address'],
        ));
  }

  // Возврат на предыдущий экран без сохранения
  void _returnToPreviousScreen() {
    Navigator.pop(context, null);
  }
}
