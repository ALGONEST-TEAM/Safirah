import 'package:flutter_test/flutter_test.dart';
import 'package:safirah/features/authorization/data/model/authorization_models.dart';

void main() {
  test('UserAccessForAllLeaguesModel.fromJsonList parses list payload (data: List)', () {
    final payload = [
      {
        'id': 12,
        'league_id': 1,
        'league_sync_id': 'l-1',
        'status': 'active',
        'start_date': null,
        'end_date': null,
        'roles': [
          {
            'id': 1,
            'sync_id': 'r-1',
            'name_ar': 'منظم',
            'name_en': 'Organizer',
          },
          {
            'id': 2,
            'sync_id': 'r-2',
            'name_ar': 'حكم',
            'name_en': 'Referee',
          },
        ],
      }
    ];

    final model = UserAccessForAllLeaguesModel.fromJsonList(payload);

    expect(model.data, hasLength(1));
    expect(model.data.first.leagueId, 1);
    expect(model.data.first.leagueSyncId, 'l-1');
    expect(model.data.first.roleKeys.toSet(), {'organizer', 'referee'});
  });
}


