import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final primaryColor = Colors.orange.shade700;

const isDev = kDebugMode;
const appName = 'Simple Weather';

const prefName = 'prefName';
const prefProvId = 'prefProvId';
const prefCityId = 'prefCityId';
const prefCityName = 'prefCityName';
const prefCityLat = 'prefCityLat';
const prefCityLng = 'prefCityLng';

const wilayahUrl = 'https://ifnyas.github.io/wilayah/api';
const openWeatherUrl = 'https://api.openweathermap.org/data/2.5/forecast';

const routeToday = '/';
const routeProfile = '/profile';

const textTitleApiError = 'CONNECTION ERROR';
const textTimeMorning = 'GOOD MORNING';
const textTimeAfternoon = 'GOOD AFTERNOON';
const textTimeNight = 'GOOD NIGHT';
const textExitTitle = 'Exit $appName?';

const textSave = 'SAVE';
const textBack = 'BACK';
const textExit = 'EXIT';
const textOk = 'OK';

const textLabelName = 'What should we call you?';
const textHintName = 'e.g. MASTER WEATHER';
const textLabelProv = 'Select Province';
const textLabelCity = 'Select City';
const textErrorEmptyProv = 'Please select a prov';
const textErrorEmptyCity = 'Please select a city';
