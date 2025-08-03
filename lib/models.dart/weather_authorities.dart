import 'package:flutter/material.dart';

class WeatherAuthoritiesModel {
  final String name;
  final String? description;
  final Widget? backgroundImage;
  final Widget? icon;
  final Object heroTag;
  final void Function(BuildContext) onTap;

  WeatherAuthoritiesModel(
      {required this.name,
      required this.description,
      required this.backgroundImage,
      required this.icon,
      required this.heroTag,
      required this.onTap});
}
