import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task2/Screens/addTask.dart';
import 'package:task2/Service/db.dart';
import 'package:task2/Service/notification_service.dart';
import 'package:intl/intl.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  Stream? taskStream;

  getreload() async {
    taskStream = await DBMethod().getTask();
    setState(() {});
  }

  @override
  void initState() {
    getreload();
    super.initState();
  }

//  void scheduleNotificationForTask(DocumentSnapshot ds) {
//   bool status = ds['Status'];
//   if (!status) {
//     try {
//       DateTime? deadline = DateFormat('mm/dd/yyyy h:mm am/pm').parse(ds['Deadline']);
// // String formattedTime = DateFormat.jm().format(deadline!);
// String formattedDate = DateFormat('mm/dd/yyyy').format(deadline);
 
// print(formattedDate);

     
       
//       //  DateTime notificationTime=formattedTime as DateTime;
//          DateTime notificationTime=deadline.subtract(Duration(seconds:10));

//       if (notificationTime.isAfter(DateTime.now())) {
//         NotificationService.showNotification(
//           id: ds['Id'].hashCode,
//           title: 'Task Reminder',
//           body: 'Your task "${ds['Title']}" is due in 10 seconds.',
//           scheduledTime: notificationTime,
//         );
//       }
//     } catch (e) {
        
//       print('Error parsing deadline: $e');
//     }
//   }
// }


  Widget allTask() {
    return StreamBuilder(
        stream: taskStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
            if (snapshot.data.docs.length == 0) {
          return Center(child: Text("No tasks added. Click the + button to add a task."));
        }

          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              // scheduleNotificationForTask(ds);

              bool status = ds['Status'];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Title: ${ds['Title']}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await DBMethod().deleteTask(ds['Id']);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text('Description: ${ds['Description']}'),
                    SizedBox(height: 8.0),
                    Text('Deadline: ${ds['Deadline']}'),
                    SizedBox(height: 8.0),
                    Text('Duration: ${ds['Duration']}'),
                    SizedBox(height: 8.0),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          activeColor: Colors.green,
                          value: status,
                          onChanged: (value) async {
                            await DBMethod().updateTaskStatus(ds['Id'], value!);
                            setState(() {
                              status = value;
                            });
                          },
                        ),
                        Text(
                          '${status ? "Completed" : "Not Completed"}',
                          style: TextStyle(
                            color: status ? Colors.green : Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task List"),
      ),
      body: Column(
        children: [
          Expanded(child: allTask()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TaskAddScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
