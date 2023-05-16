import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_flutter/colors.dart';
import 'package:hello_flutter/data/repository/task_repo_impl.dart';

import 'package:hello_flutter/data/model/task.dart';

class UpdateTask extends StatefulWidget {
  final String id;

  const UpdateTask({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  final repo = TasksRepoImpl();
  late int id;
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  @override
  void initState() {
    super.initState();
    id = int.parse(widget.id);
    getTask(id);
  }

  void getTask(id) async {
    var res = await repo.getTask(id);
    debugPrint(res?.title);

    if (res != null) {
      _title.text = res.title;
      _desc.text = res.desc;
    }
  }

  onTitleChanged(value) {
    _title.text = value;
    _title.selection = TextSelection.collapsed(offset: _title.text.length);
  }

  onDescChanged(value) {
    _desc.text = value;
    _desc.selection = TextSelection.collapsed(offset: _desc.text.length);
  }

  void _updateTask(task) async {
    await repo.updateTask(task);
  }

  onEditBtnClick(int id) {
    if (_title.text.isNotEmpty && _desc.text.isNotEmpty) {
      var task =
          Task(id: id, title: _title.text, desc: _desc.text, priority: 1, userId: 1);

      debugPrint(task.toString());

      _updateTask(task);
      context.pop("true");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Task"),
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
              controller: _title,
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
              controller: _desc,
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
              onPressed: () => onEditBtnClick(id),
              style: ElevatedButton.styleFrom(backgroundColor: pink),
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
