import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_weather/display/screen/settings_screen.dart';
import 'package:simple_weather/display/screen/today_screen.dart';
import 'package:simple_weather/domain/util/constant.dart';
import 'package:simple_weather/domain/util/dialog_manager.dart';
import 'package:simple_weather/domain/util/service_locator.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        path: routeToday,
        builder: (_, __) {
          return WillPopScope(
              onWillPop: () async {
                await showExitDialog();
                return false;
              },
              child: const TodayScreen());
        }),
    GoRoute(
        path: routeSettings,
        builder: (_, __) {
          return WillPopScope(
              onWillPop: () async {
                final isLoggedIn = profile.isLoggedIn.value;
                if (!isLoggedIn) await showExitDialog();
                return isLoggedIn;
              },
              child: const SettingsScreen());
        })
  ],
  redirect: (state) {
    final isLoggedIn = profile.isLoggedIn.value;
    final inTodayScreen = state.subloc == routeToday;

    if (!isLoggedIn && inTodayScreen) {
      return routeSettings;
    }

    return null;
  },
  errorBuilder: (_, __) => const TodayScreen(),
  debugLogDiagnostics: !kReleaseMode,
);
