import 'package:flutter/material.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/sizes.dart';

/// Обертка для Web-экранов, своеобразный "закос" под телефон для Web
class WebWrapper extends StatelessWidget {
  final Widget child;

  const WebWrapper(this.child);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: constraints.maxWidth < widthWebWrapper || constraints.maxHeight < heightWebWrapper
              ? EdgeInsets.zero
              : const EdgeInsets.all(basicBorderSize),
          color: wrapperBackgroundColor,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusOfWebWrapper),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: widthWebWrapper,
                  maxHeight: heightWebWrapper,
                ),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
