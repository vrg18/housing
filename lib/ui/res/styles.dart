import 'package:flutter/material.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:intl/intl.dart';

/// Определения стилей текстов и кнопок, применяемых в приложении

const TextStyle inputInAccountStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w600,
);

const TextStyle activeButtonLabelStyle = TextStyle(
  fontSize: 16,
  color: Colors.white,
);

final TextStyle inactiveButtonLabelStyle = TextStyle(
  fontSize: 16,
  color: Colors.grey[700],
);

final TextStyle activeButtonUnderlineLabelStyle = activeButtonLabelStyle.merge(
  TextStyle(
    color: basicBlue,
    decoration: TextDecoration.underline,
  ),
);

const TextStyle unselectedBarStyle = TextStyle(
  fontSize: 13,
);

final TextStyle dropdownButtonStyle = TextStyle(fontSize: 16, color: Colors.grey[800]);

final TextStyle currentReadingsCountersStyle = TextStyle(
  fontSize: 13,
  color: Colors.grey[700],
);

final TextStyle counterNameStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.grey[900],
);

final TextStyle basicBlueColorText = TextStyle(
  color: basicBlue,
  fontSize: 16,
);

final ButtonStyle counterCardStyle = TextButton.styleFrom(
  backgroundColor: appBarColor,
);

final ButtonStyle blueButtonStyle = TextButton.styleFrom(
  backgroundColor: basicBlue,
);

final ButtonStyle bigWhiteButtonStyle = TextButton.styleFrom(
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

final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
