/// مفاتيح الصلاحيات المستخدمة في التطبيق.
///
/// الهدف: منع الأخطاء الإملائية وتوحيد الاستخدام في كل الصفحات.
class AuthorizationKeys {
  AuthorizationKeys._();

  // Leagues
  static const leagueView = 'league.view';
  static const leagueEdit = 'league.edit';

  // Matches
  static const matchManage = 'match.manage';

  // Teams
  static const teamManage = 'team.manage';

  // أضف باقي الصلاحيات هنا...
}

