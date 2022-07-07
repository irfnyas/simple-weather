import 'package:flutter/material.dart';
import 'package:simple_weather/data/cache.dart';
import 'package:simple_weather/domain/util/constant.dart';
import 'package:simple_weather/domain/util/router.dart';
import 'package:simple_weather/domain/util/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();

  final isLoggedIn = await Cache.isLoggedIn();
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appName,
      theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: primaryColor,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary: primaryColor)),
          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.grey.shade900,
          )),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
