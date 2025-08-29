//Next up is Todo App (CRUD + local DB). This will teach you lists, forms, SQLite, state management.
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
// import 'package:provider/provider.dart';
import 'home.dart';
import 'main.dart';

void main()  async{
    
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<List>('tasks');
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(113, 30, 17, 23),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(113, 30, 17, 23),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor:  Color.fromARGB(113, 30, 17, 23),
            foregroundColor: Colors.white,
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStatePropertyAll( Color.fromARGB(113, 30, 17, 23)),
        ),
      ),
      home: const ToDoHomePage(),
      // home: const TodoPage()
    );
  }
}
