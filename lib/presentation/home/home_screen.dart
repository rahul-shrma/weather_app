import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:weather_app/data/model/weather_response.dart';
import 'package:weather_app/helper/helper.dart';
import 'package:weather_app/presentation/home/cubit/home_cubit.dart';
import 'package:weather_app/presentation/home/cubit/home_state.dart';

import '../../injection/injection_container.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = sl<HomeCubit>();
    cubit.init();
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return BlocConsumer<HomeCubit, HomeState>(
          bloc: cubit,
          listener: (context, state) {
            if (state.locationStatus == 'permission_granted') {
              cubit.getLocationDetails();
            } else if (state.locationStatus == 'success') {
              if (state.currentPosition != null) {
                cubit.getWeatherForecast(
                    cityName:
                        "${state.currentPosition!.latitude},${state.currentPosition!.longitude}");
              } else {
                cubit.getWeatherForecast(cityName: "Chandigarh");
              }
            }
          },
          builder: (context, state) {
            var locationStatus = cubit.locationStatusLabel();
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFF95D6FB),
                title: Text(
                  'Weather App',
                  style: TextStyle(
                      color: Colors.black, fontSize: 16, fontFamily: 'Bold'),
                ),
                automaticallyImplyLeading: false,
                actions: [
                  ToggleSwitch(
                    minWidth: constraints.maxWidth > 600 ? 90.0 : 70,
                    cornerRadius: constraints.maxWidth > 600 ? 20.0 : 15,
                    activeBgColors: [
                      [Colors.grey[800]!],
                      [Colors.grey[800]!]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: cubit.state.theme,
                    totalSwitches: 2,
                    labels: ['Light', 'Dark'],
                    customTextStyles: [
                      TextStyle(fontFamily: 'Normal', fontSize: 14)
                    ],
                    radiusStyle: true,
                    onToggle: (index) {
                      cubit.saveTheme(index ?? 1);
                    },
                  ),
                ],
              ),
              body: Container(
                color: cubit.getBackgroundColor(),
                child: Row(
                  children: [
                    Expanded(
                        flex: constraints.maxWidth > 600 ? 3 : 1,
                        child: SizedBox()),
                    Expanded(
                      flex: constraints.maxWidth > 600 ? 5 : 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: constraints.maxWidth > 600 ? 20 : 18,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: cubit.getBorderColor()),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: cubit.getBorderColor()),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: cubit.getBorderColor()),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: cubit.getBorderColor()),
                              ),
                              hintText: 'City Name e.g. Chandigarh',
                              hintStyle: TextStyle(
                                  color: cubit.getHintTextColor(),
                                  fontSize: 14,
                                  fontFamily: 'Normal'),
                            ),
                            textAlign: TextAlign.center,
                            controller: state.cityNameController,
                            style: TextStyle(
                                color: cubit.getTextColor(),
                                fontSize: 14,
                                fontFamily: 'Normal'),
                            onChanged: (value) {
                              cubit.deBouncer.run(() {
                                cubit.getWeatherForecast(cityName: value);
                              });
                            },
                          ),
                          SizedBox(
                            height: constraints.maxWidth > 600 ? 20 : 18,
                          ),
                          (locationStatus.$1 != null)
                              ? Text(
                                  locationStatus.$1!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Bold',
                                    color: locationStatus.$2,
                                  ),
                                )
                              : SizedBox(),
                          Text(
                            state.weatherResponse?.location?.getFullName() ??
                                state.cityNameController.text.trim(),
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Bold',
                              color: cubit.getTextColor(),
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxWidth > 600 ? 20 : 18,
                          ),
                          locationStatus.$1 != null
                              ? Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : state.weatherResponseError == null
                                  ? weatherInfoWidget(cubit, state,
                                      state.weatherResponse, constraints)
                                  : weatherInfoErrorWidget(cubit, state)
                        ],
                      ),
                    ),
                    Expanded(
                        flex: constraints.maxWidth > 600 ? 3 : 1,
                        child: SizedBox()),
                  ],
                ),
              ),
            );
          });
    });
  }

  Widget weatherInfoWidget(HomeCubit cubit, HomeState state,
      WeatherResponse? weatherResponse, BoxConstraints constraints) {
    return state.loadingWeatherData
        ? Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
          )
        : Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                          text: 'Temperature: ',
                          children: [
                            TextSpan(
                              text: '${weatherResponse?.current?.tempC}°C',
                              style: TextStyle(
                                fontFamily: 'Normal',
                                fontSize: 14,
                                color: cubit.getTextColor(),
                              ),
                            ),
                          ],
                          style: TextStyle(
                              fontFamily: 'Bold',
                              color: cubit.getTextColor(),
                              fontSize: 13)),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                          text: 'Humidity: ',
                          children: [
                            TextSpan(
                              text: '${weatherResponse?.current?.humidity}',
                              style: TextStyle(
                                fontFamily: 'Normal',
                                fontSize: 14,
                                color: cubit.getTextColor(),
                              ),
                            ),
                          ],
                          style: TextStyle(
                              fontFamily: 'Bold',
                              color: cubit.getTextColor(),
                              fontSize: 13)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: constraints.maxWidth > 600 ? 20 : 18,
              ),
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                          text: 'Wind Speed (KPH): ',
                          children: [
                            TextSpan(
                              text: '${weatherResponse?.current?.windKph}',
                              style: TextStyle(
                                fontFamily: 'Normal',
                                fontSize: 14,
                                color: cubit.getTextColor(),
                              ),
                            ),
                          ],
                          style: TextStyle(
                              fontFamily: 'Bold',
                              color: cubit.getTextColor(),
                              fontSize: 13)),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                          text: 'Condition: ',
                          children: [
                            TextSpan(
                              text:
                                  '${weatherResponse?.current?.condition.text}',
                              style: TextStyle(
                                fontFamily: 'Normal',
                                fontSize: 14,
                                color: cubit.getTextColor(),
                              ),
                            ),
                          ],
                          style: TextStyle(
                              fontFamily: 'Bold',
                              color: cubit.getTextColor(),
                              fontSize: 13)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: constraints.maxWidth > 600 ? 50 : 30,
              ),
              Text(
                '${weatherResponse?.location?.name ?? state.cityNameController.text.trim()}\'s forecast for next 5 days',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Bold',
                  color: cubit.getTextColor(),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5,
              ),
              ListView.builder(
                itemCount:
                    (weatherResponse?.forecast?.forecastday?.length ?? 0),
                itemBuilder: (context, i) {
                  return Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blue, shape: BoxShape.circle),
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dateFormatter(
                                weatherResponse!.forecast!.forecastday![i].date,
                                'dd',
                              ),
                              style: TextStyle(
                                fontFamily: 'Bold',
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              dateFormatter(
                                weatherResponse.forecast!.forecastday![i].date,
                                'MMM',
                              ),
                              style: TextStyle(
                                fontFamily: 'Bold',
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Min: ',
                            children: [
                              TextSpan(
                                text:
                                    '${weatherResponse.forecast!.forecastday![i].day?.mintempC}°C',
                                style: TextStyle(
                                  fontFamily: 'Normal',
                                  fontSize: 14,
                                  color: cubit.getTextColor(),
                                ),
                              ),
                              TextSpan(
                                text: '   -   Max: ',
                                style: TextStyle(
                                  fontFamily: 'Bold',
                                  fontSize: 13,
                                  color: cubit.getTextColor(),
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${weatherResponse.forecast!.forecastday![i].day?.maxtempC}°C',
                                style: TextStyle(
                                  fontFamily: 'Normal',
                                  fontSize: 14,
                                  color: cubit.getTextColor(),
                                ),
                              ),
                            ],
                            style: TextStyle(
                                fontFamily: 'Bold',
                                color: cubit.getTextColor(),
                                fontSize: 13)),
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                  );
                },
                shrinkWrap: true,
              ),
            ],
          );
  }

  Widget weatherInfoErrorWidget(HomeCubit cubit, HomeState state) {
    return Center(
      child: Text(
        state.weatherResponseError?.message ?? '',
        style: TextStyle(
          fontFamily: 'Bold',
          fontSize: 16,
          color: cubit.getTextColor(),
        ),
      ),
    );
  }
}
