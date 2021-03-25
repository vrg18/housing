import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:housing/data/service/client_service.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:provider/provider.dart';

/// Виджет кастомного верхнего бара, альтернатива AppBar
class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback mainCallback;
  final IconData mainIcon;
  final double? iconSize;
  final String? iconMessage;
  final VoidCallback? phoneCallback;
  final String? phoneMessage;

  TopBar({
    required this.mainCallback,
    required this.mainIcon,
    this.iconSize,
    this.iconMessage,
    this.phoneCallback,
    this.phoneMessage,
  });

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Container(
        height: appBarHeight,
        color: appBarColor,
        padding: const EdgeInsets.symmetric(horizontal: basicBorderSize),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: appBarHeight,
              width: appBarHeight,
              child: Tooltip(
                message: iconMessage ?? '',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: Icon(
                        mainIcon,
                        size: iconSize ?? 32,
                      ),
                      onTap: () => mainCallback(),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: appBarHeight,
              child: phoneCallback != null
                  ? Tooltip(
                      message: phoneMessage ?? '',
                      child: _profileButton(context),
                    )
                  : _profileButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileButton(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Row(
            children: [
              Icon(Icons.person),
              Text(context.read<ClientService>().client.phone),
            ],
          ),
          onTap: phoneCallback != null ? () => phoneCallback!() : null,
        ),
      ),
    );
  }
}
