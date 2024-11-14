import 'package:weather_app/helper/helper.dart';

class Condition {
  final String text;
  final String icon;
  final int code;

  Condition({
    this.text = "",
    this.icon = "",
    this.code = 0,
  });

  factory Condition.fromJson(Map<String, dynamic>? json) => Condition(
        text: asString(json, 'text'),
        icon: asString(json, 'icon'),
        code: asInt(json, 'code'),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'icon': icon,
        'code': code,
      };
}
