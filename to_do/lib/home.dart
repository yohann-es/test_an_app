import 'package:flutter/material.dart';

class ToDoHomePage extends StatefulWidget {
  const ToDoHomePage({super.key});

  @override
  State<ToDoHomePage> createState() => _ToDoHomePageState();
}

class _ToDoHomePageState extends State<ToDoHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TO DO')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    print('Add task pressed');
                  },
                  child: Text('Add Task'),
                ),
                SizedBox(width: 150),
                ElevatedButton(
                  onPressed: () {
                    print('Edit task pressed');
                  },
                  child: Text('Edit task'),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20),
                children: <Widget>[
                  Center(
                    child: Text(
                      'Sooraj S Nair',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                ElevatedButton(
                  onPressed: () {
                    print('Delete pressed');
                  },
                  child: Text('Delete Entry'),
                ),
                SizedBox(width: 100),
                ElevatedButton(
                  onPressed: () {
                    print('Delete Checked pressed');
                  },
                  child: Text('Delete Checked'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60.0, // Set desired height
        color: Color.fromARGB(255, 157, 38, 81), // Set desired background color
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.home, color: Colors.white),
            Icon(Icons.search, color: Colors.white),
            Icon(Icons.settings, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
