import 'package:afrifounders_notes_app/core/colors/colors.dart';
import 'package:flutter/material.dart';

class NoteModel {
  final String noteHeader;
  final String noteText;
  final Color color;

  const NoteModel({
    required this.noteHeader,
    required this.noteText,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'noteHeader': noteHeader,
      'noteText': noteText,
      'color': color.toARGB32(),
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      noteHeader: json['noteHeader'] as String,
      noteText: json['noteText'] as String,
      color: Color(json['color'] as int),
    );
  }

  NoteModel copyWith({String? noteHeader, String? noteText, Color? color}) {
    return NoteModel(
      noteHeader: noteHeader ?? this.noteHeader,
      noteText: noteText ?? this.noteText,
      color: color ?? this.color,
    );
  }
}

final List<NoteModel> notes = [
  NoteModel(
    noteHeader: '📝 Quick Reminder #1',
    noteText: 'Don’t forget to submit the report by 5 PM today.',
    color: AppColors.rose,
  ),
  NoteModel(
    noteHeader: '📚 Study Tip: Focus Mode',
    noteText:
        'Use the Pomodoro technique to stay productive during long study sessions.',
    color: AppColors.green,
  ),
  NoteModel(
    noteHeader: '💡 Idea Dump',
    noteText:
        'Brainstormed concepts for the new app: swipe gestures, dark mode, and voice notes.',
    color: AppColors.yellow,
  ),
  NoteModel(
    noteHeader: 'Meeting Notes - 08/11/2025',
    noteText:
        'Discussed Q4 goals, budget allocations, and team restructuring plans.',
    color: AppColors.skyBlue,
  ),
  NoteModel(
    noteHeader: '🎯 Goals for the Week',
    noteText: '1. Finish UI mockups\n2. Review PRs\n3. Schedule client demo',
    color: AppColors.lightPurple,
  ),
  NoteModel(
    noteHeader: 'Random Thought #42',
    noteText:
        'What if we used color psychology to influence user behavior in the app?',
    color: AppColors.green,
  ),
  NoteModel(
    noteHeader: '🛠 Debug Log',
    noteText:
        'Issue with login API: returns 403 when token is refreshed. Needs investigation.',
    color: AppColors.rose,
  ),
  NoteModel(
    noteHeader: '📅 Event Planning',
    noteText:
        'Venue booked for Dec 15. Catering and AV setup pending confirmation.',
    color: AppColors.skyBlue,
  ),
  NoteModel(
    noteHeader: '✨ Inspiration Quote',
    noteText:
        '“Success is not final, failure is not fatal: It is the courage to continue that counts.”',
    color: AppColors.yellow,
  ),
  NoteModel(
    noteHeader: 'Checklist: Launch Prep',
    noteText:
        '- Finalize assets\n- QA testing\n- Marketing blast\n- App Store submission',
    color: AppColors.lightPurple,
  ),
];
