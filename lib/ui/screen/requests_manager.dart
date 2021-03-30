import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:housing/data/provider/is_web.dart';
import 'package:housing/data/service/client_service.dart';
import 'package:housing/data/service/request_service.dart';
import 'package:housing/domain/request.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:housing/ui/screen/request_new.dart';
import 'package:housing/ui/screen/web_wrapper.dart';
import 'package:housing/ui/widget/popup_message.dart';
import 'package:housing/ui/widget/progress_indicator.dart';
import 'package:housing/ui/widget/request_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// Основная страница заявок
class RequestsManager extends StatefulWidget {
  @override
  _RequestsManagerState createState() => _RequestsManagerState();
}

class _RequestsManagerState extends State<RequestsManager> {
  int? _indexOpenedCard;

  @override
  Widget build(BuildContext context) {
    _weReceiveRequests(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        bool wideScreen = constraints.maxWidth > wideScreenSizeOver;
        return Scaffold(
          body: context.watch<RequestService>().isAllLoaded
              ? Padding(
                  padding: const EdgeInsets.all(basicBorderSize),
                  child: StaggeredGridView.countBuilder(
                    itemCount: context.read<RequestService>().requests.length,
                    crossAxisCount: wideScreen
                        ? context.read<RequestService>().requests.length
                        : context.read<RequestService>().requests.length,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemBuilder: (context, index) => RequestCard(
                      context.read<RequestService>().requests[index],
                      index,
                      _changeIndexOpenedCard,
                      index == _indexOpenedCard,
                    ),
                    staggeredTileBuilder: (_) => StaggeredTile.fit(context.read<RequestService>().requests.length),
                  ),
                )
              : LoginProgressIndicator(basicBlue),
          floatingActionButton: SizedBox(
            width: 90,
            child: ElevatedButton(
              child: AutoSizeText(
                newRequestLabel,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              style: blueButtonStyle,
              onPressed: context.watch<RequestService>().isAllLoaded
                  ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => context.read<Web>().isWeb ? WebWrapper(RequestNew()) : RequestNew()))
                      .then((value) => _gotoSaveRequest(context, value))
                  : null,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }

  Future<void> _weReceiveRequests(BuildContext context) async {
    if (!context.read<RequestService>().isAllLoaded) {
      String error = await context.read<RequestService>().getRequests(context.read<ClientService>().client);
      if (error.isNotEmpty) {
        popupMessage(context, error);
      }
    }
  }

  Future<void> _gotoSaveRequest(BuildContext context, dynamic value) async {
    if (value != null && value is Request) {
      String error = await context.read<RequestService>().addNewRequest(value);
      if (error.isNotEmpty) {
        popupMessage(context, error);
      }
    }
  }

  _changeIndexOpenedCard(int index) {
    setState(() => _indexOpenedCard = index);
  }
}
