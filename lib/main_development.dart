import 'package:be_focused/app/app.dart';
import 'package:be_focused/bootstrap.dart';
import 'package:flutter/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  bootstrap(() => const App());
}
