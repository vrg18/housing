import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:housing/data/provider/is_web.dart';
import 'package:housing/data/service/client_service.dart';
import 'package:housing/data/service/counter_service.dart';
import 'package:housing/domain/address.dart';
import 'package:housing/domain/request.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/icons.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:housing/ui/screen/web_wrapper.dart';
import 'package:housing/ui/widget/decoration_of_text_field.dart';
import 'package:housing/ui/widget/top_bar.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

import 'address_new.dart';

class RequestNew extends StatefulWidget {
  @override
  _RequestNewState createState() => _RequestNewState();
}

class _RequestNewState extends State<RequestNew> {
  late Address? _address;
  late final FocusNode _addressFocus;
  late final TextEditingController _surnameController;
  late final FocusNode _surnameFocus;
  late final TextEditingController _nameController;
  late final FocusNode _nameFocus;
  late final TextEditingController _patronymicController;
  late final FocusNode _patronymicFocus;
  late final TextEditingController _phoneController;
  late final FocusNode _phoneFocus;
  late final TextEditingController _emailController;
  late final FocusNode _emailFocus;
  late final TextEditingController _subjectController;
  late final FocusNode _subjectFocus;
  late final TextEditingController _textController;
  late final FocusNode _textFocus;
  late bool _isRequestReady;

  @override
  void initState() {
    super.initState();
    if (context.read<CounterService>().addresses.length == 1) {
      _address = context.read<CounterService>().addresses[0];
    }
    _addressFocus = FocusNode();
    _addressFocus.addListener(() => setState(() {}));
    _surnameController = TextEditingController();
    _surnameFocus = FocusNode();
    _surnameFocus.addListener(() => setState(() {}));
    _nameController = TextEditingController();
    _nameFocus = FocusNode();
    _nameFocus.addListener(() => setState(() {}));
    _patronymicController = TextEditingController();
    _patronymicFocus = FocusNode();
    _patronymicFocus.addListener(() => setState(() {}));
    _phoneController = TextEditingController(text: context.read<ClientService>().client.phone);
    _phoneFocus = FocusNode();
    _phoneFocus.addListener(() => setState(() {}));
    _emailController = TextEditingController();
    _emailFocus = FocusNode();
    _emailFocus.addListener(() => setState(() {}));
    _subjectController = TextEditingController();
    _subjectFocus = FocusNode();
    _subjectFocus.addListener(() => setState(() {}));
    _textController = TextEditingController();
    _textFocus = FocusNode();
    _textFocus.addListener(() => setState(() {}));
    _isRequestReady = false;
  }

  @override
  void dispose() {
    _addressFocus.dispose();
    _surnameController.dispose();
    _surnameFocus.dispose();
    _nameController.dispose();
    _nameFocus.dispose();
    _patronymicController.dispose();
    _patronymicFocus.dispose();
    _phoneController.dispose();
    _phoneFocus.dispose();
    _emailController.dispose();
    _emailFocus.dispose();
    _subjectController.dispose();
    _subjectFocus.dispose();
    _textController.dispose();
    _textFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        mainIcon: backIcon,
        mainCallback: _returnToPreviousScreen,
        iconMessage: backTooltipMessage,
      ),
      body: Padding(
        padding: const EdgeInsets.all(basicBorderSize),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AutoSizeText(
                newRequestLabel,
                maxLines: 1,
                style: inputInAccountStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _customDropDownButton(),
              const SizedBox(height: 8),
              _addAddressButton(),
              const SizedBox(height: 16),
              _customTextField(_surnameController, _surnameFocus, _nameFocus, surnameLabel, false, null),
              const SizedBox(height: 16),
              _customTextField(_nameController, _nameFocus, _patronymicFocus, nameLabel, false, null),
              const SizedBox(height: 16),
              _customTextField(_patronymicController, _patronymicFocus, _phoneFocus, patronymicLabel, false, null),
              const SizedBox(height: 16),
              _customTextField(_phoneController, _phoneFocus, _emailFocus, phoneLabel, false, TextInputType.phone),
              const SizedBox(height: 16),
              _customTextField(
                  _emailController, _emailFocus, _subjectFocus, emailLabel, false, TextInputType.emailAddress),
              const SizedBox(height: 16),
              _customTextField(_subjectController, _subjectFocus, _textFocus, subjectLabel, false, null),
              const SizedBox(height: 16),
              _customTextField(_textController, _textFocus, null, textLabel, true, TextInputType.multiline),
              const SizedBox(height: 16),
              ElevatedButton(
                child: Text(
                  saveLabelButton,
                  style: _isRequestReady ? activeButtonLabelStyle : inactiveButtonLabelStyle,
                ),
                onPressed: _isRequestReady ? () => _gotoSaveRequest() : null,
                style: TextButton.styleFrom(
                  backgroundColor: _isRequestReady ? null : inactiveBackgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customDropDownButton() {
    return SizedBox(
      height: 60,
      child: DropdownButtonFormField<Address>(
        value: _address,
        focusNode: _addressFocus,
        style: dropdownButtonStyle,
        decoration: InputDecoration(
          labelText: addressLabel,
          labelStyle: TextStyle(color: _addressFocus.hasFocus ? basicBlue : Colors.grey[600]),
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          _addressFocus.nextFocus();
          _address = value!;
          _setIsRequestReady();
        },
        items: context
            .read<CounterService>()
            .addresses
            .map((a) => DropdownMenuItem(value: a, child: Text(a.toString())))
            .toList(),
      ),
    );
  }

  Widget _addAddressButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: 100,
        child: ElevatedButton(
          child: AutoSizeText(
            addAddressLabel,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          style: blueButtonStyle,
          onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => context.read<Web>().isWeb ? WebWrapper(AddressNew()) : AddressNew()))
              .then((value) => _gotoSaveAddress(context, value)),
        ),
      ),
    );
  }

  Widget _customTextField(TextEditingController controller, FocusNode currentFocus, FocusNode? nextFocus, String label,
      bool multiLine, TextInputType? inputType) {
    return SizedBox(
      height: multiLine ? heightOfButtonsAndTextFields * 3 : heightOfButtonsAndTextFields,
      child: TextField(
        controller: controller,
        focusNode: currentFocus,
        autofocus: true,
        textAlignVertical: TextAlignVertical.top,
        expands: multiLine,
        maxLines: multiLine ? null : 1,
        minLines: multiLine ? null : 1,
        keyboardType: inputType,
        decoration: decorationOfTextField(label, currentFocus, null),
        onChanged: (_) => _setIsRequestReady(),
        onEditingComplete: () =>
            nextFocus != null ? FocusScope.of(context).requestFocus(nextFocus) : FocusScope.of(context).nextFocus(),
      ),
    );
  }

  void _setIsRequestReady() {
    setState(() => _isRequestReady = _address != null &&
        _surnameController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _subjectController.text.isNotEmpty &&
        (_emailController.text.isEmpty ||
            _emailController.text.isNotEmpty && EmailValidator.validate(_emailController.text, false, false)));
  }

  // Возврат на предыдущий экран с сохранением
  void _gotoSaveRequest() {
    Navigator.pop(
        context,
        Request(
          address: _address!,
          surname: _surnameController.text,
          name: _nameController.text,
          patronymic: _patronymicController.text,
          phone: _phoneController.text,
          email: _emailController.text,
          subject: _subjectController.text,
          text: _textController.text,
          createdAt: DateTime.now(),
        ));
  }

  // Возврат на предыдущий экран без сохранения
  void _returnToPreviousScreen() {
    Navigator.pop(context, null);
  }

  // Сохранить введенный новый адрес
  void _gotoSaveAddress(BuildContext context, dynamic value) {
    if (value != null && value is Address) {
      context.read<CounterService>().addNewAddress(value);
      setState(() => _address = value);
    }
  }
}
