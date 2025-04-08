import 'package:flutter/material.dart';

void main() {
  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primaryColor: Color(0xFFffafcc), // Soft pink
        colorScheme: ColorScheme.light(
          secondary: Color(0xFFa8e6cf), // Mint green
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFFffafcc),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'DancingScript',
          ),
          bodyLarge: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      home: TaskListScreen(),
    );
  }
}

class Task {
  String title;
  bool isDone;
  List<Map<String, dynamic>> subTasks;

  Task({required this.title, this.isDone = false, this.subTasks = const []});
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController taskController = TextEditingController();
  final List<Task> tasks = [];

  void addTask() {
    final title = taskController.text.trim();
    if (title.isNotEmpty) {
      setState(() {
        tasks.add(Task(title: title));
        taskController.clear();
      });
    }
  }

  void toggleTask(Task task) {
    setState(() {
      task.isDone = !task.isDone;
    });
  }

  void deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cute Tasks'),
        backgroundColor: Color(0xFFffafcc),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: "Enter task name",
                      labelStyle: TextStyle(color: Color(0xFFffafcc)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFffafcc)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addTask,
                  child: Text("Add", style: TextStyle(color: Colors.pink)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: tasks.map((task) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  color: Colors.pink.shade50,
                  child: ExpansionTile(
                    title: Row(
                      children: [
                        Checkbox(
                          value: task.isDone,
                          onChanged: (_) => toggleTask(task),
                        ),
                        Expanded(
                          child: Text(
                            task.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink.shade800,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.pink.shade600),
                          onPressed: () => deleteTask(task),
                        ),
                      ],
                    ),
                    children: task.subTasks.map((sub) {
                      return ListTile(
                        title: Text(
                          "${sub['time']} - ${sub['desc']}",
                          style: TextStyle(color: Colors.pink.shade700),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}