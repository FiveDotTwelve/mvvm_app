import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm/navigation/app_route.dart';
import 'package:mvvm/screen/create/create_todo_data.dart';
import 'package:mvvm/screen/create/create_todo_view_model.dart';
import 'package:mvvm/screen/screen.dart';
import 'package:provider/provider.dart';

class CreateTodoScreenRoute extends AppRoute {
  CreateTodoScreenRoute()
      : super(
          path: '/create',
          builder: (context, state) => CreateTodoScreen(key: state.pageKey),
        );
}

class CreateTodoScreen extends Screen {
  const CreateTodoScreen({Key? key}) : super(key: key);

  @override
  _CreateTodoScreenState createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState
    extends ScreenState<CreateTodoScreen, CreateTodoViewModel, CreateTodoData> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TodoTitleInput(controller: _textController),
            const SizedBox(height: 16),
            MaterialButton(
              child: const _SaveButtonChild(),
              color: Theme.of(context).colorScheme.primary,
              textTheme: ButtonTextTheme.primary,
              onPressed: _onCreateTap,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onCreateTap() async {
    final isCreated = await viewModel.create(_textController.text);

    if (!isCreated) {
      return;
    }

    context.pop();
  }
}

class _TodoTitleInput extends StatelessWidget {
  const _TodoTitleInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Selector<CreateTodoData, bool>(
      selector: (_, data) => data.enabledInput,
      builder: (context, enable, _) {
        return TextFormField(
          controller: controller,
          decoration: InputDecoration(
            label: const Text('Title'),
            enabled: enable,
          ),
        );
      },
    );
  }
}

class _SaveButtonChild extends StatelessWidget {
  const _SaveButtonChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<CreateTodoData, bool>(
      selector: (_, data) => data.showSaveProgress,
      builder: (context, showProgress, _) {
        if (showProgress) {
          return SizedBox.square(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onPrimary,
              strokeWidth: 1,
            ),
            dimension: 16,
          );
        } else {
          return const Text('Save');
        }
      },
    );
  }
}
