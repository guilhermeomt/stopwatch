part of 'stopwatch_bloc.dart';

class StopwatchState extends Equatable {
  const StopwatchState(this.duration);
  final int duration;

  @override
  List<Object> get props => [duration];
}

class StopwatchInitial extends StopwatchState {
  const StopwatchInitial() : super(0);
}

class StopwatchRun extends StopwatchState {
  const StopwatchRun(super.duration);
}

class StopwatchPause extends StopwatchState {
  const StopwatchPause(super.duration);
}

class StopwatchComplete extends StopwatchState {
  const StopwatchComplete(super.duration);
}
