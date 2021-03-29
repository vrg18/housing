import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:housing/data/provider/is_web.dart';
import 'package:housing/data/service/counter_service.dart';
import 'package:housing/domain/counter.dart';
import 'package:housing/domain/indication.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/icons.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:housing/ui/screen/web_wrapper.dart';
import 'package:housing/ui/widget/decoration_of_text_field.dart';
import 'package:housing/ui/widget/popup_message.dart';
import 'package:housing/ui/widget/top_bar.dart';
import 'package:provider/provider.dart';

import 'counter_history.dart';

/// Страница деталей счетчика и ввода новых показаний
class CounterDetails extends StatefulWidget {
  final Counter counter;

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

  late final FocusNode _currentFocus;
  late bool _isTitleReady;
  late bool _isCurrentReady;
  late bool _isEnableEdit;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.counter.title);
    _typeController = TextEditingController(text: widget.counter.counterType!.title);
    _addressController = TextEditingController(text: widget.counter.address.toString());
    _previousController = TextEditingController(
        text: widget.counter.previousValue != null
            ? '${widget.counter.previousValue.toString()} ${widget.counter.counterType!.measure}'
            : '');
    _currentController = TextEditingController();
    _titleFocus = FocusNode();
    _titleFocus.addListener(() => setState(() {}));
    _currentFocus = FocusNode();
    _currentFocus.addListener(() => setState(() {}));
    _isTitleReady = false;
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
    _currentFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getHistory();

    return KeyboardDismissOnTap(
      child: KeyboardVisibilityBuilder(
        builder: (_, isKeyboardVisible) => Scaffold(
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
                    counterLabel,
                    maxLines: 1,
                    style: inputInAccountStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: heightOfButtonsAndTextFields,
                    child: Stack(
                      children: [
                        TextField(
                          enabled: _isEnableEdit,
                          controller: _titleController,
                          focusNode: _titleFocus,
                          autofocus: true,
                          decoration: decorationOfTextField(counterNameLabel, _titleFocus, null),
                          onChanged: (text) => _setIsTitleReady(),
                          onEditingComplete: () => FocusScope.of(context).requestFocus(_currentFocus),
                        ),
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
                  TextField(
                    enabled: false,
                    controller: _typeController,
                    decoration: decorationOfTextField(counterTypeLabel, null, null),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    enabled: false,
                    controller: _addressController,
                    decoration: decorationOfTextField(installationAddressLabel, null, null),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    enabled: false,
                    controller: _previousController,
                    decoration: decorationOfTextField(previousValueLabel, null, null),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _currentController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    focusNode: _currentFocus,
                    decoration: decorationOfTextField(
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
                      saveLabelButton,
                      style: _isActiveSaveButton() ? activeButtonLabelStyle : inactiveButtonLabelStyle,
                    ),
                    onPressed: _isActiveSaveButton() ? () => _gotoSaveCounter() : null,
                    style: TextButton.styleFrom(
                      backgroundColor: _isActiveSaveButton() ? null : inactiveBackgroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: isKeyboardVisible
              ? null
              : SizedBox(
                  width: 110,
                  child: ElevatedButton(
                    child: AutoSizeText(
                      counterHistoryLabel,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    style: blueButtonStyle,
                    onPressed: () => _gotoHistory(),
                  ),
                ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      ),
    );
  }

  bool _isActiveSaveButton() {
    return _isCurrentReady;
  }

  void _setIsTitleReady() {
    setState(() => _isTitleReady = _titleController.text.isNotEmpty);
  }

  void _setIsCurrentReady() {
    setState(() {
      if (_currentController.text.isNotEmpty) {
        int? value = context.read<CounterService>().stringToInt(_currentController.text);
        if (value == null) {
          _currentController.text = '';
          _isCurrentReady = false;
        } else {
          if (widget.counter.previousValue != null && widget.counter.previousValue! > value) {
            _isCurrentReady = false;
          } else {
            _isCurrentReady = true;
          }
        }
      } else {
        _isCurrentReady = false;
      }
    });
  }

  // Возврат на предыдущий экран с сохранением
  void _gotoSaveCounter() {
    Navigator.pop(context, _currentController.text);
  }

  // Возврат на предыдущий экран без сохранения
  void _returnToPreviousScreen() {
    Navigator.pop(context, null);
  }

  // Загрузить историю показаний
  Future<void> _getHistory() async {
    if (!context.read<CounterService>().isHistoryLoaded) {
      String error = await context.read<CounterService>().getIndications();
      if (error.isNotEmpty) {
        popupMessage(context, error);
      }
    }
  }

  // Открыть историю показаний
  void _gotoHistory() {
    List<Indication> indications = context.read<CounterService>().getIndicationsOne(widget.counter.id!);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => context.read<Web>().isWeb
                ? WebWrapper(CounterHistory(widget.counter.title, indications))
                : CounterHistory(widget.counter.title, indications)));
  }
}
