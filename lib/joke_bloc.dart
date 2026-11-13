import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

// ==========================================
// 1. DATA MODEL
// ==========================================
class DadJoke {
  final String id;
  final String joke;

  DadJoke({required this.id, required this.joke});

  factory DadJoke.fromJson(Map<String, dynamic> json) {
    return DadJoke(
      id: json['id'] as String? ?? '',
      joke: json['joke'] as String? ?? '',
    );
  }
}

// ==========================================
// 2. EVENTS
// ==========================================
abstract class JokeEvent {}

class FetchJokeEvent extends JokeEvent {}

// ==========================================
// 3. STATES
// ==========================================
abstract class JokeState {}

class JokeInitial extends JokeState {}

class JokeLoading extends JokeState {}

class JokeLoaded extends JokeState {
  final DadJoke joke;
  JokeLoaded(this.joke);
}

class JokeError extends JokeState {
  final String message;
  JokeError(this.message);
}

// ==========================================
// 4. BLOC
// ==========================================
class JokeBloc extends Bloc<JokeEvent, JokeState> {
  JokeBloc() : super(JokeInitial()) {
    on<FetchJokeEvent>(_onFetchJoke);
  }

  Future<void> _onFetchJoke(
      FetchJokeEvent event,
      Emitter<JokeState> emit,
      ) async {
    emit(JokeLoading());

    final uri = Uri.parse('https://icanhazdadjoke.com/');

    try {
      // icanhazdadjoke REQUIRES the 'Accept: application/json' header!
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'FlutterDadJokesDemo (https://github.com/T-33/mobile_dev_midterm)',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final dadJoke = DadJoke.fromJson(data);
        emit(JokeLoaded(dadJoke));
      } else {
        emit(JokeError('Server error: HTTP ${response.statusCode}'));
      }
    } catch (e) {
      emit(JokeError('Failed to fetch joke: $e'));
    }
  }
}