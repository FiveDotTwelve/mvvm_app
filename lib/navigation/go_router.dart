import 'package:go_router/go_router.dart';
import 'package:mvvm/screen/create/create_todo_screen.dart';
import 'package:mvvm/screen/home/home_screen.dart';

GoRouter createRouter() {
  return GoRouter(
    routes: [
      HomeScreenRoute(),
      CreateTodoScreenRoute(),
    ],
  );
}
