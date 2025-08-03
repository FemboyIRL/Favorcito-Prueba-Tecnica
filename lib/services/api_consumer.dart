import 'dart:convert';
import 'package:favorcito/models/current_wheater_model.dart';
import 'package:favorcito/models/location.dart';
import 'package:favorcito/models/weather_forecast.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiConsumer {
  static const String _baseUrl = 'https://api.weatherapi.com/v1';
  static String apiToken = dotenv.env['WEATHER_API_KEY'] ?? '';

  const ApiConsumer({apiToken});

  // Método genérico para hacer requests
  Future<dynamic> _makeRequest(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl/$endpoint').replace(
        queryParameters: {
          'key': apiToken,
          ...?queryParams,
          'lang': 'es',
        },
      );

      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('API request failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API request error: $e');
    }
  }

  // Obtener clima actual
  Future<WeatherModel> getCurrentWeather(String location) async {
    final response =
        await _makeRequest('current.json', queryParams: {'q': location});

    return WeatherModel.fromJson(response);
  }

  // Buscar ubicaciones
  Future<List<LocationModel>> searchLocations(String query) async {
    final response =
        await _makeRequest('search.json', queryParams: {'q': query});
    if (response is List) {
      return response
          .where((item) => item != null)
          .map<LocationModel>(
              (locationJson) => LocationModel.fromJson(locationJson))
          .toList();
    }
    return [];
  }

  // Obtener pronóstico
  Future<ForecastModel> getForecast(
    String location, {
    int days = 7,
    bool includeAirQuality = false,
    bool includeAlerts = false,
  }) async {
    final response = await _makeRequest('forecast.json', queryParams: {
      'q': location,
      'days': days.toString(),
      'aqi': includeAirQuality ? 'yes' : 'no',
      'alerts': includeAlerts ? 'yes' : 'no',
    });

    print(response);

    return ForecastModel.fromJson(response);
  }

  // Obtener clima histórico
  Future<Map<String, dynamic>> getHistory(
    String location,
    DateTime date,
  ) async {
    return await _makeRequest('history.json', queryParams: {
      'q': location,
      'dt': '${date.year}-${date.month}-${date.day}',
    });
  }
}
