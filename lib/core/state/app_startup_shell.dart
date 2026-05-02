import 'package:safirah/services/auth/auth.dart';

enum AppStartupSection { shop, leagues }

class AppStartupShellPreference {
  AppStartupShellPreference._();

  static const String _shopValue = 'shop';
  static const String _leaguesValue = 'leagues';

  static AppStartupSection resolveSectionFrom({
    required bool loggedIn,
    required String? savedValue,
  }) {
    if (!loggedIn) return AppStartupSection.shop;

    switch (savedValue) {
      case _shopValue:
        return AppStartupSection.shop;
      case _leaguesValue:
        return AppStartupSection.leagues;
      default:
        return AppStartupSection.leagues;
    }
  }

  static Future<AppStartupSection> resolveInitialSection() async {
    final auth = Auth();
    final savedValue = await auth.getLastAppShell();

    return resolveSectionFrom(
      loggedIn: auth.loggedIn,
      savedValue: savedValue,
    );
  }

  static Future<void> markCurrentShell(AppStartupSection section) async {
    if (!Auth().loggedIn) return;

    await Auth().setLastAppShell(
      section == AppStartupSection.shop ? _shopValue : _leaguesValue,
    );
  }

  static Future<void> clear() async {
    await Auth().clearLastAppShell();
  }
}
