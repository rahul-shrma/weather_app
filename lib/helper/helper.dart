import 'package:intl/intl.dart';

String asString(Map<String, dynamic>? json, String key) {
  if (json?.containsKey(key) == true) {
    return json![key];
  }
  return '';
}

int asInt(Map<String, dynamic>? json, String key) {
  if (json?.containsKey(key) == true) {
    return json![key] as int;
  }
  return 0;
}

double asDouble(Map<String, dynamic>? json, String key) {
  if (json?.containsKey(key) == true) {
    return json![key] as double;
  }
  return 0.0;
}

Map<String, dynamic>? asMap(Map<String, dynamic>? json, String key) {
  if (json?.containsKey(key) == true) {
    return json![key];
  }
  return null;
}

String dateFormatter(String? date, String targetFormat) {
  if (date == null) {
    return 'N/A';
  }
  var inputFormat = DateFormat('yyyy-MM-dd');
  var inputDate = inputFormat.parse(date);
  var outputFormat = DateFormat(targetFormat);
  return outputFormat.format(inputDate);
}
