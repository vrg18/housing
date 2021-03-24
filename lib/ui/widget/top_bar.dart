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
  final VoidCallback? phoneCallback;

  TopBar({
    required this.mainCallback,
    required this.mainIcon,
    this.iconSize,
    this.phoneCallback,
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
            SizedBox(
              height: appBarHeight,
              child: ClipRRect(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
