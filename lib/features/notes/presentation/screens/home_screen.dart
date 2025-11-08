
import 'package:afrifounders_notes_app/core/theme/bloc/theme_bloc.dart';
import 'package:afrifounders_notes_app/core/theme/bloc/theme_event.dart';
import 'package:afrifounders_notes_app/core/theme/bloc/theme_state.dart';
import 'package:afrifounders_notes_app/features/notes/data/models/note.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/bloc/notes_event.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/bloc/notes_state.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/screens/add_screen.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/screens/edit_screen.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/widgets/button_icon.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/widgets/floating_action_button/floating_action_button.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/widgets/notes/note_list_view.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/widgets/search_field.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/widgets/states/empty_no_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  bool showSearchField = false;

  @override
  void initState() {
    super.initState();
    context.read<NotesBloc>().add(LoadNotesEvent());
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = searchController.text;
    context.read<NotesBloc>().add(SearchNotesEvent(query));
  }

  void onOpenSearch() {
    setState(() {
      showSearchField = true;
    });
  }

  void onCloseSearch() {
    setState(() {
      showSearchField = false;
    });
    searchController.clear();
    context.read<NotesBloc>().add(ClearSearchEvent());
  }

  Future<void> goToAddScreen() async {
    final newNote = await Navigator.push<NoteModel>(
      context,
      MaterialPageRoute(builder: (context) => const AddScreen()),
    );

    if (newNote != null && mounted) {
      context.read<NotesBloc>().add(AddNoteEvent(newNote));
    }
  }

  Future<void> goToEditScreen(NoteModel note, int displayIndex) async {
    final state = context.read<NotesBloc>().state;
    if (state is! NotesLoaded) return;

    final actualIndex = state.notes.indexOf(note);
    if (actualIndex == -1) return;

    final updatedNote = await Navigator.push<NoteModel>(
      context,
      MaterialPageRoute(builder: (context) => EditScreen(note: note)),
    );

    if (updatedNote != null && mounted) {
      context.read<NotesBloc>().add(
        UpdateNoteEvent(index: actualIndex, note: updatedNote),
      );
    }
  }

  void deleteNote(NoteModel note) {
    final state = context.read<NotesBloc>().state;

    if (state is! NotesLoaded) return;

    final actualIndex = state.notes.indexOf(note);

    if (actualIndex == -1) return;

    context.read<NotesBloc>().add(DeleteNoteEvent(actualIndex));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          top: 65.h,
          bottom: 32.h,
        ),
        child: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, notesState) {
            final bool isSearching =
                notesState is NotesLoaded && notesState.isSearching;
            final bool noResults =
                notesState is NotesLoaded &&
                isSearching &&
                notesState.filteredNotes.isEmpty &&
                searchController.text.isNotEmpty;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !showSearchField
                    ?
                    // Header
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Notes",
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          BlocBuilder<ThemeBloc, ThemeState>(
                            builder: (context, state) {
                              return Row(
                                spacing: 16.w,
                                children: [
                                  ButtonIcon(
                                    iconPath: "assets/search.svg",
                                    onTap: onOpenSearch,
                                  ),
                                  ButtonIcon(
                                    iconPath:
                                        state.isDark
                                            ? "assets/sunlight.svg"
                                            : "assets/moon.svg",
                                    onTap: () {
                                      context.read<ThemeBloc>().add(
                                        ToggleThemeEvent(),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    )
                    :
                    // Search field
                    SearchField(
                      searchController: searchController,
                      onCloseSearch: onCloseSearch,
                    ),

                Expanded(child: _buildNotesContent(notesState, noResults)),
              ],
            );
          },
        ),
      ),
      floatingActionButton: ButtonFloatingAction(onTap: goToAddScreen),
    );
  }

  Widget _buildNotesContent(NotesState state, bool noResults) {
    if (state is NotesLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is NotesError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: ${state.message}',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () => context.read<NotesBloc>().add(LoadNotesEvent()),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is NotesLoaded) {
      if (state.notes.isEmpty) {
        return const EmptyNoResult(state: NoResultEmpty.empty);
      }

      if (noResults) {
        return const EmptyNoResult(state: NoResultEmpty.noResult);
      }

      return NotesListView(
        notes: state.filteredNotes,
        onNoteDelete: (note) => deleteNote(note),
        onNoteEdit: goToEditScreen,
      );
    }

    return const SizedBox.shrink();
  }
}
