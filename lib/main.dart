import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:simple_weather/domain/util/constant.dart';
import 'package:simple_weather/domain/util/router.dart';
import 'package:simple_weather/domain/util/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.orange.shade700;
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
                foregroundColor: Colors.grey.shade900)),
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate);
  }
}
