import 'package:favorcito/models/air_queality.dart';
import 'package:favorcito/models/weather_condition.dart';

class CurrentWeather {
  final DateTime lastUpdated;
  final double tempC;
  final double tempF;
  final bool isDay;
  final WeatherCondition condition;
  final double windKph;
  final String windDir;
  final double pressureMb;
  final double precipMm;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double feelslikeF;
  final double visKm;
  final double uv;
  final double gustKph;
  final AirQuality? airQuality;

  CurrentWeather({
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.windDir,
    required this.pressureMb,
    required this.precipMm,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.visKm,
    required this.uv,
    required this.gustKph,
    this.airQuality,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      lastUpdated: DateTime.parse(json['last_updated'] as String),
      tempC: (json['temp_c'] as num).toDouble(),
      tempF: (json['temp_f'] as num).toDouble(),
      isDay: json['is_day'] == 1,
      condition: WeatherCondition.fromJson(json['condition']),
      windKph: (json['wind_kph'] as num).toDouble(),
      windDir: json['wind_dir'] as String,
      pressureMb: (json['pressure_mb'] as num).toDouble(),
      precipMm: (json['precip_mm'] as num).toDouble(),
      humidity: json['humidity'] as int,
      cloud: json['cloud'] as int,
      feelslikeC: (json['feelslike_c'] as num).toDouble(),
      feelslikeF: (json['feelslike_f'] as num).toDouble(),
      visKm: (json['vis_km'] as num).toDouble(),
      uv: (json['uv'] as num).toDouble(),
      gustKph: (json['gust_kph'] as num).toDouble(),
      airQuality: json['air_quality'] != null
          ? AirQuality.fromJson(json['air_quality'])
          : null,
    );
  }
}
