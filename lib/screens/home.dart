import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/widgets/search_box.dart';
import 'package:todo_app/widget/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _todoController = TextEditingController();
  final todos = Todo.todos();
  List<Todo> _filteredTodo = [];

  @override
  void initState() {
    _filteredTodo = todos;
    super.initState();
  }

  void _updateTodo(Todo todo) {
    setState(() {
      todo.isCompleted = !todo.isCompleted;
    });
  }

  void _deleteTodo(String id) {
    setState(() {
      todos.removeWhere((element) => element.id == id);
    });
  }

  void _addTodo(String todoText) {
    setState(() {
      todos.add(Todo(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          todoText: todoText));
    });
    _todoController.clear();
  }

  void _filterTodo(String filteredText) {
    setState(() {
      _filteredTodo = filteredText.isEmpty
          ? todos
          : todos
              .where((element) => element.todoText
                  .toLowerCase()
                  .contains(filteredText.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        )
                      ],
                      border: Border.all(
                          color: isDarkMode ? Colors.white : Colors.black),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          border: InputBorder.none,
                          hintText: "Add Todo"),
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black),
                      cursorColor: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    _addTodo(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, elevation: 5),
                  child: const Text(
                    "+",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  SearchBox(
                    onFilter: _filterTodo,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _filteredTodo.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return TodoItem(
                          todo: _filteredTodo[index],
                          deleteTodo: _deleteTodo,
                          updateTodo: _updateTodo,
                        );
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Todo App",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          Switch(
              value: Provider.of<ThemeProvider>(context).isDarkMode,
              onChanged: (bool value) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              })
        ],
      ),
    );
  }
}
