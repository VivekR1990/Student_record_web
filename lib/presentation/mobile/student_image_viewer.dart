import 'package:flutter/material.dart';
import 'package:student_record_web/presentation/mobile/studentcard.dart';

class StudentImageViewer extends StatelessWidget {
  const StudentImageViewer({
    super.key,
    required this.widget,
  });

  final StudentCardMobile widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Stack(
        children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height - 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/student-logbook-58249.appspot.com/o/StudentImages%2F${widget.student[widget.index]['path']}?alt=media&token=114dd2fb-eeec-4883-9105-eccca3528708'),
                      fit: BoxFit.fitHeight)),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.cancel_outlined),
            color: Colors.white,
            iconSize: 40,
          )
        ],
      ),
    );
  }
}
