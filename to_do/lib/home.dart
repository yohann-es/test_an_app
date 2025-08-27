import 'package:flutter/material.dart';

class ToDoHomePage extends StatefulWidget {
  const ToDoHomePage({super.key});

  @override
  State<ToDoHomePage> createState() => _ToDoHomePageState();
}

class _ToDoHomePageState extends State<ToDoHomePage> {
  final List<String> tasks = [];
  List<Map<dynamic, dynamic>> allItems = [];
  bool? _isChecked = false;

  void _addTask() {
    setState(() {
      allItems.add({"title": TextField(), "checked": false});
      // tasks.add("Task ${tasks.length + 1}"); // add a new task
    });
  }

  void _removeTask() {
    if (allItems.isEmpty) return;
    setState(() {
      allItems.removeWhere((item) => item["checked"] == true);
      _isChecked = false;
      // allItems.removeAt(allItems.length - 1);
    });
  }

  void _atChecked(int index, bool? newValue) {
    setState(() {
      allItems[index]["checked"] = newValue ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TO DO APP')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                ElevatedButton(onPressed: _addTask, child: Text('Add Task')),
                SizedBox(width: 200),
                Card(
                  child: Checkbox(
                    value: _isChecked,
                    onChanged: (newValue) {
                      setState(() {
                        _isChecked = newValue;
                        for (var item in allItems) {
                          item["checked"] = newValue;
                        }
                      });
                    },
                    activeColor: Colors.orange,
                  ),
                ),
              ],//<> children 
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: allItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      subtitle: Checkbox(
                        value: allItems[index]["checked"],
                        onChanged: (newValue) {
                          _atChecked(index, newValue);
                        },
                        activeColor: Colors.orangeAccent,
                      ),

                      title: allItems[index]["title"],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                ElevatedButton(onPressed: _removeTask, child: Text('Delete')),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60.0, // Set desired height
        color: Color.fromARGB(113, 30, 17, 23), // Set desired background color
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [],
        ),
      ),
    );
  }
}
