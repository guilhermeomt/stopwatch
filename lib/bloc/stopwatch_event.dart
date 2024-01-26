part of 'stopwatch_bloc.dart';

class StopwatchEvent {
  const StopwatchEvent();
}

class StopwatchStarted extends StopwatchEvent {
  const StopwatchStarted({required this.duration});
  final int duration;
}

class StopwatchPaused extends StopwatchEvent {
  const StopwatchPaused();
}

class StopwatchReset extends StopwatchEvent {
  const StopwatchReset();
}

class StopwatchTicked extends StopwatchEvent {
  StopwatchTicked({required this.duration});
  final int duration;
}
