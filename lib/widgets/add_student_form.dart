import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_record_web/functions/functions.dart';

class FormAddStudentWidget extends StatelessWidget {
  final TextEditingController name, age, email, domain;
  final Widget imageWidget;
  final String imageFile, filename;
  final bool isImageSelected;
  const FormAddStudentWidget(
      {super.key,
      required this.name,
      required this.age,
      required this.email,
      required this.domain,
      required this.imageWidget,
      required this.imageFile,
      required this.filename,
      required this.isImageSelected});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    bool isEmailValid(String email) {
      final emailRegExp = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

      return emailRegExp.hasMatch(email);
    }

    return SizedBox(
      width: 800.0,
      height: 500.0,
      child: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green.shade800, width: 2.0),
                      ),
                      labelText: 'Name',
                      border: const OutlineInputBorder()),
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
                  controller: age,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green.shade800, width: 2.0),
                      ),
                      labelText: 'Age',
                      border: const OutlineInputBorder()),
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
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green.shade800, width: 2.0),
                      ),
                      labelText: 'Email',
                      border: const OutlineInputBorder()),
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
                  controller: domain,
                  decoration: InputDecoration(
                      labelText: 'Batch',
                      focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      border: const OutlineInputBorder(),
                      hoverColor: Colors.blue,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green.shade800, width: 2.0),
                      ),
                      labelStyle: const TextStyle(color: Colors.black)),
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
                imageWidget,
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 800,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (!isImageSelected) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(left: 100.0),
                              content: Text('Please select an image.'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          );
                          return;
                        }
                        FirebaseFunctions.addStudent(
                          name: name.text,
                          age: int.parse(age.text),
                          email: email.text,
                          domain: domain.text,
                          path: filename,
                        );
                        Navigator.of(context).pop();
                      }
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
