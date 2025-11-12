# Afri Notes

A lightweight, cross-platform Flutter notes application, BLoC state management, theming and local persistence with Shared Preferences. The app provides simple CRUD for notes, color-coded note cards, search, and a theme toggle (light/dark).

## Key features

- Create, read, update and delete notes
- Color selection for note cards
- Swipe to delete
- Local persistence using `shared_preferences`
- Search notes (live filtering)
- App-wide theming with a Theme BLoC (light & dark)
- Built with Flutter and the BLoC pattern
- Users can edit card colors, note headers and note texts

## Project structure (high level)

- `lib/`
  - `core/` — app themes, colors, font sizes
  - `features/notes/` — notes feature folders (data, domain, presentation)
    - `data/` — models, data sources (uses Shared Preferences)
    - `presentation/` — screens, widgets and BLoC for notes UI
    - `notes_local_data_source.dart` — local persistence implementation
    - `theme_local_data_source.dart` — local persistence implementation

  - `main.dart` — app entrypoint

## Tech & dependencies

- Flutter
- Dart
- flutter_bloc — BLoC state management
- shared_preferences — simple key/value persistence
- google_fonts — custom fonts
- flutter_screenutil — responsive sizing
- fluter_ slidable  — for slidable note cards
- SVG assets used in UI with `flutter_svg`

## Notes about architecture and implementation

- Notes are stored locally in JSON encoded form inside Shared Preferences under the key `notes_list` (see `lib/features/notes/data/datasources/notes_local_data_source.dart`).
- The UI uses BLoC for state management: a `NotesBloc` handles loading, adding, updating, deleting and searching notes. The `ThemeBloc` toggles between light and dark themes.
- Screens of interest:
  - `lib/features/notes/presentation/screens/home_screen.dart` — main listing and search
  - `lib/features/notes/presentation/screens/add_screen.dart` — create note
  - `lib/features/notes/presentation/screens/edit_screen.dart` — edit note

## Credit

Figma Design inspiration : <https://www.figma.com/design/Ww19DvvD45kngUDZYTqaKj/Notes-App-UI--Community-?node-id=0-1&p=f&t=81UAZSTSnrz9GQBQ-0>
