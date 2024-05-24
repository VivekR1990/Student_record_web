// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:student_record_web/functions/functions.dart';
import 'package:student_record_web/widgets/edit_student_form.dart';

class EditStudentDialog extends StatefulWidget {
  final DocumentSnapshot student;
  const EditStudentDialog({super.key, required this.student});

  @override
  State<EditStudentDialog> createState() => _EditStudentDialogState();
}

class _EditStudentDialogState extends State<EditStudentDialog> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _domainController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _domainController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  String imageFile = '';
  Uint8List? selectedImageInBytes;
  FilePickerResult? result;
  String modifiedUrl = '';
  String filename = '';
  String initValue = '';
  bool isImageSelected = true;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.student['name'];
    _ageController.text = widget.student['age'].toString();
    _emailController.text = widget.student['email'];
    _domainController.text = widget.student['domain'];
    initValue = widget.student['path'];
    debugPrint(initValue);
  }

  Future<void> pickImage(BuildContext context) async {
    try {
      result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png']);

      if (result != null) {
        setState(() {
          imageFile = result!.files.single.name;
          isImageSelected = true;
        });
        Uint8List? uploadfile = result!.files.single.bytes;
        filename = basename(result!.files.single.name);

        Reference storageRef = FirebaseStorage.instance.ref();
        Reference directoryReference = storageRef.child("StudentImages");
        Reference imgdirectoryReference = directoryReference.child(filename);

        try {
          final metadata = SettableMetadata(contentType: 'image/png');
          final UploadTask uploadTask =
              imgdirectoryReference.putData(uploadfile!, metadata);

          final TaskSnapshot downloadUrl = await uploadTask;
          modifiedUrl = (await downloadUrl.ref.getDownloadURL());

          setState(() {});
        } catch (e) {
          debugPrint('Error $e');
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      debugPrint('Error $e');
    }
  }

  void cancelImageSelection() {
    setState(() {
      isImageSelected = false;
      result = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = isImageSelected
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://firebasestorage.googleapis.com/v0/b/student-logbook-58249.appspot.com/o/StudentImages%2F$initValue?alt=media&token=114dd2fb-eeec-4883-9105-eccca3528708',
                height: 80,
                width: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      if (isImageSelected) {
                        await FirebaseFunctions.deleteImageFromStorage(
                            widget.student['path']);
                      }
                      setState(() {
                        isImageSelected = false;
                        imageFile = '';
                        initValue = filename;
                      });
                    },
                    icon: const Icon(Icons.cancel, color: Colors.black),
                  ),
                ],
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

    return AlertDialog(
      surfaceTintColor: Colors.cyan,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Center(child: Text('EditStudent')),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close_sharp))
        ],
      ),
      content: FormWidgetStudent(
        age: _ageController,
        domain: _domainController,
        email: _emailController,
        name: _nameController,
        imageWidget: imageWidget,
        student: widget.student,
        imageFile: imageFile,
        filename: filename,
        initValue: initValue,
      ),
    );
  }
}
