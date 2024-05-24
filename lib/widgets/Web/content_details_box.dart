import 'package:flutter/material.dart';
import 'package:student_record_web/widgets/Web/text_deatisl_widget.dart';

class ContentDetailsBox extends StatefulWidget {
  final Map<dynamic, dynamic> thisItem;
  final Size size;
  const ContentDetailsBox(
      {super.key, required this.thisItem, required this.size});

  @override
  State<ContentDetailsBox> createState() => _ContentDetailsBoxState();
}

class _ContentDetailsBoxState extends State<ContentDetailsBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 500,
              width: 750,
              child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/student-logbook-58249.appspot.com/o/StudentImages%2F${widget.thisItem['path']}?alt=media&token=114dd2fb-eeec-4883-9105-eccca3528708'),
            ),
          ),
          TextDetailsWidget(thisItem: widget.thisItem),
        ],
      ),
    );
  }
}
