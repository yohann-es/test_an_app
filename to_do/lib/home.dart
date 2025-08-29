import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ToDoHomePage extends StatefulWidget {
  const ToDoHomePage({super.key});

  @override
  State<ToDoHomePage> createState() => _ToDoHomePageState();
}

class _ToDoHomePageState extends State<ToDoHomePage> {
  late Box<List> taskBox;
  List<String> tasks = [];
  List<Map<dynamic, dynamic>> allItems = [];
  bool? _isChecked = false;

  // void _addTask() {
  //   setState(() {
  //           final TextEditingController controller = TextEditingController();

  //     // if(controller.text.isEmpty == true) return;
  //     dynamic textValue = TextField(controller: controller);
  //     allItems.add({"title": textValue, "checked": false});
  //     print("controller:  ${controller.text} ");
  //     // tasks.add("Task ${tasks.length + 1}"); // add a new task
  //   });
  // }

  @override
  void initState(){
    super.initState();
    taskBox = Hive.box<List>('tasks');
    tasks = List<String>.from(taskBox.get('taskList') ?? []);
  }

  void _addTask() {
  setState(() {
    final controller = TextEditingController();

    allItems.add({
      "controller": controller,  // keep the controller
      "checked": false
    });
      for(int i =0 ; i<allItems.length ; i ++){
        print("all items: ${allItems[i]["controller"].text}");
      }
    
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
              ], //<> children
            ),
            // Expanded(
            //   child: ListView.builder(
            //     padding: const EdgeInsets.all(20),
            //     itemCount: allItems.length,
            //     itemBuilder: (context, index) {
            //       return Card(
            //         child: ListTile(
            //           subtitle: Checkbox(
            //             value: allItems[index]["checked"],
            //             onChanged: (newValue) {
            //               _atChecked(index, newValue);
            //             },
            //             activeColor: Colors.orangeAccent,
            //           ),

            //           title: allItems[index]["title"],
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Expanded(
  child: ListView.builder(
    itemCount: allItems.length,
    itemBuilder: (context, index) {
      final item = allItems[index];
      return ListTile(
        leading: Checkbox(
          value: item["checked"],
          // onChanged:
          // (val) {
          //   setState(() {
          //     item["checked"] = val!;
          //   });
          // },
          onChanged: (newValue){
            _atChecked(index, newValue);
          }
          ,
        ),
        title: TextField(
          controller: item["controller"], // <- controller stays alive
          decoration: const InputDecoration(
            hintText: "Enter task",
          ),
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
