class AirQuality {
  final double co;
  final double no2;
  final double o3;
  final double so2;
  final double pm2_5;
  final double pm10;
  final int usEpaIndex;

  AirQuality({
    required this.co,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.usEpaIndex,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) {
    return AirQuality(
      co: (json['co'] as num).toDouble(),
      no2: (json['no2'] as num).toDouble(),
      o3: (json['o3'] as num).toDouble(),
      so2: (json['so2'] as num).toDouble(),
      pm2_5: (json['pm2_5'] as num).toDouble(),
      pm10: (json['pm10'] as num).toDouble(),
      usEpaIndex: json['us-epa-index'] as int,
    );
  }

  String get qualityDescription {
    switch (usEpaIndex) {
      case 1:
        return 'Buena';
      case 2:
        return 'Moderada';
      case 3:
        return 'Insalubre para grupos sensibles';
      case 4:
        return 'Insalubre';
      case 5:
        return 'Muy insalubre';
      case 6:
        return 'Peligrosa';
      default:
        return 'Desconocida';
    }
  }
}
