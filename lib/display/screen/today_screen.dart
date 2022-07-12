import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_weather/display/component/weather_card.dart';
import 'package:simple_weather/domain/interactor/profile_interactor.dart';
import 'package:simple_weather/domain/interactor/weather_interactor.dart';
import 'package:simple_weather/domain/model/weather_model.dart';
import 'package:simple_weather/domain/util/constant.dart';
import 'package:simple_weather/domain/util/dialog_manager.dart';
import 'package:simple_weather/domain/util/service_locator.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _profile = sl<ProfileInteractor>();
    final _weather = sl<WeatherInteractor>();

    _profile.init();
    _weather.init();

    final _bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;

    final _greetingTextWidget = ValueListenableBuilder<String>(
      valueListenable: _weather.greeting,
      builder: (_, value, __) {
        return Text(value, style: Theme.of(context).textTheme.subtitle2);
      },
    );

    final _nameTextWidget = ValueListenableBuilder<String>(
      valueListenable: _profile.name,
      builder: (_, value, __) {
        return Text(value,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontWeight: FontWeight.normal));
      },
    );

    final _degreesTextWidget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('°',
            style: Theme.of(context).textTheme.headline1?.copyWith(
                fontWeight: FontWeight.normal, color: Colors.transparent)),
        ValueListenableBuilder<List<WeatherModel>>(
          valueListenable: _weather.weathers,
          builder: (_, value, __) {
            return Text(value[0].degrees,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade900));
          },
        ),
        Text('°',
            style: Theme.of(context).textTheme.headline1?.copyWith(
                fontWeight: FontWeight.normal, color: Colors.grey.shade900)),
      ],
    );

    final _conditionTextWidget = ValueListenableBuilder<List<WeatherModel>>(
      valueListenable: _weather.weathers,
      builder: (_, value, __) {
        return Text(value[0].condition,
            style: Theme.of(context).textTheme.overline);
      },
    );

    final _nextDayWidget = Expanded(
      child: Opacity(
        opacity: 0.92,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            primary: false,
            shrinkWrap: true,
            itemCount: 5,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(
                  width: 16,
                ),
            itemBuilder: (_, i) {
              return _weather.weathers.value.isNotEmpty
                  ? WeatherCard(weather: _weather.weathers.value[i + 1])
                  : const SizedBox();
            }),
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        DialogManager.showExit();
        return false;
      },
      child: FocusDetector(
        onFocusGained: () => _weather.refreshIndicatorKey.currentState?.show(),
        child: Scaffold(
          appBar: AppBar(
            title: ValueListenableBuilder<String>(
              valueListenable: _profile.cityName,
              builder: (_, value, __) {
                return Text(value, style: Theme.of(context).textTheme.overline);
              },
            ),
            actions: [
              IconButton(
                  onPressed: () => context.push(routeProfile),
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
              child: SizedBox(
                  height: _bodyHeight,
                  child: ValueListenableBuilder<List<WeatherModel>>(
                      valueListenable: _weather.weathers,
                      builder: (_, value, __) {
                        return Visibility(
                          visible: value.isNotEmpty,
                          replacement: const SizedBox.expand(),
                          child: Column(children: [
                            _greetingTextWidget,
                            const SizedBox(height: 4),
                            _nameTextWidget,
                            const Spacer(),
                            _degreesTextWidget,
                            _conditionTextWidget,
                            const Spacer(flex: 2),
                            _nextDayWidget
                          ]),
                        );
                      })),
            ),
          ),
        ),
      ),
    );
  }
}
