import 'package:weather_app/helper/helper.dart';

class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;

  Location({
    this.name = "",
    this.region = "",
    this.country = "",
    this.lat = 0.0,
    this.lon = 0.0,
  });

  factory Location.fromJson(Map<String, dynamic>? json) => Location(
        name: asString(json, 'name'),
        region: asString(json, 'region'),
        country: asString(json, 'country'),
        lat: asDouble(json, 'lat'),
        lon: asDouble(json, 'lon'),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'region': region,
        'country': country,
        'lat': lat,
        'lon': lon,
      };

  String? getFullName() {
    if (name == '') {
      return null;
    }
    String fullName = name;
    if (region != '' && region != name) {
      fullName += ', $region';
    }
    if (country != '') {
      fullName += ', $country';
    }
    return fullName;
  }
}
