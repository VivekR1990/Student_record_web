// ignore_for_file: use_build_context_synchronously

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:student_record_web/functions/functions.dart';
import 'package:student_record_web/widgets/add_student_form.dart';

class AddStudentDialog extends StatefulWidget {
  const AddStudentDialog({super.key});

  @override
  State<AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _domainController = TextEditingController();
  final _imageController = TextEditingController();

  String imageFile = '';
  Uint8List? selectedImageInBytes;
  FilePickerResult? result;
  String modifiedUrl = '';
  String filename = '';
  bool isImageSelected = false;
  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _domainController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  String formatFileName(String filename) {
    List<String> parts = filename.split(".");
    if (parts.length > 1) {
      String nameWithoutExtension = parts.first;
      debugPrint(nameWithoutExtension);
      return nameWithoutExtension;
    } else {
      debugPrint("Invalid filename");
      return filename;
    }
  }

  bool isEmailValid(String email) {
    final emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    return emailRegExp.hasMatch(email);
  }

  Future<void> pickImage(BuildContext context) async {
    try {
      result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png']);

      if (result != null) {
        Uint8List? uploadfile = result!.files.single.bytes;
        filename = basename(result!.files.single.name);
        Reference storageRef = FirebaseStorage.instance.ref();
        Reference directoryReference = storageRef.child("StudentImages");
        Reference imgdirectoryReference = directoryReference.child(filename);

        try {
          final UploadTask uploadTask = imgdirectoryReference.putData(
            uploadfile!,
          );

          final TaskSnapshot downloadUrl = await uploadTask;

          modifiedUrl = (await downloadUrl.ref.getDownloadURL());
        } catch (e) {
          debugPrint('Error $e');
        }

        setState(() {
          imageFile = result!.files.single.name;
          isImageSelected = true;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      debugPrint('Error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = isImageSelected
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://firebasestorage.googleapis.com/v0/b/student-logbook-58249.appspot.com/o/StudentImages%2F$filename?alt=media&token=114dd2fb-eeec-4883-9105-eccca3528708',
                height: 80,
                width: 80,
              ),
              IconButton(
                onPressed: () async {
                  if (isImageSelected) {
                    await FirebaseFunctions.deleteImageFromStorage(imageFile);
                  }
                  setState(() {
                    isImageSelected = false;
                    imageFile = '';
                  });
                },
                icon: const Icon(Icons.cancel, color: Colors.black),
              ),
            ],
          )
        : SizedBox(
            height: 50,
            width: 200,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                      width: 1.5,
                      style: BorderStyle.solid,
                      color: Colors.black)),
              onPressed: () async {
                pickImage(context);
              },
              icon: const Icon(
                Icons.cloud_upload_outlined,
                color: Colors.black,
              ),
              label: const Text(
                "Upload Photo",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          );

    return AlertDialog(surfaceTintColor: Colors.cyan,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Center(child: Text('Add Student')),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close_sharp))
          ],
        ),
        content: FormAddStudentWidget(
          age: _ageController,
          domain: _domainController,
          email: _emailController,
          name: _nameController,
          imageWidget: imageWidget,
          imageFile: imageFile,
          filename: filename,
          isImageSelected: isImageSelected,
        ));
  }
}
