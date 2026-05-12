import '../../../../../core/network/urls.dart';

String buildLeagueDeepLink(String leagueSyncId) {
  final id = leagueSyncId.trim();
  if (id.isEmpty) return '';

  final uri = Uri(
    scheme: 'https',
    host: Uri.parse(AppURL.base).host,
    pathSegments: ['league', 'index.html'],
    queryParameters: {'id': id},
  );

  return uri.toString();
}

