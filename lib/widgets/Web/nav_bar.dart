import 'package:flutter/material.dart';
import 'package:student_record_web/presentation/add_student.dart';
import 'package:student_record_web/widgets/Web/search_widget.dart';

TextEditingController searchController = TextEditingController();

class NavBarWeb extends StatefulWidget {
  const NavBarWeb({
    super.key,
    required this.title,
    required this.context,
  });

  final String title;
  final BuildContext context;

  @override
  State<NavBarWeb> createState() => _NavBarWebState();
}

class _NavBarWebState extends State<NavBarWeb> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(style: BorderStyle.solid, color: Colors.grey)),
      child: AppBar(
        backgroundColor: Colors.teal.shade300,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Text(
            widget.title,
            style: const TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              height: 40,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    padding: const EdgeInsets.only(left: 20, right: 20)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const AddStudentDialog(),
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: const Text(
                  'Add a student',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: IconButton(
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    barrierColor: Colors.black38,
                    barrierDismissible: true,
                    barrierLabel: 'Label',
                    pageBuilder: (_, __, ___) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          color: Colors.blue,
                          child: const SearchResults(),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.search),
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
