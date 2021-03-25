import 'package:flutter/material.dart';
import 'package:housing/data/provider/is_web.dart';
import 'package:housing/data/service/client_service.dart';
import 'package:housing/data/service/counter_service.dart';
import 'package:housing/domain/counter.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:housing/ui/screen/counter_new.dart';
import 'package:housing/ui/screen/web_wrapper.dart';
import 'package:housing/ui/widget/counter_card_elevated.dart';
import 'package:housing/ui/widget/popup_message.dart';
import 'package:housing/ui/widget/progress_indicator.dart';
import 'package:provider/provider.dart';

/// Верхнее бар-меню показаний счетчиков
class CountersManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!context.read<CounterService>().isAllLoaded) {
      _weReceiveCounters(context);
    }

    return Scaffold(
      body: context.watch<CounterService>().isAllLoaded
          ? Padding(
              padding: const EdgeInsets.all(basicBorderSize),
              child: GridView.extent(
                maxCrossAxisExtent: wideScreenSizeOver / 2,
                crossAxisSpacing: basicBorderSize,
                mainAxisSpacing: basicBorderSize,
                childAspectRatio: 2,
                children:
                    context.read<CounterService>().counters.asMap().values.map((e) => CounterCardElevated(e)).toList(),
              ),
            )
          : LoginProgressIndicator(basicBlue),
      floatingActionButton: SizedBox(
        width: 100,
        child: ElevatedButton(
          child: Text(
            addCounterLabel,
            textAlign: TextAlign.center,
          ),
          style: blueButtonStyle,
          onPressed: context.watch<CounterService>().isAllLoaded
              ? () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => context.read<Web>().isWeb ? WebWrapper(CounterNew()) : CounterNew()))
                  .then((value) => _gotoSaveCounter(context, value))
              : null,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<void> _weReceiveCounters(BuildContext context) async {
    String error = await context.read<CounterService>().getCounters(context.read<ClientService>().client);
    if (error.isNotEmpty) {
      popupMessage(context, error);
    }
  }

  Future<void> _gotoSaveCounter(BuildContext context, dynamic value) async {
    if (value != null && value is Counter) {
      String error = await context.read<CounterService>().addNewCounter(value);
      if (error.isNotEmpty) {
        popupMessage(context, error);
      }
    }
  }
}
