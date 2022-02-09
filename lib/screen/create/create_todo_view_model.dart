import 'package:injectable/injectable.dart';
import 'package:mvvm/model/todo.dart';
import 'package:mvvm/repository/todo_repository.dart';
import 'package:mvvm/screen/create/create_todo_data.dart';
import 'package:mvvm/view_model/view_model.dart';

@injectable
class CreateTodoViewModel extends ViewModel<CreateTodoData> {
  CreateTodoViewModel(
    this._todoRepository,
  ) : super(const CreateTodoData.initial());

  final TodoRepository _todoRepository;

  Future<bool> create(String title) async {
    if (title.isEmpty) {
      return false;
    }

    _updateState(isCreating: true);

    final todo = Todo(
      id: 'id',
      title: title,
      createdAt: DateTime.now(),
      isDone: false,
    );

    await _todoRepository.createTodo(todo);

    _updateState(isCreating: false);

    return true;
  }

  void _updateState({
    bool isCreating = false,
  }) {
    stateData = CreateTodoData(
      showSaveProgress: isCreating,
      enabledInput: !isCreating,
    );
  }
}
