import 'package:mvvm/screen/state_data.dart';

class CreateTodoData extends StateData {
  const CreateTodoData({
    required this.showSaveProgress,
    required this.enabledInput,
  });

  const CreateTodoData.initial()
      : showSaveProgress = false,
        enabledInput = true;

  final bool showSaveProgress;
  final bool enabledInput;

  @override
  List<Object?> get props => [
        showSaveProgress,
        enabledInput,
      ];
}
