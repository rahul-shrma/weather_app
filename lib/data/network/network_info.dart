abstract class NetworkInfo {
  String get apiHost;

  Uri getApiUri(String path, {Map<String, String> queryParams});
}

class NetworkInfoImpl extends NetworkInfo {
  static const String _mode =
      String.fromEnvironment('WEATHER_APP_MODE', defaultValue: 'develop');

  @override
  String get apiHost {
    switch (_mode) {
      case 'production':
        return 'http://api.weatherapi.com/v1';
      case 'staging':
        return 'http://api.weatherapi.com/v1';
      case 'develop':
        return 'http://api.weatherapi.com/v1';
      default:
        throw 'WEATHER_APP_MODE not found';
    }
  }

  @override
  Uri getApiUri(String path, {Map<String, String>? queryParams}) {
    Uri uri = Uri.tryParse(apiHost + path)!;
    if (queryParams != null) {
      uri = Uri(
        scheme: uri.scheme,
        host: uri.host,
        port: uri.port,
        path: uri.path,
        queryParameters: queryParams,
      );
    }
    return uri;
  }
}
