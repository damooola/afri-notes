import 'package:afrifounders_notes_app/features/notes/data/datasources/notes_local_data_source.dart';
import 'package:afrifounders_notes_app/features/notes/data/models/note.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/bloc/notes_event.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/bloc/notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesLocalDataSource _localDataSource;

  NotesBloc(this._localDataSource) : super(const NotesInitial()) {
    on<LoadNotesEvent>(_onLoadNotes);
    on<AddNoteEvent>(_onAddNote);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<DeleteNoteEvent>(_onDeleteNote);
    on<SearchNotesEvent>(_onSearchNotes);
    on<ClearSearchEvent>(_onClearSearch);
  }

  Future<void> _onLoadNotes(
    LoadNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(const NotesLoading());
    try {
      final notes = _localDataSource.getNotes();
      emit(NotesLoaded(notes: notes, filteredNotes: notes, isSearching: false));
    } catch (e) {
      emit(
        NotesError(
          message: 'Failed to load notes: $e',
          notes: const [],
          filteredNotes: const [],
          isSearching: false,
        ),
      );
    }
  }

  Future<void> _onAddNote(AddNoteEvent event, Emitter<NotesState> emit) async {
    if (state is NotesLoaded) {
      final currentState = state as NotesLoaded;
      try {
        final updatedNotes = List<NoteModel>.from(currentState.notes)
          ..add(event.note);

        final success = await _localDataSource.saveNotes(updatedNotes);

        if (success) {
          emit(
            currentState.copyWith(
              notes: updatedNotes,
              filteredNotes:
                  currentState.isSearching
                      ? currentState.filteredNotes
                      : updatedNotes,
            ),
          );
        } else {
          emit(
            NotesError(
              message: 'Failed to save note',
              notes: currentState.notes,
              filteredNotes: currentState.filteredNotes,
              isSearching: currentState.isSearching,
            ),
          );
        }
      } catch (e) {
        emit(
          NotesError(
            message: 'Failed to add note: $e',
            notes: currentState.notes,
            filteredNotes: currentState.filteredNotes,
            isSearching: currentState.isSearching,
          ),
        );
      }
    }
  }

  Future<void> _onUpdateNote(
    UpdateNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    if (state is NotesLoaded) {
      final currentState = state as NotesLoaded;
      try {
        final updatedNotes = List<NoteModel>.from(currentState.notes);

        if (event.index >= 0 && event.index < updatedNotes.length) {
          updatedNotes[event.index] = event.note;

          final success = await _localDataSource.saveNotes(updatedNotes);

          if (success) {
            List<NoteModel> updatedFilteredNotes;
            if (currentState.isSearching) {
              updatedFilteredNotes = updatedNotes;

              updatedFilteredNotes = List<NoteModel>.from(
                currentState.filteredNotes,
              );
              final filteredIndex = updatedFilteredNotes.indexWhere(
                (note) => currentState.notes.indexOf(note) == event.index,
              );
              if (filteredIndex != -1) {
                updatedFilteredNotes[filteredIndex] = event.note;
              }
            } else {
              updatedFilteredNotes = updatedNotes;
            }

            emit(
              currentState.copyWith(
                notes: updatedNotes,
                filteredNotes: updatedFilteredNotes,
              ),
            );
          } else {
            emit(
              NotesError(
                message: 'Failed to save updated note',
                notes: currentState.notes,
                filteredNotes: currentState.filteredNotes,
                isSearching: currentState.isSearching,
              ),
            );
          }
        }
      } catch (e) {
        emit(
          NotesError(
            message: 'Failed to update note: $e',
            notes: currentState.notes,
            filteredNotes: currentState.filteredNotes,
            isSearching: currentState.isSearching,
          ),
        );
      }
    }
  }

  Future<void> _onDeleteNote(
    DeleteNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    if (state is NotesLoaded) {
      final currentState = state as NotesLoaded;
      try {
        if (event.index < 0 || event.index >= currentState.notes.length) {
          emit(
            NotesError(
              message: 'Invalid note index',
              notes: currentState.notes,
              filteredNotes: currentState.filteredNotes,
              isSearching: currentState.isSearching,
            ),
          );
          return;
        }

        final noteToRemove = currentState.notes[event.index];

        final updatedNotes = List<NoteModel>.from(currentState.notes)
          ..removeAt(event.index);

        final success = await _localDataSource.saveNotes(updatedNotes);

        if (success) {
          List<NoteModel> updatedFilteredNotes;
          if (currentState.isSearching) {
            updatedFilteredNotes = List<NoteModel>.from(
              currentState.filteredNotes,
            );
            updatedFilteredNotes.remove(noteToRemove);
          } else {
            updatedFilteredNotes = updatedNotes;
          }

          emit(
            currentState.copyWith(
              notes: updatedNotes,
              filteredNotes: updatedFilteredNotes,
            ),
          );
        } else {
          emit(
            NotesError(
              message: 'Failed to delete note',
              notes: currentState.notes,
              filteredNotes: currentState.filteredNotes,
              isSearching: currentState.isSearching,
            ),
          );
        }
      } catch (e) {
        emit(
          NotesError(
            message: 'Failed to delete note: $e',
            notes: currentState.notes,
            filteredNotes: currentState.filteredNotes,
            isSearching: currentState.isSearching,
          ),
        );
      }
    }
  }

  void _onSearchNotes(SearchNotesEvent event, Emitter<NotesState> emit) {
    if (state is NotesLoaded) {
      final currentState = state as NotesLoaded;
      final query = event.query.trim().toLowerCase();

      if (query.isEmpty) {
        emit(
          currentState.copyWith(
            filteredNotes: currentState.notes,
            isSearching: false,
          ),
        );
        return;
      }

      final filteredNotes =
          currentState.notes.where((note) {
            final headerMatch = note.noteHeader.toLowerCase().contains(query);
            final textMatch = note.noteText.toLowerCase().contains(query);
            return headerMatch || textMatch;
          }).toList();

      emit(
        currentState.copyWith(filteredNotes: filteredNotes, isSearching: true),
      );
    }
  }

  void _onClearSearch(ClearSearchEvent event, Emitter<NotesState> emit) {
    if (state is NotesLoaded) {
      final currentState = state as NotesLoaded;
      emit(
        currentState.copyWith(
          filteredNotes: currentState.notes,
          isSearching: false,
        ),
      );
    }
  }
}
