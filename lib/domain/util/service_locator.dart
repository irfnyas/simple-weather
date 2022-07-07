import 'package:get_it/get_it.dart';
import 'package:simple_weather/domain/interactor/form_interactor.dart';
import 'package:simple_weather/domain/interactor/profile_interactor.dart';
import 'package:simple_weather/domain/interactor/weather_interactor.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  sl.registerLazySingleton<ProfileInteractor>(() => ProfileInteractor());
  sl.registerLazySingleton<FormInteractor>(() => FormInteractor());
  sl.registerLazySingleton<WeatherInteractor>(() => WeatherInteractor());
}
