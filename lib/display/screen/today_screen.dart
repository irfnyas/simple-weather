import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_weather/display/component/today/condition_text.dart';
import 'package:simple_weather/display/component/today/degrees_text.dart';
import 'package:simple_weather/display/component/today/forecast_list.dart';
import 'package:simple_weather/display/component/today/greeting_text.dart';
import 'package:simple_weather/display/component/today/name_text.dart';
import 'package:simple_weather/domain/model/weather_model.dart';
import 'package:simple_weather/domain/util/constant.dart';
import 'package:simple_weather/domain/util/service_locator.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;

    return FocusDetector(
        onFocusGained: () => weather.refreshIndicatorKey.currentState?.show(),
        child: Scaffold(
            appBar: AppBar(
              title: ValueListenableBuilder<String>(
                valueListenable: profile.cityName,
                builder: (_, value, __) {
                  return Text(value,
                      style: Theme.of(context).textTheme.overline);
                },
              ),
              actions: [
                IconButton(
                    onPressed: () => context.push(routeSettings),
                    icon: const Icon(Icons.settings_outlined),
                    color: Theme.of(context).primaryColor),
              ],
            ),
            body: RefreshIndicator(
                key: weather.refreshIndicatorKey,
                onRefresh: () async => weather.init(),
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: SizedBox(
                        height: bodyHeight,
                        child: ValueListenableBuilder<List<WeatherModel>>(
                            valueListenable: weather.weathers,
                            builder: (_, value, __) => value.isEmpty
                                ? const SizedBox.expand()
                                : Column(children: [
                                    GreetingTextWidget(
                                        value: weather.greeting.value),
                                    const SizedBox(height: 4),
                                    NameTextWidget(value: profile.name.value),
                                    const Spacer(),
                                    DegreesText(value: value[0].degrees),
                                    ConditionTextWidget(
                                        value: value[0].condition),
                                    const Spacer(flex: 2),
                                    Expanded(child: ForecastList(value: value))
                                  ])))))));
  }
}
