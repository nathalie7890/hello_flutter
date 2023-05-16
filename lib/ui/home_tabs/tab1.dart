import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_flutter/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/task.dart';
import 'package:hello_flutter/colors.dart';
import '../../data/repository/task_repo_impl.dart';

class FirstTab extends StatefulWidget {
  const FirstTab({
    Key? key,
  }) : super(key: key);

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  final sharedPref = SharedPreferences.getInstance();

  var _tasks = <Task>[];
  final repo = TasksRepoImpl();

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() async {
    final user = await AuthService.getUser();
    if (user != null) {
      final res = await repo.getTaskByUserId(user.id);
      setState(() {
        _tasks = res;
      });
    }
  }

  // void _createTask() async {
  //   const task = Task(title: "title", desc: "desc");
  //   await repo.createTask(task);
  //   _refresh();
  // }

  _addBtnOnClick() async {
    var res = await context.push("/addTask");
    if (res == 'true') _refresh();
  }

  _editBtnOnClick(int id) async {
    var res = await context.push("/updateTask/$id");
    if (res == 'true') _refresh();
  }

  void _deleteTask(int id) async {
    await repo.deleteTask(id);
    _refresh();
  }

  Future<bool> _onConfirmDismiss(DismissDirection dir) async {
    if (dir == DismissDirection.endToStart) {
      return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Are you sure?"),
              content: const Text(
                  "The item will be deleted and the action cannot be undone."),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: pink),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text("Yes")),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("No"))
              ],
            );
          });
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
            color: Colors.pinkAccent.shade100,
            width: double.infinity,
            child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: Dismissible(
                      key: Key(task.id.toString()),
                      onDismissed: (dir) {
                        _deleteTask(task.id);
                      },
                      secondaryBackground: Container(
                        color: Colors.green,
                      ),
                      confirmDismiss: (dir) async {
                        return _onConfirmDismiss(dir);
                      },
                      background: Container(
                        color: Colors.red.shade600,
                        child: const Center(
                          child: Text("Deleted"),
                        ),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Title: ${task.title}",
                              style: const TextStyle(color: pink, fontSize: 18),
                            ),
                            Text(
                              "Description: ${task.desc}",
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 15),
                            ),
                            Text(
                              "Priority: ${task.priority}",
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _editBtnOnClick(task.id);
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.black45,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    _deleteTask(task.id);
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addBtnOnClick();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
