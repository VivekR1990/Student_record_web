import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_record_web/presentation/web/student_deatils.dart';
import 'package:student_record_web/widgets/Web/delete_edit_widget.dart';
import 'package:student_record_web/widgets/Web/student_image.dart';

class StudentCard extends StatefulWidget {
  final List<Map<String, dynamic>> student;
  final int index;
  final DocumentSnapshot document;
  const StudentCard(
      {super.key,
      required this.student,
      required this.index,
      required this.document});

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final thisItem = widget.student[widget.index];
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: GestureDetector(
        onTap: () => showDialog(
          context: context,
          builder: (context) =>
              StudentDetailDialog(student: widget.student, index: widget.index),
        ),
        child: Card(
          elevation: 15.0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: ImageBuilderWidget(
                            thisItem: thisItem,
                            size: size,
                          ),
                        ),
                        Text(
                          ' Name : ${thisItem['name']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Age : ${thisItem['age'].toString()}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DeleteEditWidget(widget: widget)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
