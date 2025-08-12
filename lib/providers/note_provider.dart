import 'package:flutter/material.dart';
import '../models/note.dart';
import '../db/note_database.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> _notes = [];
  bool _isLoading = false;

  List<Note> get notes => _notes;
  bool get isLoading => _isLoading;

  Future<void> loadNotes() async {
    _isLoading = true;
    notifyListeners();
    _notes = await NoteDatabase.instance.readAllNotes();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await NoteDatabase.instance.create(note);
    await loadNotes();
  }

  Future<void> updateNote(Note note) async {
    await NoteDatabase.instance.update(note);
    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await NoteDatabase.instance.delete(id);
    await loadNotes();
  }
}
