import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeData themeData;
  final bool isDark;

  const ThemeState({
    required this.themeData,
    required this.isDark,
  });

  ThemeState copyWith({
    ThemeData? themeData,
    bool? isDark,
  }) {
    return ThemeState(
      themeData: themeData ?? this.themeData,
      isDark: isDark ?? this.isDark,
    );
  }

  @override
  List<Object> get props => [themeData, isDark];
}
