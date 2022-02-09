import 'package:flutter/material.dart';
import 'package:mvvm/navigation/app_route.dart';
import 'package:mvvm/screen/create/create_todo_screen.dart';
import 'package:mvvm/screen/home/home_data.dart';
import 'package:mvvm/screen/home/home_view_model.dart';
import 'package:mvvm/screen/screen.dart';
import 'package:mvvm/widget/todo_tile.dart';
import 'package:provider/provider.dart';

class HomeScreenRoute extends AppRoute {
  HomeScreenRoute()
      : super(
          path: '/',
          builder: (context, state) => HomeScreen(key: state.pageKey),
        );
}

class HomeScreen extends Screen {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState
    extends ScreenState<HomeScreen, HomeViewModel, HomeData> {
  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          _TodoList(
            changeListener: _todoChangeListener,
          ),
          const Center(child: _ProgressBar()),
          const _EmptyState(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CreateTodoScreenRoute().push(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _todoChangeListener(TodoChange change) {
    viewModel.changeTodoStatus(change.id, change.isDone);
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<HomeData, bool>(
      selector: (_, data) => data.showLoading,
      builder: (context, showLoading, _) => Visibility(
        visible: showLoading,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<HomeData, bool>(
      selector: (_, data) => data.showEmptyState,
      builder: (context, showEmptyState, _) => Visibility(
        visible: showEmptyState,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            'Add something first',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
    );
  }
}

class _TodoList extends StatelessWidget {
  const _TodoList({
    Key? key,
    required this.changeListener,
  }) : super(key: key);

  final ValueChanged<TodoChange> changeListener;

  @override
  Widget build(BuildContext context) {
    return Selector<HomeData, List<TodoTileData>>(
      selector: (_, data) => data.todoTiles,
      builder: (context, todoTiles, _) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final data = todoTiles[index];
            return TodoTile(
              key: ValueKey(data.id),
              data: data,
              changeListener: changeListener,
            );
          },
          separatorBuilder: (_, __) => const Divider(),
          itemCount: todoTiles.length,
        );
      },
    );
  }
}
