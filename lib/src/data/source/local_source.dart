import 'package:hive/hive.dart';
import '../../core/constants/constants.dart';

final class LocalSource {
  LocalSource();

  Box<dynamic> box = Hive.box('myBox');

  Future<void> setHasProfile({
    required bool value,
  }) async {
    await box.put(AppKeys.hasProfile, value);
  }

  bool get hasProfile =>
      box.get(AppKeys.hasProfile, defaultValue: false) as bool;

  Future<void> setUser({
    required String name,
    required String userId,
    required String password,
    required String login,
  }) async {
    await box.put(AppKeys.hasProfile, true);
    await box.put(AppKeys.password, password);
    await box.put(AppKeys.fullName, name);
    await box.put(AppKeys.login, login);
    await box.put(AppKeys.userId, userId);
  }

  String get fullName => box.get(AppKeys.fullName, defaultValue: '') as String;

  String get userId => box.get(AppKeys.userId, defaultValue: '') as String;

  String get password => box.get(AppKeys.password, defaultValue: '') as String;

  String get login => box.get(AppKeys.login, defaultValue: '') as String;

  String getKey(String key) => box.get(key, defaultValue: '') as String;

  Future<void> clear() async {
    await box.clear();
  }

  Future<void> userClear() async {
    await box.delete(AppKeys.hasProfile);
    await box.delete(AppKeys.phone);
    await box.delete(AppKeys.email);
    await box.delete(AppKeys.fullName);
    await box.delete(AppKeys.accessToken);
    await box.delete(AppKeys.refreshToken);
    await box.delete(AppKeys.userId);
    await box.delete(AppKeys.imageUrl);
  }
}
