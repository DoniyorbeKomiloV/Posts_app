part of 'app_routes.dart';

sealed class Routes {
  Routes._();

  static const String initial = '/';

  /// main
  static const String main = '/main';

  /// profile
  static const String postDetail = '/postDetail';
  static const String settings = '/settings';

  /// auth
  static const String auth = '/auth';
  static const String register = '/register';
}
