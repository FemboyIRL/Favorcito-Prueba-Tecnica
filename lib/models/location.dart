class LocationModel {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final DateTime? localtime;

  LocationModel({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.localtime,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'] as String,
      region: json['region'] as String,
      country: json['country'] as String,
      lat: json['lat'].toDouble() as double,
      lon: json['lon'].toDouble() as double,
      localtime: json['localtime'] != null
          ? DateTime.tryParse(json['localtime'] as String)
          : null,
    );
  }
}
