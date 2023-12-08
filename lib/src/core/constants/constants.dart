part 'app_keys.dart';

sealed class Constants {
  Constants._();

  /// test
  static const baseUrl = 'https://6565e550eb8bb4b70ef2891b.mockapi.io/api/v1';
}

sealed class Urls {
  Urls._();

  static const String register = '/v2/register';
  static const String login = '/login';
  static const String posts = '/posts';
}

// The splash page animation duration.
const Duration splashPageAnimationDuration = Duration(milliseconds: 1500);
