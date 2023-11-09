import 'package:flutter/material.dart';
import 'data.dart';

class listWidget extends StatelessWidget {
  final Data todo;
  final Null Function() onDelete;
  final Null Function() onEdit;
  const listWidget({
    super.key,
    required this.todo,
    required this.onDelete,
    required this.onEdit,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: todo.icon ?? const Icon(Icons.home),
      title: Text(todo.title),
      trailing: InkWell(
        onTap: onDelete,
        child: const Icon(
          Icons.delete,
        ),
      ),
      onTap: onEdit,
    );
  }
}
