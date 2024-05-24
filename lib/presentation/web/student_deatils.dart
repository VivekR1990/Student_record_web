import 'package:flutter/material.dart';
import 'package:student_record_web/widgets/Web/content_details_box.dart';

class StudentDetailDialog extends StatefulWidget {
  final List<Map<String, dynamic>> student;
  final int index;
  const StudentDetailDialog(
      {super.key, required this.student, required this.index});

  @override
  State<StudentDetailDialog> createState() => _StudentDetailDialogState();
}

class _StudentDetailDialogState extends State<StudentDetailDialog> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final thisItem = widget.student[widget.index];
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('More Details'),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.cancel_outlined),
              color: Colors.black,
              iconSize: 40,
            )
          ],
        ),
        content: ContentDetailsBox(
          thisItem: thisItem,
          size: size,
        ));
  }
}
