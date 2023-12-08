import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:posts_app/src/config/router/app_routes.dart';
import 'package:posts_app/src/config/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await openHiveBox('myBox');

  /// global CERTIFICATE_VERIFY_FAILEd_KEY
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    const MainApp(),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      super.createHttpClient(context)
        ..badCertificateCallback = (cert, host, port) => true;
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        /// title
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: scaffoldMessengerKey,

        /// theme style
        theme: lightTheme,
        themeMode: ThemeMode.light,

        /// pages
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      );
}

Future openHiveBox(String boxName) async {
  if (!kIsWeb && !Hive.isBoxOpen(boxName)) {
    Hive.init((await getApplicationDocumentsDirectory()).path);
  }

  await Hive.openBox(boxName);
}

/// flutter pub run flutter_launcher_icons:main
/// flutter run -d windows
/// flutter build apk --release
/// flutter build appbundle --release
/// flutter pub run build_runner watch --delete-conflicting-outputs
/// flutter pub ipa
