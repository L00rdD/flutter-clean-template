import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/bloc/example/example_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Template',
      theme: ThemeData.dark(),
      home: BlocProvider(
        create: (_) => ExampleBloc()..add(const ExampleEvent.started()),
        child: const ExamplePage(),
      ),
    );
  }
}

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clean Architecture Template')),
      body: Center(
        child: BlocBuilder<ExampleBloc, ExampleState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Text('Initial state'),
              loading: () => const CircularProgressIndicator(),
              success: (msg) => Text(msg),
              failure: (err) => Text('Error: $err'),
            );
          },
        ),
      ),
    );
  }
}
