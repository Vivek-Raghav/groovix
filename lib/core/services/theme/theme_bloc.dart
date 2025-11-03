// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:groovix/core/constants/pref_keys.dart';
import 'package:groovix/core/local_db/local_cache.dart';
import 'package:groovix/injection_container/injection_initializer.dart';

// Events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class LoadThemeEvent extends ThemeEvent {
  const LoadThemeEvent();
}

class SetThemeModeEvent extends ThemeEvent {
  final ThemeMode themeMode;
  const SetThemeModeEvent(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

class ToggleThemeEvent extends ThemeEvent {
  const ToggleThemeEvent();
}

// State
class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({
    required this.themeMode,
  });

  ThemeState copyWith({
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [themeMode];

  bool get isDarkMode => themeMode == ThemeMode.dark;
  bool get isLightMode => themeMode == ThemeMode.light;
  bool get isSystemMode => themeMode == ThemeMode.system;

  String get themeModeDisplayName {
    switch (themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  IconData get themeModeIcon {
    switch (themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }
}

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final LocalCache _cache = getIt<LocalCache>();

  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.light)) {
    on<LoadThemeEvent>(_onLoadTheme);
    on<SetThemeModeEvent>(_onSetThemeMode);
    on<ToggleThemeEvent>(_onToggleTheme);
    // Load theme on initialization
    add(const LoadThemeEvent());
  }

  Future<void> _onLoadTheme(
    LoadThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final savedTheme = _cache.getString(PrefKeys.themeMode);
    ThemeMode themeMode = ThemeMode.light; // Default to light

    if (savedTheme != null) {
      switch (savedTheme) {
        case 'light':
          themeMode = ThemeMode.light;
          break;
        case 'dark':
          themeMode = ThemeMode.dark;
          break;
        case 'system':
          themeMode = ThemeMode.system;
          break;
      }
    }

    emit(ThemeState(themeMode: themeMode));
  }

  Future<void> _onSetThemeMode(
    SetThemeModeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    _cache.setString(PrefKeys.themeMode, _getThemeModeString(event.themeMode));
    emit(state.copyWith(themeMode: event.themeMode));
  }

  Future<void> _onToggleTheme(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final newMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    add(SetThemeModeEvent(newMode));
  }

  String _getThemeModeString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}
