import 'dart:convert';
import 'package:favorcito/models.dart/current_wheater_model.dart';
import 'package:favorcito/models.dart/location.dart';
import 'package:http/http.dart' as http;

// Actual https://api.weatherapi.com/v1/current.json?key=d2e1246a0ceb41bc87c235135250108&q=Los Mochis&aqi=yes
// Predicción https://api.weatherapi.com/v1/future.json?key=d2e1246a0ceb41bc87c235135250108&q=Los Mochis&dt=2025-09-01
// searchBar https://api.weatherapi.com/v1/current.json?key=d2e1246a0ceb41bc87c235135250108&q=Los Mochis&aqi=yes
// Fases lunares https://api.weatherapi.com/v1/astronomy.json?key=d2e1246a0ceb41bc87c235135250108&q=Los Mochis&dt=2025-08-02

class ApiConsumer {
  static const String _baseUrl = 'https://api.weatherapi.com/v1';
  final String apiToken;

  ApiConsumer({required this.apiToken});

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
  Future<Map<String, dynamic>> getForecast(
    String location, {
    int days = 3,
    bool includeAirQuality = false,
    bool includeAlerts = false,
  }) async {
    return await _makeRequest('forecast.json', queryParams: {
      'q': location,
      'days': days.toString(),
      'aqi': includeAirQuality ? 'yes' : 'no',
      'alerts': includeAlerts ? 'yes' : 'no',
    });
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
