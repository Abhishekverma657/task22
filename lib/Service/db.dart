import 'package:cloud_firestore/cloud_firestore.dart';

class DBMethod{
   Future addTask(Map<String , dynamic>TaskInfoMap, String id){
    return FirebaseFirestore.instance.collection('tasks').doc(id).set(TaskInfoMap);

   }
     
     //// get all task
     
     Future <Stream<QuerySnapshot>> getTask()async{
      return FirebaseFirestore.instance.collection('tasks').snapshots();
       


     }
       //update Status
         Future<void> updateTaskStatus(String taskId, bool status) async {
    await FirebaseFirestore.instance. collection("tasks").doc(taskId).update({"Status": status});
  }
       // delete task
       Future deleteTask(String id)async{
         return  await FirebaseFirestore.instance.collection('tasks').doc(id).delete();
       }




      



}