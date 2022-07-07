import 'package:simple_weather/domain/util/constant.dart';

enum Time { morning, afternoon, night }

extension TimeExt on Time {
  String get greet {
    switch (this) {
      case Time.morning:
        return textTimeMorning;
      case Time.afternoon:
        return textTimeAfternoon;
      case Time.night:
        return textTimeNight;
    }
  }
}
