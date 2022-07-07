import 'package:go_router/go_router.dart';
import 'package:simple_weather/display/screen/profile_screen.dart';
import 'package:simple_weather/display/screen/today_screen.dart';
import 'package:simple_weather/domain/interactor/profile_interactor.dart';
import 'package:simple_weather/domain/util/constant.dart';
import 'package:simple_weather/domain/util/service_locator.dart';

late final router = GoRouter(
  routes: [
    GoRoute(path: routeToday, builder: (_, __) => const TodayScreen()),
    GoRoute(path: routeProfile, builder: (_, __) => const ProfileScreen())
  ],
  errorBuilder: (_, __) => const TodayScreen(),
  refreshListenable: sl<ProfileInteractor>().isLoggedIn,
  debugLogDiagnostics: isDev,
);
