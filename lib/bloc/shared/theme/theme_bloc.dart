import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_awareness_chatbot/bloc/shared/theme/theme_event.dart';
import 'package:mental_health_awareness_chatbot/bloc/shared/theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeLight()) {
    on<ThemeToggled>(_onToggled);
  }

  void _onToggled(ThemeToggled event, Emitter<ThemeState> emit) {
    emit(state is ThemeLight ? const ThemeDark() : const ThemeLight());
  }
}
