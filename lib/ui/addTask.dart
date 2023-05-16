import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_flutter/colors.dart';
import 'package:hello_flutter/data/repository/task_repo_impl.dart';

import 'package:hello_flutter/data/model/task.dart';
import 'package:hello_flutter/service/auth_service.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final repo = TasksRepoImpl();

  String _title = "";
  String _desc = "";

  onTitleChanged(value) {
    setState(() {
      _title = value;
    });
  }

  onDescChanged(value) {
    setState(() {
      _desc = value;
    });
  }

  void _createTask() async {
    final user = await AuthService.getUser();
    if (user != null && _title.isNotEmpty && _desc.isNotEmpty) {
      var task = Task(
          id: 0,
          title: _title,
          desc: _desc,
          priority: 1,
          userId: user.id);

      await repo.createTask(task);
    }
  }

  onAddBtnClick() {
    _createTask();
    context.pop("true");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        backgroundColor: pink,
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/white_bg.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => onTitleChanged(value),
              decoration: InputDecoration(
                hintText: "Title",
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: pink),
                    borderRadius: BorderRadius.circular(15.0)),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.pinkAccent, width: 2),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (value) => onDescChanged(value),
              decoration: InputDecoration(
                hintText: "Description",
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: pink),
                    borderRadius: BorderRadius.circular(15.0)),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.pinkAccent, width: 2),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => onAddBtnClick(),
              style: ElevatedButton.styleFrom(backgroundColor: pink),
              child: const Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
