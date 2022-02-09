import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/model/todo.dart';

class TodoTileData extends Equatable {
  const TodoTileData({
    required this.id,
    required this.title,
    required this.isDone,
  });

  TodoTileData.fromTodo(Todo todo)
      : id = todo.id,
        title = todo.title,
        isDone = todo.isDone;

  final String id;
  final String title;
  final bool isDone;

  @override
  List<Object?> get props => [id, title, isDone];

  TodoTileData copyWith({
    String? id,
    String? title,
    bool? isDone,
  }) {
    return TodoTileData(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}

class TodoChange extends Equatable {
  const TodoChange({
    required this.id,
    required this.isDone,
  });

  final String id;
  final bool isDone;

  @override
  List<Object?> get props => [id, isDone];
}

class TodoTile extends StatefulWidget {
  const TodoTile({
    Key? key,
    required this.data,
    required this.changeListener,
  }) : super(key: key);

  final TodoTileData data;
  final ValueChanged<TodoChange> changeListener;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  late TodoTileData _data;

  @override
  void initState() {
    super.initState();
    _data = widget.data;
  }

  @override
  void didUpdateWidget(covariant TodoTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_data != widget.data) {
      setState(_updateData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Text(_data.title)),
          const SizedBox(width: 16),
          Checkbox(
            value: _data.isDone,
            onChanged: _onCheckboxChanged,
          ),
        ],
      ),
    );
  }

  void _onCheckboxChanged(bool? isChecked) {
    if (isChecked == null) {
      return;
    }

    setState(() {
      final tileData = _data.copyWith(isDone: isChecked);
      final change = TodoChange(id: tileData.id, isDone: tileData.isDone);
      _updateData(tileData);
      widget.changeListener(change);
    });
  }

  void _updateData([TodoTileData? data]) {
    _data = data ?? widget.data;
  }
}
