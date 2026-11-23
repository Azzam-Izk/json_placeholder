import 'package:flutter/material.dart';
import 'package:json_placeholder/models/todos.dart';

class TodoWidget extends StatelessWidget {
  final Todos todo;
  final ValueChanged<bool> onChanged;

  const TodoWidget({super.key, required this.todo, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: CheckboxListTile(
        value: todo.completed,
        onChanged: (value) {
          if (value != null) onChanged(value);
        },
        activeColor: theme.colorScheme.primary,
        checkColor: Colors.white,
        title: Text(
          todo.title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: todo.completed
                ? theme.colorScheme.onSurfaceVariant
                : theme.colorScheme.onSurface,
            decoration: todo.completed ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          "User ID: ${todo.userId}",
          style: theme.textTheme.bodySmall,
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
