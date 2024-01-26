import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/stopwatch_bloc.dart';
import 'package:stopwatch/models/ticker.dart';

import 'views/stopwatch_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StopwatchBloc(ticker: const Ticker()),
      child: const MaterialApp(
        title: 'Stopwatch',
        home: StopwatchPage(),
      ),
    );
  }
}
