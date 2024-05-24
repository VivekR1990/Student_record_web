import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_record_web/functions/functions.dart';
import 'package:student_record_web/presentation/mobile/studentcard.dart';
import 'package:student_record_web/widgets/Mobile/app_bar.dart';

class HomePageScreenMobile extends StatefulWidget {
  const HomePageScreenMobile({super.key, required this.title});

  final String title;

  @override
  State<HomePageScreenMobile> createState() => _HomePageScreenMobileState();
}

class _HomePageScreenMobileState extends State<HomePageScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(65),
            child: AppbarMobile(
              title: widget.title,
            )),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/white.png'),
                      fit: BoxFit.cover)),
            ),
            StreamBuilder(
              stream: FirebaseFunctions.readStudent(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                } else if (snapshot.hasData || snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final List<QueryDocumentSnapshot> student =
                          snapshot.data!.docs;
                      final List<Map> items = student
                          .map(
                            (e) => e.data() as Map,
                          )
                          .toList();
                      final DocumentSnapshot document =
                          snapshot.data!.docs[index];

                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StudentCardMobile(
                            document: document,
                            student: items,
                            index: index,
                          ));
                    },
                  );
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
