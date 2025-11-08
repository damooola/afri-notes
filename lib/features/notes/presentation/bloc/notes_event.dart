import 'package:afrifounders_notes_app/features/notes/data/models/note.dart';

abstract class NotesEvent {}

class LoadNotesEvent extends NotesEvent {}

class AddNoteEvent extends NotesEvent {
  final NoteModel note;

  AddNoteEvent(this.note);
}

class UpdateNoteEvent extends NotesEvent {
  final int index;
  final NoteModel note;

  UpdateNoteEvent({required this.index, required this.note});
}

class DeleteNoteEvent extends NotesEvent {
  final int index;

  DeleteNoteEvent(this.index);
}

class SearchNotesEvent extends NotesEvent {
  final String query;

  SearchNotesEvent(this.query);
}

class ClearSearchEvent extends NotesEvent {}