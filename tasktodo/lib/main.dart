import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 30, 226, 233)),
        useMaterial3: true,
      ),
      home: const TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  late TextEditingController _taskController;
  late TextEditingController _descriptionController;

  final List<Map<String, String>> _tasks = []; // เก็บหัวข้อและรายละเอียด

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  void addTodoHandle(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add new task"),
          content: SizedBox(
            width: 120,
            height: 140,
            child: Column(
              children: [
                TextField(
                  controller: _taskController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Input your task",
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Description",
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _tasks.add({
                    "task": _taskController.text,
                    "description": _descriptionController.text
                  });
                });
                _taskController.clear();
                _descriptionController.clear();
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Todo-Homework!!!"),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    ),
    body: _tasks.isEmpty
        ? const Center(
            child: Text('No tasks added yet!'),
          )
        : ListView.builder(
            itemCount: _tasks.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text("Title: ${_tasks[index]["task"]!}"),
                  subtitle: Text("Detail: ${_tasks[index]["description"]!}"),
                ),
              );
            },
          ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        addTodoHandle(context);
      },
      child: const Icon(Icons.add),
    ),
  );
}
}
