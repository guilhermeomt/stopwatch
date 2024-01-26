import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/stopwatch_bloc.dart';

class StopwatchPage extends StatelessWidget {
  const StopwatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 72),
            const TimerText(),
            const SizedBox(height: 72),
            BlocBuilder<StopwatchBloc, StopwatchState>(
              buildWhen: (previous, current) =>
                  previous.runtimeType != current.runtimeType,
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (state is StopwatchInitial) ...[
                      FloatingActionButton(
                        onPressed: () => context
                            .read<StopwatchBloc>()
                            .add(const StopwatchStarted(duration: 0)),
                        child: const Icon(Icons.play_arrow),
                      ),
                    ] else if (state is StopwatchRun) ...[
                      FloatingActionButton(
                        onPressed: () => context
                            .read<StopwatchBloc>()
                            .add(const StopwatchPaused()),
                        child: const Icon(Icons.pause),
                      ),
                      FloatingActionButton(
                        onPressed: () => context
                            .read<StopwatchBloc>()
                            .add(const StopwatchReset()),
                        child: const Icon(Icons.replay),
                      ),
                    ] else if (state is StopwatchPause) ...[
                      FloatingActionButton(
                        onPressed: () => context
                            .read<StopwatchBloc>()
                            .add(StopwatchStarted(duration: state.duration)),
                        child: const Icon(Icons.play_arrow),
                      ),
                      FloatingActionButton(
                        onPressed: () => context
                            .read<StopwatchBloc>()
                            .add(const StopwatchReset()),
                        child: const Icon(Icons.replay),
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final int duration =
        context.select((StopwatchBloc bloc) => bloc.state.duration);

    var durationStr = formatDurationString(duration);

    return Text(
      durationStr,
      style: const TextStyle(fontSize: 72),
    );
  }

  String formatDurationString(int milliseconds) {
    final int hundreds = (milliseconds / 10).truncate();
    final int seconds = (hundreds / 100).truncate();
    final int minutes = (seconds / 60).truncate();

    final String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');
    final String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    final String minutesStr = (minutes % 60).toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr:$hundredsStr';
  }
}
