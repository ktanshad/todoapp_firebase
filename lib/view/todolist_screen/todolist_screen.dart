import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/helpers/colors.dart';
import 'package:todo/view/add_screen/add_page.dart';
import 'package:todo/view/controller/auth_provider.dart';
import 'package:todo/view/controller/todo_provider.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  void initState() {
    // TODO: implement initState
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    todoProvider.fetchTodo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: backgroundcolor,
        title: const Text(
          'Todo List',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final authprovider = Provider.of<AuthProvider>(context, listen: false);
              authprovider.signOut();
            },
            icon: const Icon(Icons.login_rounded, color: Colors.white),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Consumer<TodoProvider>(
        builder: (context, value, child) {
          if (value.items.isEmpty) {
            return const Center(
              child: Text(
                'No todos found. Add new todos!',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: value.items.length,
              itemBuilder: (context, index) {
                final todoModel = value.items[index];
                return Card(
                  color: Colors.white, 
                  elevation: 2, 
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text(todoModel.title!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    subtitle: Text(todoModel.description!),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'edit') {
                          // Open edit page
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddPage(todoModel: todoModel)));
                        } else if (value == 'delete') {
                          // Delete and remove the item
                          Provider.of<TodoProvider>(context, listen: false).deleteData(todoModel.id!);
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                            child: Text('Edit'),
                            value: 'edit',
                          ),
                          const PopupMenuItem(
                            child: Text('Delete'),
                            value: 'delete',
                          )
                        ];
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPage()));
        },
        label: const Text('ADD TODO'),
      ),
    );
  }
}
