import 'package:simple_weather/domain/util/constant.dart';

enum Time {
  morning(textTimeMorning),
  afternoon(textTimeAfternoon),
  evening(textTimeEvening),
  night(textTimeNight);

  final String greet;
  const Time(this.greet);
}
