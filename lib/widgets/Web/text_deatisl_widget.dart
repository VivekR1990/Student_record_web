import 'package:flutter/material.dart';

class TextDetailsWidget extends StatelessWidget {
  const TextDetailsWidget({
    super.key,
    required this.thisItem,
  });

  final Map thisItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 400,
            decoration: BoxDecoration(
                border: Border.all(style: BorderStyle.solid, width: 1.5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Name : ${thisItem['name']}",
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: 400,
            decoration: BoxDecoration(
                border: Border.all(style: BorderStyle.solid, width: 1.5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Age : ${thisItem['age']}",
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: 400,
            decoration: BoxDecoration(
                border: Border.all(style: BorderStyle.solid, width: 1.5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Email : ${thisItem['email']}",
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: 400,
            decoration: BoxDecoration(
                border: Border.all(style: BorderStyle.solid, width: 1.5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Batch : ${thisItem['domain']}",
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
