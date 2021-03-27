import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:housing/domain/address.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/icons.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:housing/ui/widget/decoration_of_text_field.dart';
import 'package:housing/ui/widget/top_bar.dart';

/// Страница создания нового адреса
class AddressNew extends StatefulWidget {
  @override
  _AddressNewState createState() => _AddressNewState();
}

class _AddressNewState extends State<AddressNew> {
  late final TextEditingController _streetController;
  late final TextEditingController _houseController;
  late final TextEditingController _buildingController;
  late final TextEditingController _apartmentController;
  late final FocusNode _streetFocus;
  late final FocusNode _houseFocus;
  late final FocusNode _buildingFocus;
  late final FocusNode _apartmentFocus;
  late bool _isAddressReady;

  @override
  void initState() {
    super.initState();
    _streetController = TextEditingController();
    _streetFocus = FocusNode();
    _streetFocus.addListener(() => setState(() {}));
    _houseController = TextEditingController();
    _houseFocus = FocusNode();
    _houseFocus.addListener(() => setState(() {}));
    _buildingController = TextEditingController();
    _buildingFocus = FocusNode();
    _buildingFocus.addListener(() => setState(() {}));
    _apartmentController = TextEditingController();
    _apartmentFocus = FocusNode();
    _apartmentFocus.addListener(() => setState(() {}));
    _isAddressReady = false;
  }

  @override
  void dispose() {
    _streetController.dispose();
    _streetFocus.dispose();
    _houseController.dispose();
    _houseFocus.dispose();
    _buildingController.dispose();
    _buildingFocus.dispose();
    _apartmentController.dispose();
    _apartmentFocus.dispose();
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
                newAddressLabel,
                maxLines: 1,
                style: inputInAccountStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: heightOfButtonsAndTextFields,
                child: TextField(
                  controller: _streetController,
                  focusNode: _streetFocus,
                  autofocus: true,
                  decoration: decorationOfTextField(addressStreetLabel, _streetFocus, null),
                  onChanged: (text) => _setIsAddressReady(),
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_houseFocus),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: heightOfButtonsAndTextFields,
                child: TextField(
                  controller: _houseController,
                  focusNode: _houseFocus,
                  autofocus: true,
                  decoration: decorationOfTextField(addressHouseLabel, _houseFocus, null),
                  onChanged: (text) => _setIsAddressReady(),
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_buildingFocus),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: heightOfButtonsAndTextFields,
                child: TextField(
                  controller: _buildingController,
                  focusNode: _buildingFocus,
                  autofocus: true,
                  decoration: decorationOfTextField(addressBuildingLabel, _buildingFocus, null),
                  onChanged: (text) => _setIsAddressReady(),
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_apartmentFocus),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: heightOfButtonsAndTextFields,
                child: TextField(
                  controller: _apartmentController,
                  focusNode: _apartmentFocus,
                  autofocus: true,
                  decoration: decorationOfTextField(addressApartmentLabel, _apartmentFocus, null),
                  onChanged: (text) => _setIsAddressReady(),
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: Text(
                  saveLabelButton,
                  style: _isAddressReady ? activeButtonLabelStyle : inactiveButtonLabelStyle,
                ),
                onPressed: _isAddressReady ? () => _gotoSaveCounter() : null,
                style: TextButton.styleFrom(
                  backgroundColor: _isAddressReady ? null : inactiveBackgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setIsAddressReady() {
    setState(() => _isAddressReady = _streetController.text.isNotEmpty && _houseController.text.isNotEmpty);
  }

  // Возврат на предыдущий экран с сохранением
  void _gotoSaveCounter() {
    Navigator.pop(
        context,
        Address(
          street: _streetController.text,
          house: _houseController.text,
          building: _buildingController.text.isNotEmpty ? _buildingController.text : null,
          apartment: _apartmentController.text.isNotEmpty ? _apartmentController.text : null,
        ));
  }

  // Возврат на предыдущий экран без сохранения
  void _returnToPreviousScreen() {
    Navigator.pop(context, null);
  }
}
