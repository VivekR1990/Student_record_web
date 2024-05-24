import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_record_web/presentation/mobile/student_details.dart';
import 'package:student_record_web/presentation/mobile/student_image_viewer.dart';
import 'package:student_record_web/widgets/Mobile/list_icon_widget.dart';

class StudentCardMobile extends StatefulWidget {
  final List<Map> student;
  final int index;
  final DocumentSnapshot document;
  const StudentCardMobile(
      {super.key,
      required this.student,
      required this.index,
      required this.document});

  @override
  State<StudentCardMobile> createState() => _StudentCardMobileState();
}

class _StudentCardMobileState extends State<StudentCardMobile> {
  @override
  Widget build(BuildContext context) {
    final thisItem = widget.student[widget.index];
    return Card(
      elevation: 10,
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(style: BorderStyle.solid, color: Colors.black45),
            borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          onTap: () => showDialog(
            context: context,
            builder: (context) => StudentDetailDialog(widget: widget),
          ),
          leading: GestureDetector(
            onDoubleTap: () {
              showDialog(
                context: context,
                builder: (context) => StudentImageViewer(
                  widget: widget,
                ),
              );
            },
            child: Container(
              height: 200,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/student-logbook-58249.appspot.com/o/StudentImages%2F${thisItem['path']}?alt=media&token=114dd2fb-eeec-4883-9105-eccca3528708',
                      ),
                      fit: BoxFit.cover)),
            ),
          ),
          title: Text(
            'Name : ${thisItem['name']}',
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            'Age : ${thisItem['age'].toString()}',
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          trailing: ListTileActionIconWidgets(
            widget: widget,
          ),
        ),
      ),
    );
  }
}
