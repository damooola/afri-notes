import 'package:afrifounders_notes_app/features/notes/data/datasources/theme_local_data_souce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:afrifounders_notes_app/core/theme/bloc/theme_event.dart';
import 'package:afrifounders_notes_app/core/theme/bloc/theme_state.dart';
import 'package:afrifounders_notes_app/core/theme/theme.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeLocalDataSource themeLocalDataSource;

  ThemeBloc(this.themeLocalDataSource)
      : super(
          ThemeState(
            themeData: lightTheme,
            isDark: false,
          ),
        ) {
    on<LoadThemeEvent>((event, emit) {
      emit(
        ThemeState(
          themeData: event.isDark ? darkTheme : lightTheme,
          isDark: event.isDark,
        ),
      );
    });

    on<ToggleThemeEvent>((event, emit) async {
      final newIsDark = !state.isDark;
      await themeLocalDataSource.saveTheme(newIsDark);
      emit(
        ThemeState(
          themeData: newIsDark ? darkTheme : lightTheme,
          isDark: newIsDark,
        ),
      );
    });

    Future.microtask(() {
      final savedIsDark = themeLocalDataSource.loadTheme();
      add(LoadThemeEvent(savedIsDark));
    });
  }
}
