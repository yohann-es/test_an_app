// import 'package:english_words/english_words.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => MyAppState(),
//       child: MaterialApp(
//         title: 'Namer App',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 221, 11, 123)),
//         ),
//         home: MyHomePage(),
//       ),
//     );
//   }
// }



// class MyAppState extends ChangeNotifier {
//   var current = WordPair.random();

//   void getNext(){
//     current = WordPair.random();
//     notifyListeners();
//   }


// var favorites = <WordPair>[];

// void toggleFavorite(){
//   if(favorites.contains(current)){
//       favorites.remove(current);
//   }else{
//     favorites.add(current);
//   }
//   notifyListeners();
// }
// }
// // ...

// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   var selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     // ...

// Widget page;
// switch (selectedIndex) {
//   case 0:
//     page = GeneratorPage();
//     break;
//   case 1:
//     page = FavoritesPage();
//     break;
//   default:
//     throw UnimplementedError('no widget for $selectedIndex');
// }

// // ...

//     return LayoutBuilder(
//       builder: (context,constraints) {
//         return Scaffold(
//           body: Row(
//             children: [
//               SafeArea(
//                 child: NavigationRail(
//                   extended: constraints.maxWidth >= 600,
//                   destinations: [
//                     NavigationRailDestination(
//                       icon: Icon(Icons.home),
//                       label: Text('Home'),
//                     ),
//                     NavigationRailDestination(
//                       icon: Icon(Icons.favorite),
//                       label: Text('Favorites'),
//                     ),
//                   ],
//                   selectedIndex: selectedIndex,
//                   onDestinationSelected: (value) {
//                     setState(() {
//                       selectedIndex = value;
//                     });
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   color: Theme.of(context).colorScheme.primaryContainer,
//                   child: page,
//                 ),
//               ),
//             ],
//           ),
//         );
//       }
//     );
//   }
// }


// class GeneratorPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var appState = context.watch<MyAppState>();
//     var pair = appState.current;

//     IconData icon;
//     if (appState.favorites.contains(pair)) {
//       icon = Icons.favorite;
//     } else {
//       icon = Icons.favorite_border;
//     }

//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           BigCard(pair: pair),
//           SizedBox(height: 10),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ElevatedButton.icon(
//                 onPressed: () {
//                   appState.toggleFavorite();
//                 },
//                 icon: Icon(icon),
//                 label: Text('Like'),
//               ),
//               SizedBox(width: 10),
//               ElevatedButton(
//                 onPressed: () {
//                   appState.getNext();
//                 },
//                 child: Text('Next'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ...
// // ...

// class FavoritesPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var appState = context.watch<MyAppState>();

//     if (appState.favorites.isEmpty) {
//       return Center(
//         child: Text('No favorites yet.'),
//       );
//     }

//     return ListView(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(20),
//           child: Text('You have '
//               '${appState.favorites.length} favorites:'),
//         ),
//         for (var pair in appState.favorites)
//           ListTile(
//             leading: Icon(Icons.favorite),
//             title: Text(pair.asLowerCase),
//           ),
//       ],
//     );
//   }
// }


// class BigCard extends StatelessWidget {
//   const BigCard({
//     super.key,
//     required this.pair,
//   });

//   final WordPair pair;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     final style  = theme.textTheme.displayMedium!.copyWith(
//       color: theme.colorScheme.onPrimary,
//        );
//     return Card(
//       elevation: 20,
//       color: theme.colorScheme.secondary,
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Text(pair.asLowerCase,
//          style: style,
//          semanticsLabel: "${pair.first} ${pair.second}",
//          ),
//       ),
//     );
//   }
// }































import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();
  late Box<List> taskBox;
  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    taskBox = Hive.box<List>('tasks');
    tasks = List<String>.from(taskBox.get('taskList') ?? []);
  }

  void _addTask() {
    if (_controller.text.isEmpty) return;
    setState(() {
      tasks.add(_controller.text);
       print(_controller.text);
      _controller.clear();
      taskBox.put('taskList', tasks); // Save updated list
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
      taskBox.put('taskList', tasks); // Save updated list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hive To-Do")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Enter a task",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTask,
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(tasks[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteTask(index),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
