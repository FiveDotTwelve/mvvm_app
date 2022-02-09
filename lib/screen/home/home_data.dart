import 'package:mvvm/screen/state_data.dart';
import 'package:mvvm/widget/todo_tile.dart';

class HomeData extends StateData {
  const HomeData({
    required this.todoTiles,
    required this.showEmptyState,
    required this.showLoading,
  });

  const HomeData.initial()
      : todoTiles = const [],
        showLoading = false,
        showEmptyState = false;

  final List<TodoTileData> todoTiles;
  final bool showLoading;
  final bool showEmptyState;

  @override
  List<Object?> get props => [
        todoTiles,
        showLoading,
        showEmptyState,
      ];
}
