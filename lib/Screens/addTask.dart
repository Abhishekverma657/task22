import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:task2/Screens/HomeScreeen.dart';
import 'package:task2/Service/db.dart';
import 'package:task2/Service/notification_service.dart';
import 'package:timezone/timezone.dart' as tz;

class TaskAddScreen extends StatefulWidget {
  @override
  _TaskAddScreenState createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  bool _status = false;
  bool _isLoading = false;
  String _selectedDuration = 'Minutes';
  List<String> _durationOptions = ['Minutes', 'Hours', 'Days'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (selectedTime != null) {
        DateTime combinedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        setState(() {
          _deadlineController.text =
             DateFormat('MM/dd/yyyy h:mm a').format(combinedDateTime);
        });
      }
    }
  }

  void _addTask() async {
    setState(() {
      _isLoading = true;
    });

    String id = randomAlphaNumeric(10);
    Map<String, dynamic> taskInfoMap = {
      "Id": id,
      "Title": _titleController.text,
      "Description": _descriptionController.text,
      "Deadline": _deadlineController.text,
      "Duration": "${_durationController.text} $_selectedDuration",
      "Status": _status,
    };
    await DBMethod().addTask(taskInfoMap, id).then(
      (value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("Task Added"),
        ));
      },
    ).then((value) {
      setState(() {
        _isLoading = false;
      });
    });
     
    
 

    _titleController.clear();
    _descriptionController.clear();
    _deadlineController.clear();
    _durationController.clear();
    _selectedDuration = 'Minutes';

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TaskScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              InkWell(
                onTap: () => _selectDate(context),
                child: IgnorePointer(
                  child: TextFormField(
                    controller: _deadlineController,
                    decoration: InputDecoration(
                      labelText: 'Deadline',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _durationController,
                      decoration: InputDecoration(
                        labelText: 'Duration',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  DropdownButton<String>(
                    value: _selectedDuration,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedDuration = newValue!;
                      });
                    },
                    items: _durationOptions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Center(
                child: InkWell(
                  onTap: () {
                    _addTask();
                  },
                  child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            )
                          : Text(
                              'Add Task',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
