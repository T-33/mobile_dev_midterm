import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'joke_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'icanhazdadjoke Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => JokeBloc()..add(FetchJokeEvent()),
        child: const DadJokeScreen(),
      ),
    );
  }
}

class DadJokeScreen extends StatelessWidget {
  const DadJokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('👨 Dad Joke Generator'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<JokeBloc, JokeState>(
            builder: (context, state) {
              // 1. Loading State
              if (state is JokeLoading) {
                return const CircularProgressIndicator();
              }

              // 2. Error State
              if (state is JokeError) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 50, color: Colors.redAccent),
                    const SizedBox(height: 12),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<JokeBloc>().add(FetchJokeEvent()),
                      child: const Text('Try Again'),
                    ),
                  ],
                );
              }

              // 3. Loaded / Success State
              if (state is JokeLoaded) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                        child: Column(
                          children: [
                            const Text(
                              '“',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                height: 0.8,
                                color: Colors.teal,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              state.joke.joke,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'ID: ${state.joke.id}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<JokeBloc>().add(FetchJokeEvent());
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Get Another Dad Joke'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}