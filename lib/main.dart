import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
void main() {
  runApp(const MyApp());
}

class Task {
  final String description;
  final String  startDate;
  final String  startTime;
  final String  endDate;
  final String  endTime;
  Task({required this.description, required this.startDate, required this.startTime, required this.endDate, required this.endTime});

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<Task> _tasks = [];
  TextEditingController _descriptionController = TextEditingController();


  @override
  void dispose() {
    _descriptionController.dispose();

    super.dispose();
  }

  DateTime? _selectedStartDate;
  DateTime? _selectedStartTime;
  DateTime? _selectedEndDate;
  DateTime? _selectedEndTime;

  void _selectDate() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2021, 1, 1),
      maxTime: DateTime(2030, 12, 31),
      onConfirm: (date) {
        setState(() {
          _selectedStartDate = date;
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  void _selectTime() {
    DatePicker.showTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (time) {
        setState(() {
          _selectedStartTime = time;
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  void selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021, 1, 1),
      lastDate: DateTime(2030, 12, 31),
    );
    if (pickedDate != null && pickedDate != _selectedStartDate) {
      setState(() {
        _selectedStartDate = pickedDate;
      });
    }
  }

  void selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (pickedTime != null && pickedTime != _selectedStartTime) {
      setState(() {
        _selectedStartTime = DateTime(
          _selectedStartDate!.year,
          _selectedStartDate!.month,
          _selectedStartDate!.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  void SelectDate() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2021, 1, 1),
      maxTime: DateTime(2030, 12, 31),
      onConfirm: (date) {
        setState(() {
          _selectedEndDate = date;
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  void SelectTime() {
    DatePicker.showTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (time) {
        setState(() {
          _selectedEndTime = time;
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  void select_Date() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021, 1, 1),
      lastDate: DateTime(2030, 12, 31),
    );
    if (pickedDate != null && pickedDate != _selectedEndDate) {
      setState(() {
        _selectedEndDate = pickedDate;
      });
    }
  }

  void select_Time() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (pickedTime != null && pickedTime != _selectedEndTime) {
      setState(() {
        _selectedEndTime = DateTime(
          _selectedEndDate!.year,
          _selectedEndDate!.month,
          _selectedEndDate!.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  void _addTask() {
    setState(() {
      _tasks.add(Task(
        description: _descriptionController.text,
        startDate: _selectedStartDate.toString(),
        startTime: _selectedStartTime.toString(),
        endDate: _selectedEndDate.toString(),
        endTime: _selectedEndTime.toString(),
      ));
    });
    _descriptionController.clear();
    _selectedStartDate = null;
    _selectedStartTime = null;
    _selectedEndDate = null;
    _selectedEndTime = null;
  }

  void _removeTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),

      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_tasks[index].description),

                      Text('Start Time:  ${_tasks[index].startTime}'),
                      Text('End Time: ${_tasks[index].endTime}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeTask(_tasks[index]),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              children: [
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Enter task description',hintStyle: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  ),
                ),

                TextFormField(
                  readOnly: true,
                  onTap: selectDate,
                  controller: TextEditingController(
                    text: _selectedStartDate == null ? '' : DateFormat.yMd().format(_selectedStartDate!),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Ngày bắt đầu',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today_rounded),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  onTap: selectTime,
                  controller: TextEditingController(
                    text: _selectedStartTime == null ? '' : DateFormat.Hm().format(_selectedStartTime!),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Giờ bắt đầu',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.access_time_rounded),
                  ),
                ),
                TextFormField(
                  readOnly: true,
                  onTap: select_Date,
                  controller: TextEditingController(
                    text: _selectedEndDate == null ? '' : DateFormat.yMd().format(_selectedEndDate!),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Ngày kết thúc',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today_rounded),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  onTap: select_Time,
                  controller: TextEditingController(
                    text: _selectedEndTime == null ? '' : DateFormat.Hm().format(_selectedEndTime!),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Giờ kết thúc',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.access_time_rounded),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Add Task'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}