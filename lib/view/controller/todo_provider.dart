import 'package:flutter/material.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/services/todo_services.dart';

class TodoProvider extends ChangeNotifier {

  TextEditingController titleController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();
  List<TodoModel> items=[];
  bool isEdit =false;
  TodoServices todoServices=TodoServices();
  

  Future<void> SubmitData() async {
    //get the data from form
    final title = titleController.text;
    final description = DescriptionController.text;
    
   final requestModel={
   "title":title,
   "description":description
   };

      await todoServices.submitData(requestModel);
      titleController.text='';
      DescriptionController.text='';
      fetchTodo();
  }

  Future<void> fetchTodo()async{
     items=await todoServices.fetchTodo();
      notifyListeners();
    } 
  

  Future<void> deleteData(String id)async{
     await todoServices.deleteData(id);
      items.removeWhere((todo) => todo.id == id);
      notifyListeners();
  }


  Future<void> updateData(TodoModel todoModel)async{
    if(todoModel==null){
      print('you can not call updated without todo data');
      return;
    }
    final id=todoModel.id;
    final title=titleController.text;
    final description=DescriptionController.text;
     final requestModel={
      "title": title,
       "description": description,};

    try{
      await todoServices.updateData(requestModel,id);
    fetchTodo();
    }catch(e){
      throw Exception('update :$e');

    }
     }
     void isEditValueChange(bool value){
    isEdit=value;
  }
  
  }

 


  




