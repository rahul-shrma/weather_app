import 'package:weather_app/data/model/forecast_day.dart';

class Forecast {
  List<Forecastday>? forecastday;

  Forecast({this.forecastday});

  Forecast.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      if (json['forecastday'] != null) {
        forecastday = <Forecastday>[];
        json['forecastday'].forEach((v) {
          forecastday!.add(new Forecastday.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.forecastday != null) {
      data['forecastday'] = this.forecastday!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
