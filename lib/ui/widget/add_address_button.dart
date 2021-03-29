import 'package:flutter/material.dart';
import 'package:housing/data/provider/is_web.dart';
import 'package:housing/data/service/counter_service.dart';
import 'package:housing/domain/address.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/screen/address_new.dart';
import 'package:housing/ui/screen/web_wrapper.dart';
import 'package:provider/provider.dart';

class AddAddressButton extends StatelessWidget {
  final Function(Address) callback;

  const AddAddressButton(this.callback);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: addAddressLabel,
      child: IconButton(
        icon: Icon(
          Icons.add_location_alt,
          size: 32,
          color: basicBlue,
        ),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => context.read<Web>().isWeb ? WebWrapper(AddressNew()) : AddressNew()))
            .then((value) => _gotoSaveAddress(context, value)),
      ),
    );
  }

  // Сохранить введенный новый адрес
  void _gotoSaveAddress(BuildContext context, dynamic value) {
    if (value != null && value is Address) {
      context.read<CounterService>().addNewAddress(value);
      callback(value);
    }
  }
}
