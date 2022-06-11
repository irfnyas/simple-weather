import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_flutter/display/screen/today_screen.dart';
import 'package:weather_flutter/domain/util/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Simple Weather',
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
      debugShowCheckedModeBanner: false,
      home: const TodayScreen(),
      enableLog: true,
      defaultTransition: Transition.fade,
    );
  }
}
