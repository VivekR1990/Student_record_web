import 'package:flutter/material.dart';
import 'package:student_record_web/presentation/mobile/studentcard.dart';

class StudentDetailDialog extends StatelessWidget {
  const StudentDetailDialog({
    super.key,
    required this.widget,
  });

  final StudentCardMobile widget;

  @override
  Widget build(BuildContext context) {
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
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/student-logbook-58249.appspot.com/o/StudentImages%2F${widget.student[widget.index]['path']}?alt=media&token=114dd2fb-eeec-4883-9105-eccca3528708'),
                )),
          ),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Name : ${widget.student[widget.index]['name']}",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Age : ${widget.student[widget.index]['age']}",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Email : ${widget.student[widget.index]['email']}",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Batch : ${widget.student[widget.index]['domain']}",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
