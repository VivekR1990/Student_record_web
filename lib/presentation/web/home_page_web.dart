import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_record_web/functions/functions.dart';
import 'package:student_record_web/widgets/Web/nav_bar.dart';
import 'package:student_record_web/widgets/Web/student_card.dart';

class HomePageScreenWeb extends StatefulWidget {
  final String title;
  const HomePageScreenWeb({super.key, required this.title});

  @override
  State<HomePageScreenWeb> createState() => _HomePageScreenWebState();
}

class _HomePageScreenWebState extends State<HomePageScreenWeb> {
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(66),
          child: NavBarWeb(
            title: widget.title,
            context: context,
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/white.png'),
                      fit: BoxFit.cover)),
            ),
            StreamBuilder(
              stream: FirebaseFunctions.readStudent(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                } else if (snapshot.hasData || snapshot.data != null) {
                  return GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
                      itemBuilder: (context, index) {
                        final List<QueryDocumentSnapshot> student =
                            snapshot.data!.docs;
                        final List<Map<String, dynamic>> items = student
                            .map(
                              (e) => e.data() as Map<String, dynamic>,
                            )
                            .toList();
                        final DocumentSnapshot document =
                            snapshot.data!.docs[index];
                        return StudentCard(
                          student: items,
                          index: index,
                          document: document,
                        );
                      });
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                      child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Please refresh the page if doesnt load !'),
                        CircularProgressIndicator()
                      ],
                    ),
                  ));
                }
                return const SizedBox();
              },
            ),
          ],
        ));
  }
}
