import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:mvvm/repository/todo_repository.dart';
import 'package:mvvm/screen/home/home_data.dart';
import 'package:mvvm/view_model/view_model.dart';
import 'package:mvvm/widget/todo_tile.dart';

@injectable
class HomeViewModel extends ViewModel<HomeData> {
  HomeViewModel(
    this._todoRepository,
  ) : super(const HomeData.initial());

  final TodoRepository _todoRepository;

  StreamSubscription<List<TodoTileData>>? _todoSub;

  void init() {
    _updateList();

    _todoSub = _todoRepository
        .observeTodoList()
        .map((todoList) => todoList.map(TodoTileData.fromTodo).toList())
        .listen(_onTodoChanged);
  }

  @override
  void dispose() {
    _todoSub?.cancel();
    super.dispose();
  }

  Future<void> changeTodoStatus(String id, bool isDone) async {
    await _todoRepository.updateTodoStatus(id, isDone);
  }

  void _updateState({
    List<TodoTileData>? tiles,
    bool? isLoading,
  }) {
    tiles ??= value.todoTiles;
    isLoading ??= value.showLoading;

    stateData = HomeData(
      todoTiles: tiles,
      showEmptyState: tiles.isEmpty && !isLoading,
      showLoading: isLoading,
    );
  }

  Future<void> _updateList() async {
    _updateState(isLoading: true);

    await _todoRepository.updateTodoList();

    _updateState(isLoading: false);
  }

  void _onTodoChanged(List<TodoTileData> tiles) {
    _updateState(tiles: tiles);
  }
}
