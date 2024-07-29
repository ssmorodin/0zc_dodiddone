import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_auth.dart';

class DialogWidget extends StatefulWidget {
  final String? initialTitle;
  final String? initialDescription;
  final DateTime? initialDeadline;
  final String? taskId;

  const DialogWidget({
    super.key,
    this.initialTitle,
    this.initialDescription,
    this.initialDeadline,
    this.taskId,
  });

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  final formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  String? title;
  String? description;
  String? userId;

  @override
  void initState() {
    super.initState();
    title = widget.initialTitle;
    description = widget.initialDescription;
    selectedDate = widget.initialDeadline;
    _fetchUserId();
  }

  Future<void> _fetchUserId() async {
    userId = await AuthService().getUserId();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SingleChildScrollView(
            child: AlertDialog(
              title: Text(widget.taskId != null ? 'Редактировать задачу' : 'Добавить задачу'),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 4),
                    const Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Row(
                        children: [
                          Text('Название'),
                        ],
                      ),
                    ),
                    TextFormField(
                      initialValue: widget.initialTitle,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите название задачи';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        title = value;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Row(
                        children: [
                          Text('Описание'),
                        ],
                      ),
                    ),
                    TextFormField(
                      initialValue: widget.initialDescription,
                      onSaved: (value) {
                        description = value;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Row(
                        children: [
                          Text('Дедлайн'),
                        ],
                      ),
                    ),
                    DateTimeField(
                      format: DateFormat('dd.MM.yy HH:mm'),
                      initialValue: widget.initialDeadline,
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                          context: context,
                          firstDate: DateTime(2024),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2030),
                        ).then((date) {
                          if (date != null) {
                            return showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now()),
                            ).then((time) {
                              return DateTimeField.combine(date, time);
                            });
                          }
                          return null;
                        });
                      },
                      onChanged: (DateTime? date) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Отмена'),
                ),
                TextButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (widget.taskId != null) {
                        await FirebaseFirestore.instance
                            .collection('tasks')
                            .doc(widget.taskId)
                            .update({
                          'title': title!,
                          'description': description!,
                          'deadline': selectedDate!,
                        });
                      } else {
                        await FirebaseFirestore.instance.collection('tasks').add({
                          'title': title!,
                          'description': description!,
                          'deadline': selectedDate!,
                          'completed': false,
                          'is_for_today': false,
                          'userId': userId,
                        });
                      }
                      Navigator.of(context).pop(); 
                    }
                  },
                  child: Text(widget.taskId != null ? 'Сохранить' : 'Добавить'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}