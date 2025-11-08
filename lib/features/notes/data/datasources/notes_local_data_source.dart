import 'dart:convert';
import 'dart:developer';
import 'package:afrifounders_notes_app/features/notes/data/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesLocalDataSource {
  static const String _notesKey = 'notes_list';
  final SharedPreferences _prefs;

  NotesLocalDataSource(this._prefs);

  Future<bool> saveNotes(List<NoteModel> notes) async {
    try {
      final notesJson = notes.map((note) => note.toJson()).toList();
      final jsonString = json.encode(notesJson);
      return await _prefs.setString(_notesKey, jsonString);
    } catch (e) {
      return false;
    }
  }

  List<NoteModel> getNotes() {
    try {
      final jsonString = _prefs.getString(_notesKey);
      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final List<dynamic> notesJson = json.decode(jsonString);
      return notesJson.map((json) => NoteModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> addNote(NoteModel note) async {
    log("add notes called in sharedprefsss");
    final notes = getNotes();
    notes.add(note);
    return await saveNotes(notes);
  }

  Future<bool> updateNote(int index, NoteModel note) async {
    final notes = getNotes();
    if (index >= 0 && index < notes.length) {
      notes[index] = note;
      return await saveNotes(notes);
    }
    return false;
  }

  Future<bool> deleteNote(int index) async {
    final notes = getNotes();
    if (index >= 0 && index < notes.length) {
      notes.removeAt(index);
      return await saveNotes(notes);
    }
    return false;
  }

  Future<bool> clearAllNotes() async {
    return await _prefs.remove(_notesKey);
  }
}
