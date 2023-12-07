import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/providers/theme_provider.dart';

class SearchBox extends StatelessWidget {
  final void Function(String) onFilter;

  const SearchBox({Key? key, required this.onFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isDarkMode ? Colors.white : Colors.black, width: 1),
      ),
      child: TextField(
        onChanged: onFilter,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.search,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: "Search",
        ),
        cursorColor: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
}
