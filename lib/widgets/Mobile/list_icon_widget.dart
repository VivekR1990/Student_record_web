import 'package:flutter/material.dart';
import 'package:student_record_web/functions/functions.dart';
import 'package:student_record_web/presentation/edit_student.dart';
import 'package:student_record_web/presentation/mobile/studentcard.dart';

class ListTileActionIconWidgets extends StatelessWidget {
  const ListTileActionIconWidgets({
    super.key,
    required this.widget,
  });

  final StudentCardMobile widget;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        IconButton(
            hoverColor: Colors.blue,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => EditStudentDialog(
                  student: widget.document,
                ),
              );
            },
            icon: const Icon(Icons.edit)),
        IconButton(
            hoverColor: Colors.red,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  surfaceTintColor: Colors.cyan,
                  title: const Text('Confirm Deletion'),
                  content: const Text(
                      'Are you sure you want to delete this student?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        FirebaseFunctions.deleteStudent(
                            docId: widget.document.id);
                        FirebaseFunctions.deleteImageFromStorage(
                            widget.student[widget.index]['path']);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            width: 400,
                            content: Text('Student Removed Successfully'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        );

                        Navigator.of(context).pop();
                      },
                      child: const Text('Delete',
                          style: TextStyle(color: Colors.redAccent)),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.delete)),
      ],
    );
  }
}
