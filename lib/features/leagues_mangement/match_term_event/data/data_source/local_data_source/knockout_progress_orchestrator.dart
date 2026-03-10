import 'dart:async';

import '../../../../match/data/model/round_model.dart';
import 'local_knockout_data_source.dart';

// A tiny orchestrator to make knockout generation idempotent.
//
// Contract:
// - If there's already a current round for the league, returns null.
// - Otherwise generates the first knockout round from groups and returns it.
//
// Notes:
// - We rely on Drift transactionality inside the local data source.
// - We also add an in-process per-league lock to prevent double taps creating
//   multiple rounds in the same isolate.
class KnockoutProgressOrchestrator {
  final KnockoutGeneratorLocalDataSource _local;

  KnockoutProgressOrchestrator(this._local);

  static final Map<String, Future<void>> _locks = {};

  Future<T> _withLeagueLock<T>(String leagueSyncId, Future<T> Function() fn) async {
    // Chain futures per league ID.
    final prev = _locks[leagueSyncId];
    final completer = Completer<void>();
    _locks[leagueSyncId] = completer.future;

    try {
      if (prev != null) await prev;
      return await fn();
    } finally {
      completer.complete();
      // Clean up if no one replaced our lock.
      if (identical(_locks[leagueSyncId], completer.future)) {
        _locks.remove(leagueSyncId);
      }
    }
  }

  Future<RoundModel?> ensure({
    required String leagueSyncId,
    required int qualifiedPerGroup,
  }) {
    return _withLeagueLock(leagueSyncId, () async {
      // If there's a current round already, do nothing.
      final current = await _local.getCurrentLeagueRound(leagueSyncId);
      if (current != null) return null;

      // Otherwise, generate the first knockout round.
      return _local.generateKnockoutFromGroups(
        leagueSyncId: leagueSyncId,
        qualifiedPerGroup: qualifiedPerGroup,
      );
    });
  }
}
