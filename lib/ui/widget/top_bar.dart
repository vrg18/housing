import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/icons.dart';
import 'package:housing/ui/res/sizes.dart';

/// Виджет кастомного верхнего бара, альтернатива AppBar
class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String phone;
  final VoidCallback callback;

  TopBar(this.phone, this.callback);

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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Row(
                      children: [
                        Icon(Icons.person),
                        Text(phone),
                      ],
                    ),
                    onTap: () => {},
                  ),
                ),
              ),
            ),
            SizedBox(
              height: appBarHeight,
              width: appBarHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Icon(
                      logoutIcon,
                      size: 16,
                    ),
                    onTap: () => callback(),
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
