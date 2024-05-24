import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_record_web/functions/functions.dart';

class FormWidgetStudent extends StatefulWidget {
  final TextEditingController name, age, email, domain;
  final Widget imageWidget;
  final DocumentSnapshot student;
  final String imageFile, initValue, filename;

  const FormWidgetStudent({
    super.key,
    required this.name,
    required this.age,
    required this.email,
    required this.domain,
    required this.imageWidget,
    required this.student,
    required this.imageFile,
    required this.initValue,
    required this.filename,
  });

  @override
  State<FormWidgetStudent> createState() => _FormWidgetStudentState();
}

class _FormWidgetStudentState extends State<FormWidgetStudent> {
  final _formKey = GlobalKey<FormState>();
  bool isEmailValid(String email) {
    final emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    return emailRegExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800.0,
      height: 500.0,
      child: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  controller: widget.name,
                  decoration: const InputDecoration(
                      labelText: 'Name', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  controller: widget.age,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Age', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an age';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: widget.email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: 'Email', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!isEmailValid(value)) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: widget.domain,
                  decoration: const InputDecoration(
                      labelText: 'Batch',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.black)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your batch';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                widget.imageWidget,
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 800,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                      FirebaseFunctions.updateStudent(
                          name: widget.name.text,
                          age: int.parse(widget.age.text),
                          email: widget.email.text,
                          domain: widget.domain.text,
                          docId: widget.student.id,
                          path: widget.imageFile.isEmpty
                              ? widget.initValue
                              : widget.filename);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
