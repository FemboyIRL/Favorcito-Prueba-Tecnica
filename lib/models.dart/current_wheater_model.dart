import 'package:favorcito/models.dart/current.dart';
import 'package:favorcito/models.dart/location.dart';

class WeatherModel {
  final LocationModel location;
  final CurrentWeather current;

  WeatherModel({
    required this.location,
    required this.current,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: LocationModel.fromJson(json['location']),
      current: CurrentWeather.fromJson(json['current']),
    );
  }
}
