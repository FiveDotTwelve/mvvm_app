import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef ScreenBuilder = Widget Function(
  BuildContext context,
  GoRouterState state,
);

abstract class AppRoute extends GoRoute {
  AppRoute({
    required String path,
    required ScreenBuilder builder,
  }) : super(
          path: path,
          builder: builder,
        );

  void push(BuildContext context) {
    context.push(path);
  }
}
