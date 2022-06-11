import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:weather_flutter/display/component/exit_dialog.dart';
import 'package:weather_flutter/display/component/weather_card.dart';
import 'package:weather_flutter/display/screen/profile_screen.dart';
import 'package:weather_flutter/domain/controller/profile_controller.dart';
import 'package:weather_flutter/domain/controller/weather_controller.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _profile = Get.put(ProfileController());
    final _weather = Get.put(WeatherController());

    return WillPopScope(
      onWillPop: () {
        Get.dialog(const ExitDialog());
        return Future.value(false);
      },
      child: FocusDetector(
        onFocusGained: () => _weather.refreshIndicatorKey.currentState?.show(),
        child: Scaffold(
          appBar: AppBar(
            title: Obx(() => Text(_profile.cityName.value,
                style: Theme.of(context).textTheme.overline)),
            actions: [
              IconButton(
                  onPressed: () => Get.to(() => const ProfileScreen()),
                  icon: const Icon(Icons.settings_outlined),
                  color: Theme.of(context).primaryColor),
            ],
          ),
          body: RefreshIndicator(
            key: _weather.refreshIndicatorKey,
            onRefresh: () async => _weather.getForecastData(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Container(
                height: Get.size.height -
                    Get.statusBarHeight -
                    Get.mediaQuery.padding.top,
                padding: const EdgeInsets.all(16),
                child: Obx(() => Visibility(
                      visible: _weather.weathers.isNotEmpty,
                      replacement: const SizedBox.expand(),
                      child: Column(children: [
                        Obx(() => Text(_weather.greeting.value,
                            style: Theme.of(context).textTheme.subtitle2)),
                        const SizedBox(height: 4),
                        Obx(() => Text(_profile.name.value,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(fontWeight: FontWeight.normal))),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('°',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.transparent)),
                            Obx(() => Text(
                                '${_weather.weathers[0].degrees ?? ''}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey.shade900))),
                            Text('°',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey.shade900)),
                          ],
                        ),
                        Obx(() => Text(_weather.weathers[0].condition ?? '',
                            style: Theme.of(context).textTheme.overline)),
                        const Spacer(
                          flex: 2,
                        ),
                        Expanded(
                          child: Opacity(
                            opacity: 0.92,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                primary: false,
                                shrinkWrap: true,
                                itemCount: 5,
                                physics: const BouncingScrollPhysics(),
                                separatorBuilder: (_, __) => const SizedBox(
                                      width: 16,
                                    ),
                                itemBuilder: (_, i) {
                                  return _weather.weathers.isNotEmpty
                                      ? WeatherCard(
                                          weather: _weather.weathers[i + 1])
                                      : const SizedBox();
                                }),
                          ),
                        ),
                      ]),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
