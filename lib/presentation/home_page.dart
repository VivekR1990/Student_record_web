import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:student_record_web/presentation/mobile/homepage.dart';
import 'package:student_record_web/presentation/web/home_page_web.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key, required this.title});

  final String title;

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
        desktop: (p0) => const HomePageScreenWeb(title: 'Student Log Book'),
        mobile: (p0) => const HomePageScreenMobile(title: 'Student Log Book'));
  }
}
