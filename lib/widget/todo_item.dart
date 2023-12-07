import 'package:flutter/material.dart';

import 'package:todo_app/models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final void Function(Todo todo) updateTodo;
  final void Function(String id) deleteTodo;

  const TodoItem(
      {Key? key,
      required this.todo,
      required this.deleteTodo,
      required this.updateTodo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              todo.todoText,
              style: TextStyle(
                  fontSize: 16,
                  decoration:
                      todo.isCompleted ? TextDecoration.lineThrough : null),
            ),
            subtitle: Text(todo.isCompleted ? "Completed" : "Todo"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                color: Colors.blue,
                onPressed: () {
                  updateTodo(todo);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete_rounded),
                color: Colors.red,
                onPressed: () {
                  deleteTodo(todo.id);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
