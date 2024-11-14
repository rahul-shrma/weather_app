import 'package:weather_app/data/model/condition.dart';
import 'package:weather_app/helper/helper.dart';

class Current {
  final double tempC;
  final int isDay;
  final Condition condition;
  final double windKph;
  final int windDegree;
  final String windDir;
  final double pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double feelslikeF;

  Current({
    this.tempC = 0.0,
    this.isDay = 0,
    required this.condition,
    this.windKph = 0.0,
    this.windDegree = 0,
    this.windDir = "",
    this.pressureMb = 0,
    this.pressureIn = 0.0,
    this.precipMm = 0,
    this.precipIn = 0,
    this.humidity = 0,
    this.cloud = 0,
    this.feelslikeC = 0,
    this.feelslikeF = 0.0,
  });

  factory Current.fromJson(Map<String, dynamic>? json) => Current(
        tempC: asDouble(json, 'temp_c'),
        isDay: asInt(json, 'is_day'),
        condition: Condition.fromJson(asMap(json, 'condition')),
        windKph: asDouble(json, 'wind_kph'),
        windDegree: asInt(json, 'wind_degree'),
        windDir: asString(json, 'wind_dir'),
        pressureMb: asDouble(json, 'pressure_mb'),
        pressureIn: asDouble(json, 'pressure_in'),
        precipMm: asDouble(json, 'precip_mm'),
        precipIn: asDouble(json, 'precip_in'),
        humidity: asInt(json, 'humidity'),
        cloud: asInt(json, 'cloud'),
        feelslikeC: asDouble(json, 'feelslike_c'),
        feelslikeF: asDouble(json, 'feelslike_f'),
      );

  Map<String, dynamic> toJson() => {
        'temp_c': tempC,
        'is_day': isDay,
        'condition': condition.toJson(),
        'wind_kph': windKph,
        'wind_degree': windDegree,
        'wind_dir': windDir,
        'pressure_mb': pressureMb,
        'pressure_in': pressureIn,
        'precip_mm': precipMm,
        'precip_in': precipIn,
        'humidity': humidity,
        'cloud': cloud,
        'feelslike_c': feelslikeC,
        'feelslike_f': feelslikeF,
      };
}
