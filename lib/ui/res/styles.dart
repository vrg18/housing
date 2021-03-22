import 'package:flutter/material.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/sizes.dart';

/// Определения стилей текстов и кнопок, применяемых в приложении

const TextStyle inputInAccountStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w600,
);

const TextStyle buttonLabelStyle = TextStyle(
  fontSize: 16,
);

const TextStyle unselectedBarStyle = TextStyle(
  fontSize: 13,
);

const TextStyle counterNameStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,

);

final TextStyle basicBlueColorText = TextStyle(
  color: basicBlue,
  fontSize: 16,
);

final ButtonStyle bigWhiteButtonStyle = TextButton.styleFrom(
  primary: basicBlue,
  backgroundColor: Colors.white,
);

final ButtonStyle smallerWhiteButtonStyle = bigWhiteButtonStyle.merge(
  TextButton.styleFrom(
    minimumSize: Size.fromHeight(heightOfButtonsAndTextFields * 0.75),
  ),
);

final ButtonStyle rightSmallerWhiteButtonStyle = bigWhiteButtonStyle.merge(
  TextButton.styleFrom(
    minimumSize: Size.fromHeight(heightOfButtonsAndTextFields * 0.75),
    alignment: Alignment.centerRight,
  ),
);
//
// final ButtonStyle bigWhiteButtonWithFrameStyle = bigWhiteButtonStyle.merge(
//   TextButton.styleFrom(
//
//     minimumSize: Size.fromHeight(heightOfButtonsAndTextFields * 0.75),
//   ),
// );
