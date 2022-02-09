import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:mvvm/model/todo.dart';

@singleton
class TodoRepository {
  final List<Todo> _todoList = [];

  final _todoListSC = StreamController<List<Todo>>.broadcast();

  Stream<List<Todo>> observeTodoList() async* {
    yield _todoList;
    yield* _todoListSC.stream;
  }

  Future<void> updateTodoList() async {
    // Simulate api request
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> createTodo(Todo todo) async {
    // Simulate api request
    await Future.delayed(const Duration(milliseconds: 300));

    _todoList.add(todo);
    _todoListSC.add(_todoList);
  }

  Future<void> updateTodoStatus(String id, bool isDone) async {
    // Simulate api request
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _todoList.indexWhere((element) => element.id == id);
    final updatedTodo = _todoList.removeAt(index).copyWith(isDone: isDone);
    _todoList.insert(index, updatedTodo);

    _todoListSC.add(_todoList);
  }
}
