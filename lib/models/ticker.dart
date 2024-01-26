class Ticker {
  const Ticker();

  Stream<int> tick({required int ticks}) {
    return Stream.periodic(
        const Duration(milliseconds: 1), (tick) => tick + ticks + 1);
  }
}
