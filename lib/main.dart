import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvvm/app.dart';
import 'package:mvvm/inject/dependency_injection.dart';
import 'package:mvvm/navigation/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  initializeGetIt();

  final router = createRouter();

  return runApp(
    App(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    ),
  );
}
