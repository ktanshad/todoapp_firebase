import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/helpers/colors.dart';
import 'package:todo/view/controller/todo_provider.dart';

class AddPage extends StatefulWidget {
  final todoModel;
  const AddPage({super.key, this.todoModel});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final todo = widget.todoModel;
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    if (todo != null) {
      todoProvider.isEditValueChange(true);
      final title = todo.title;
      final description = todo.description;
      todoProvider.titleController.text = title;
      todoProvider.DescriptionController.text = description;
    } else {
      todoProvider.isEditValueChange(false);
      todoProvider.titleController.text = '';
      todoProvider.DescriptionController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: backgroundcolor,
        title: Text(
          Provider.of<TodoProvider>(context).isEdit ? 'Edit Todo' : 'ADD TODO',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: Provider.of<TodoProvider>(context, listen: false)
                  .titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: Provider.of<TodoProvider>(context, listen: false)
                  .DescriptionController,
              decoration: const InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 8,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final todoProvider =
                      Provider.of<TodoProvider>(context, listen: false);
                  todoProvider.isEdit
                      ? todoProvider.updateData(widget.todoModel)
                      : todoProvider.SubmitData();
                  Navigator.pop(context);
                }
              },
              child: Text(
                Provider.of<TodoProvider>(context).isEdit ? 'Update' : 'Submit',style:TextStyle(color: backgroundcolor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
