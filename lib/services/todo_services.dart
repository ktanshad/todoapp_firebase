import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/model/todo_model.dart';

class TodoServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final CollectionReference firebaseUsers =
      FirebaseFirestore.instance.collection('user');

  Future<List<TodoModel>> fetchTodo() async {
    final user = firebaseAuth.currentUser;
   
      final snapshot = await firebaseUsers
          .doc(user!.uid)
          .collection('todolist')
          .get();
      return snapshot.docs.map((doc) {
        return TodoModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
  
  }

  Future<void> submitData(Map<String, dynamic> requestModel) async {
    final user = firebaseAuth.currentUser;
   
      final data = firebaseUsers
          .doc(user!.uid)
          .collection('todolist');
      await data.add(requestModel);
  }

  Future<void> updateData(Map<String, dynamic> requestModel, String? id) async {
    final user = firebaseAuth.currentUser;
      final data = firebaseUsers
          .doc(user!.uid)
          .collection('todolist')
          .doc(id);
      await data.update(requestModel);
   
  }

   Future<void> deleteData(String id) async{
       final user = firebaseAuth.currentUser;
      final data = firebaseUsers
          .doc(user!.uid)
          .collection('todolist');
   await data.doc(id).delete();
  
  }

}
