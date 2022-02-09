import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  const Todo({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.isDone,
  });

  final String id;
  final String title;
  final DateTime createdAt;
  final bool isDone;

  @override
  List<Object?> get props => [
        id,
        title,
        createdAt,
        isDone,
      ];

  Todo copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      isDone: isDone ?? this.isDone,
    );
  }
}
