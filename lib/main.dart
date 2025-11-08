import 'package:afrifounders_notes_app/core/theme/bloc/theme_bloc.dart';
import 'package:afrifounders_notes_app/core/theme/bloc/theme_state.dart';
import 'package:afrifounders_notes_app/features/notes/data/datasources/notes_local_data_source.dart';
import 'package:afrifounders_notes_app/features/notes/data/datasources/theme_local_data_souce.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  final sharedPreferences = await SharedPreferences.getInstance();
  final notesLocalDataSource = NotesLocalDataSource(sharedPreferences);
  final themeLocalDataSource = ThemeLocalDataSource(sharedPreferences);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc(themeLocalDataSource)),
        BlocProvider<NotesBloc>(
          create: (context) => NotesBloc(notesLocalDataSource),
        ),
      ],
      child: const AfriFoundersNotesApp(),
    ),
  );
}

class AfriFoundersNotesApp extends StatelessWidget {
  const AfriFoundersNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      splitScreenMode: false,
      minTextAdapt: true,
      builder: (context, child) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: child,
              theme: state.themeData,
            );
          },
        );
      },
      child: HomeScreen(),
    );
  }
}
