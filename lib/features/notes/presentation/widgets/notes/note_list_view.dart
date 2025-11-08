import 'package:afrifounders_notes_app/features/notes/data/models/note.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/widgets/notes/note_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotesListView extends StatelessWidget {
  final List<NoteModel> notes;
  final Function(NoteModel) onNoteDelete;
  final Function(NoteModel, int) onNoteEdit;
  const NotesListView({
    super.key,
    required this.notes,
    required this.onNoteDelete,
    required this.onNoteEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: notes.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final note = notes[index];
        return NoteCard(
          note: note,
          onDelete: (context) => onNoteDelete(note),
          goToEditScreen: () => onNoteEdit(note, index),
        );
      },
    );
  }
}
