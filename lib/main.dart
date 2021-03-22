import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:housing/ui/app/app.dart';

void main() async {
  await load(fileName: 'config.env');
  runApp(App());
}
