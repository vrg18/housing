import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:housing/data/service/counter_service.dart';
import 'package:housing/domain/counter.dart';
import 'package:housing/domain/counter_type.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:housing/ui/widget/top_bar.dart';
import 'package:provider/provider.dart';

/// Страница истории показаний счетчиков
class CounterDetails extends StatefulWidget {
  final Counter? counter;

  CounterDetails(this.counter);

  @override
  _CounterDetailsState createState() => _CounterDetailsState();
}

class _CounterDetailsState extends State<CounterDetails> {
  late final TextEditingController _titleController;
  late final TextEditingController _typeController;
  late final TextEditingController _addressController;
  late final TextEditingController _previousController;
  late final TextEditingController _currentController;
  late final FocusNode _titleFocus;
  late final FocusNode _typeFocus;
  late final FocusNode _addressFocus;
  late final FocusNode _currentFocus;
  late Map<String, dynamic> _selectedValues;
  late bool _isCounterReady;
  late bool _isCurrentReady;
  late bool _isNew;
  late bool _isEnableEdit;

  @override
  void initState() {
    super.initState();
    _isNew = widget.counter == null;
    _titleController = TextEditingController(text: _isNew ? '' : widget.counter!.title);
    _typeController = TextEditingController(text: _isNew ? '' : widget.counter!.counterType!.title);
    _addressController = TextEditingController(text: _isNew ? '' : widget.counter!.address.toString());
    _previousController = TextEditingController(
        text: _isNew
            ? ''
            : widget.counter!.previousValue != null
                ? '${widget.counter!.previousValue.toString()} ${widget.counter!.counterType!.measure}'
                : '');
    _currentController = TextEditingController();
    _titleFocus = FocusNode();
    _titleFocus.addListener(() => setState(() {}));
    _typeFocus = FocusNode();
    _typeFocus.addListener(() => setState(() {}));
    _addressFocus = FocusNode();
    _addressFocus.addListener(() => setState(() {}));
    _currentFocus = FocusNode();
    _currentFocus.addListener(() => setState(() {}));
    _selectedValues = {
      'Type': _isNew ? null : widget.counter!.counterType,
      'Address': _isNew ? null : widget.counter!.address,
    };
    _isCounterReady = false;
    _isCurrentReady = false;
    _isEnableEdit = false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _typeController.dispose();
    _addressController.dispose();
    _previousController.dispose();
    _currentController.dispose();
    _titleFocus.dispose();
    _typeFocus.dispose();
    _addressFocus.dispose();
    _currentFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        mainIcon: Icons.chevron_left,
        mainCallback: _returnToPreviousScreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(basicBorderSize),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _isNew ? newCounterLabel : counterLabel,
                style: inputInAccountStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: heightOfButtonsAndTextFields,
                child: Stack(
                  children: [
                    TextField(
                      enabled: _isNew || _isEnableEdit,
                      controller: _titleController,
                      focusNode: _titleFocus,
                      autofocus: true,
                      decoration: _decorationOfTextField(counterNameLabel, _titleFocus, null),
                      onChanged: (text) => _setIsCounterReady(),
                      onEditingComplete: () => FocusScope.of(context).requestFocus(_typeFocus),
                    ),
                    if (!_isNew)
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: _isEnableEdit ? Colors.black : Colors.grey,
                          ),
                          onPressed: () => setState(() => _isEnableEdit = !_isEnableEdit),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _isNew
                  ? _customDropdownButton(
                      'Type', _typeFocus, counterTypeLabel, context.read<CounterService>().counterTypes)
                  : TextField(
                      enabled: false,
                      controller: _typeController,
                      decoration: _decorationOfTextField(counterTypeLabel, null, null),
                    ),
              const SizedBox(height: 16),
              _isNew
                  ? _customDropdownButton(
                      'Address', _addressFocus, addressLabel, context.read<CounterService>().addresses)
                  : TextField(
                      enabled: false,
                      controller: _addressController,
                      decoration: _decorationOfTextField(addressLabel, null, null),
                    ),
              if (_isNew) const SizedBox(height: 8),
              if (_isNew)
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
              if (!_isNew) const SizedBox(height: 16),
              if (!_isNew)
                TextField(
                  enabled: false,
                  controller: _previousController,
                  decoration: _decorationOfTextField(previousValueLabel, null, null),
                ),
              if (!_isNew) const SizedBox(height: 16),
              if (!_isNew)
                TextField(
                  controller: _currentController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  focusNode: _currentFocus,
                  decoration: _decorationOfTextField(
                    currentValueLabel,
                    _currentFocus,
                    Icon(Icons.edit, color: Colors.black),
                  ),
                  onChanged: (text) => _setIsCurrentReady(),
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: Text(
                  saveCounterLabel,
                  style: _isActiveSaveButton() ? activeButtonLabelStyle : inactiveButtonLabelStyle,
                ),
                onPressed: _isActiveSaveButton() ? () => _gotoSaveCounter() : null,
                style: TextButton.styleFrom(
                  backgroundColor: _isActiveSaveButton() ? null : inactiveBackgroundColor,
                ),
              ),
              if (!_isNew) const SizedBox(height: 16),
              if (!_isNew)
                TextButton(
                  child: Text(
                    historyValueLabel,
                    style: activeButtonUnderlineLabelStyle,
                  ),
                  style: bigWhiteButtonStyle,
                  onPressed: () => {},
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
        onChanged: _isNew
            ? (value) {
                focus.nextFocus();
                _selectedValues[selected] = value!;
                _setIsCounterReady();
              }
            : null,
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

  bool _isActiveSaveButton() {
    return _isNew && _isCounterReady || !_isNew && _isCurrentReady;
  }

  void _setIsCounterReady() {
    setState(() => _isCounterReady =
        _titleController.text.isNotEmpty && _selectedValues['Type'] != null && _selectedValues['Address'] != null);
  }

  void _setIsCurrentReady() {
    setState(() => _isCurrentReady = _currentController.text.isNotEmpty);
  }

  // Возврат на предыдущий экран с сохранением
  void _gotoSaveCounter() {
    Navigator.pop(
        context,
        !_isNew
            ? _currentController.text
            : Counter(
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
