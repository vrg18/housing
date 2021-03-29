import 'package:flutter/material.dart';
import 'package:housing/domain/request.dart';
import 'package:housing/ui/res/icons.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/widget/top_bar.dart';

class RequestDetails extends StatefulWidget {
  final Request request;

  const RequestDetails(this.request);

  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(
          mainIcon: backIcon,
          mainCallback: _returnToPreviousScreen,
          iconMessage: backTooltipMessage,
        ),
        body: Center(child: Text('Детали заявки')),
    );
  }

  void _returnToPreviousScreen() {
    Navigator.pop(context, null);
  }
}
