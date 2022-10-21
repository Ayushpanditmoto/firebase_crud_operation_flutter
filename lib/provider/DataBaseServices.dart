// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addNote(String topic, String note) async {
    await _firestore
        .collection('notes')
        .add({
          'topic': topic,
          'note': note,
        })
        .whenComplete(() => debugPrint('Note added'))
        .catchError((e) {
          debugPrint(e.toString());
        });
    notifyListeners();
  }

  Future<void> deleteNote(String id) async {
    await _firestore
        .collection('notes')
        .doc(id)
        .delete()
        .whenComplete(() => debugPrint('Note deleted'))
        .catchError((e) {
      debugPrint(e.toString());
    });
    notifyListeners();
  }

  Future<void> updateNote(String id, String topic, String note) async {
    await _firestore
        .collection('notes')
        .doc(id)
        .update({
          'topic': topic,
          'note': note,
        })
        .whenComplete(() => debugPrint('Note updated'))
        .catchError((e) {
          debugPrint(e.toString());
        });
    notifyListeners();
  }

  Stream<QuerySnapshot> getNotes() {
    return _firestore.collection('notes').snapshots();
  }
}
