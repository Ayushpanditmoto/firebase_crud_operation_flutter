// ignore_for_file: file_names
import 'package:flutter/material.dart';

class NotesProvider extends ChangeNotifier {
  final List<String> _notes = [];
  List<String> get notes => _notes;

  void add(String note) {
    _notes.add(note);
    notifyListeners();
  }

  void remove(String note) {
    _notes.remove(note);
    notifyListeners();
  }
}
