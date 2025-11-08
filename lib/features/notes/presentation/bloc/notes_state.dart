import 'package:afrifounders_notes_app/features/notes/data/models/note.dart';

abstract class NotesState {
  final List<NoteModel> notes;
  final List<NoteModel> filteredNotes;
  final bool isSearching;

  const NotesState({
    required this.notes,
    required this.filteredNotes,
    required this.isSearching,
  });
}

class NotesInitial extends NotesState {
  const NotesInitial()
      : super(
          notes: const [],
          filteredNotes: const [],
          isSearching: false,
        );
}

class NotesLoading extends NotesState {
  const NotesLoading()
      : super(
          notes: const [],
          filteredNotes: const [],
          isSearching: false,
        );
}

class NotesLoaded extends NotesState {
  const NotesLoaded({
    required super.notes,
    required super.filteredNotes,
    required super.isSearching,
  });

  NotesLoaded copyWith({
    List<NoteModel>? notes,
    List<NoteModel>? filteredNotes,
    bool? isSearching,
  }) {
    return NotesLoaded(
      notes: notes ?? this.notes,
      filteredNotes: filteredNotes ?? this.filteredNotes,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}

class NotesError extends NotesState {
  final String message;

  const NotesError({
    required this.message,
    required super.notes,
    required super.filteredNotes,
    required super.isSearching,
  });
}