import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final CollectionReference student =
    FirebaseFirestore.instance.collection('students');

class FirebaseFunctions {
  static String? userId;

  static void addStudent({
    required String name,
    required int age,
    required String email,
    required String domain,
    required String path,
  }) {
    Map<String, dynamic> data = {
      "name": name,
      "age": age,
      "email": email,
      "domain": domain,
      "path": path,
    };

    student
        .add(data)
        .whenComplete(() => debugPrint(" Student added to databse"));
  }

  static Future<void> updateStudent(
      {required String name,
      required int age,
      required String email,
      required String domain,
      required String path,
      required String docId}) async {
    Map<String, dynamic> data = {
      "name": name,
      "age": age,
      "email": email,
      "domain": domain,
      "path": path
    };
    student.doc(docId).update(data);
  }

  static Stream<QuerySnapshot> readStudent() {
    return student.snapshots();
  }

  static Future<void> deleteStudent({required String docId}) async {
    DocumentReference reference = student.doc(docId);
    await reference
        .delete()
        .whenComplete(() => debugPrint(" Student deleted in databse"))
        .catchError((e) => debugPrint("Error occured $e"));
  }

  static String downloadURL = '';

  static Future getImage(String filename) async {
    try {
      await downloadURLExample(filename);
      return downloadURL;
    } catch (e) {
      debugPrint('Error $e');
      return null;
    }
  }

  static Future<void> downloadURLExample(String filename) async {
    downloadURL = await FirebaseStorage.instance
        .ref()
        .child('StudentImages')
        .child(filename)
        .getDownloadURL();

    debugPrint(downloadURL.toString());
  }

  static Future<void> deleteImageFromStorage(String imagePath) async {
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('StudentImages').child(imagePath);

    try {
      await storageRef.delete();
      debugPrint('Image deleted from Firebase Storage');
    } catch (e) {
      debugPrint('Error deleting image from Firebase Storage: $e');
    }
  }
}
