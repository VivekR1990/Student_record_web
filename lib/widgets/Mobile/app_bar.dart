import 'package:flutter/material.dart';
import 'package:student_record_web/presentation/add_student.dart';
import 'package:student_record_web/widgets/Mobile/search_delegate_widget.dart';

class AppbarMobile extends StatelessWidget {
  final String title;
  const AppbarMobile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/texture.jpg'), fit: BoxFit.cover)),
      child: AppBar(
        backgroundColor: Colors.teal.shade300,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const AddStudentDialog(),
                );
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                showGeneralDialog(
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const SearchResultsMobile();
                  },
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
    );
  }
}
