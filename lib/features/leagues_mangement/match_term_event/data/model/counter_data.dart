class CounterData {
  final int elapsedSeconds;
  final int totalWastedSeconds;
  final bool isRunning;
  final bool isPaused;
  final bool alertShown;
  final int additionalMinutes; // <-- new field

  CounterData({
    this.elapsedSeconds = 0,
    this.totalWastedSeconds = 0,
    this.isRunning = false,
    this.isPaused = false,
    this.alertShown = false,
    this.additionalMinutes = 0, // <-- default value
  });

  CounterData copyWith({
    int? elapsedSeconds,
    int? totalWastedSeconds,
    bool? isRunning,
    bool? isPaused,
    bool? alertShown,
    int? additionalMinutes, // <-- add parameter
  }) {
    return CounterData(
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      totalWastedSeconds: totalWastedSeconds ?? this.totalWastedSeconds,
      isRunning: isRunning ?? this.isRunning,
      isPaused: isPaused ?? this.isPaused,
      alertShown: alertShown ?? this.alertShown,
      additionalMinutes: additionalMinutes ?? this.additionalMinutes,
    );
  }
}