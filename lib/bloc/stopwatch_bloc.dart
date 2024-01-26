import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/ticker.dart';

part 'stopwatch_event.dart';
part 'stopwatch_state.dart';

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubscription;

  StopwatchBloc({
    required Ticker ticker,
  })  : _ticker = ticker,
        super(const StopwatchInitial()) {
    on<StopwatchStarted>(_onStopwatchStarted);
    on<StopwatchPaused>(_onPaused);
    on<StopwatchTicked>(_onTicked);
    on<StopwatchReset>(_onReset);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStopwatchStarted(
    StopwatchStarted event,
    Emitter<StopwatchState> emit,
  ) {
    emit(StopwatchRun(event.duration));

    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: event.duration).listen(
          (duration) => add(StopwatchTicked(duration: duration)),
        );
  }

  void _onPaused(StopwatchPaused event, Emitter<StopwatchState> emit) {
    if (state is StopwatchRun) {
      _tickerSubscription?.pause();
      emit(StopwatchPause(state.duration));
    }
  }

  void _onTicked(StopwatchTicked event, Emitter<StopwatchState> emit) {
    emit(StopwatchRun(event.duration));
  }

  void _onReset(StopwatchReset event, Emitter<StopwatchState> emit) {
    _tickerSubscription?.cancel();
    emit(const StopwatchInitial());
  }
}
