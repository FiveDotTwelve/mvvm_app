import 'package:flutter/material.dart';
import 'package:mvvm/widget/global_provider.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.routeInformationParser,
    required this.routerDelegate,
  }) : super(key: key);

  final RouteInformationParser<Object> routeInformationParser;
  final RouterDelegate<Object> routerDelegate;

  @override
  Widget build(BuildContext context) {
    return GlobalProvider(
      child: MaterialApp.router(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        routeInformationParser: routeInformationParser,
        routerDelegate: routerDelegate,
      ),
    );
  }
}
