class ForecastModel {
  final Location location;
  final Forecast forecast;

  ForecastModel({
    required this.location,
    required this.forecast,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      location: Location.fromJson(json['location']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      'forecast': forecast.toJson(),
    };
  }
}

class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tzId;
  final int localtimeEpoch;
  final String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
      tzId: json['tz_id'],
      localtimeEpoch: json['localtime_epoch'],
      localtime: json['localtime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'region': region,
      'country': country,
      'lat': lat,
      'lon': lon,
      'tz_id': tzId,
      'localtime_epoch': localtimeEpoch,
      'localtime': localtime,
    };
  }
}

class Forecast {
  final List<ForecastDay> forecastday;

  Forecast({required this.forecastday});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      forecastday: (json['forecastday'] as List)
          .map((day) => ForecastDay.fromJson(day))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'forecastday': forecastday.map((day) => day.toJson()).toList(),
    };
  }
}

class ForecastDay {
  final String date;
  final int dateEpoch;
  final Day day;
  final Astro astro;
  final List<Hour> hour;

  ForecastDay({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.astro,
    required this.hour,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      date: json['date'],
      dateEpoch: json['date_epoch'],
      day: Day.fromJson(json['day']),
      astro: Astro.fromJson(json['astro']),
      hour: (json['hour'] as List)
          .map((h) => Hour.fromJson(h))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'date_epoch': dateEpoch,
      'day': day.toJson(),
      'astro': astro.toJson(),
      'hour': hour.map((h) => h.toJson()).toList(),
    };
  }
}

class Day {
  final double maxtempC;
  final double maxtempF;
  final double mintempC;
  final double mintempF;
  final double avgtempC;
  final double avgtempF;
  final double maxwindMph;
  final double maxwindKph;
  final double totalprecipMm;
  final double totalprecipIn;
  final double avgvisKm;
  final double avgvisMiles;
  final double avghumidity;
  final Condition condition;
  final double uv;

  Day({
    required this.maxtempC,
    required this.maxtempF,
    required this.mintempC,
    required this.mintempF,
    required this.avgtempC,
    required this.avgtempF,
    required this.maxwindMph,
    required this.maxwindKph,
    required this.totalprecipMm,
    required this.totalprecipIn,
    required this.avgvisKm,
    required this.avgvisMiles,
    required this.avghumidity,
    required this.condition,
    required this.uv,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxtempC: json['maxtemp_c'].toDouble(),
      maxtempF: json['maxtemp_f'].toDouble(),
      mintempC: json['mintemp_c'].toDouble(),
      mintempF: json['mintemp_f'].toDouble(),
      avgtempC: json['avgtemp_c'].toDouble(),
      avgtempF: json['avgtemp_f'].toDouble(),
      maxwindMph: json['maxwind_mph'].toDouble(),
      maxwindKph: json['maxwind_kph'].toDouble(),
      totalprecipMm: json['totalprecip_mm'].toDouble(),
      totalprecipIn: json['totalprecip_in'].toDouble(),
      avgvisKm: json['avgvis_km'].toDouble(),
      avgvisMiles: json['avgvis_miles'].toDouble(),
      avghumidity: json['avghumidity'].toDouble(),
      condition: Condition.fromJson(json['condition']),
      uv: json['uv'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maxtemp_c': maxtempC,
      'maxtemp_f': maxtempF,
      'mintemp_c': mintempC,
      'mintemp_f': mintempF,
      'avgtemp_c': avgtempC,
      'avgtemp_f': avgtempF,
      'maxwind_mph': maxwindMph,
      'maxwind_kph': maxwindKph,
      'totalprecip_mm': totalprecipMm,
      'totalprecip_in': totalprecipIn,
      'avgvis_km': avgvisKm,
      'avgvis_miles': avgvisMiles,
      'avghumidity': avghumidity,
      'condition': condition.toJson(),
      'uv': uv,
    };
  }
}

class Astro {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;
  final int moonIllumination;

  Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
  });

  factory Astro.fromJson(Map<String, dynamic> json) {
    return Astro(
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      moonrise: json['moonrise'],
      moonset: json['moonset'],
      moonPhase: json['moon_phase'],
      moonIllumination: json['moon_illumination'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sunrise': sunrise,
      'sunset': sunset,
      'moonrise': moonrise,
      'moonset': moonset,
      'moon_phase': moonPhase,
      'moon_illumination': moonIllumination,
    };
  }
}

class Hour {
  final int timeEpoch;
  final String time;
  final double tempC;
  final double tempF;
  final int isDay;
  final Condition condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final double pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double feelslikeF;
  final double windchillC;
  final double windchillF;
  final double heatindexC;
  final double heatindexF;
  final double dewpointC;
  final double dewpointF;
  final int willItRain;
  final int chanceOfRain;
  final int willItSnow;
  final int chanceOfSnow;
  final double visKm;
  final double visMiles;
  final double gustMph;
  final double gustKph;
  final double uv;

  Hour({
    required this.timeEpoch,
    required this.time,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.windchillC,
    required this.windchillF,
    required this.heatindexC,
    required this.heatindexF,
    required this.dewpointC,
    required this.dewpointF,
    required this.willItRain,
    required this.chanceOfRain,
    required this.willItSnow,
    required this.chanceOfSnow,
    required this.visKm,
    required this.visMiles,
    required this.gustMph,
    required this.gustKph,
    required this.uv,
  });

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      timeEpoch: json['time_epoch'],
      time: json['time'],
      tempC: json['temp_c'].toDouble(),
      tempF: json['temp_f'].toDouble(),
      isDay: json['is_day'],
      condition: Condition.fromJson(json['condition']),
      windMph: json['wind_mph'].toDouble(),
      windKph: json['wind_kph'].toDouble(),
      windDegree: json['wind_degree'],
      windDir: json['wind_dir'],
      pressureMb: json['pressure_mb'].toDouble(),
      pressureIn: json['pressure_in'].toDouble(),
      precipMm: json['precip_mm'].toDouble(),
      precipIn: json['precip_in'].toDouble(),
      humidity: json['humidity'],
      cloud: json['cloud'],
      feelslikeC: json['feelslike_c'].toDouble(),
      feelslikeF: json['feelslike_f'].toDouble(),
      windchillC: json['windchill_c'].toDouble(),
      windchillF: json['windchill_f'].toDouble(),
      heatindexC: json['heatindex_c'].toDouble(),
      heatindexF: json['heatindex_f'].toDouble(),
      dewpointC: json['dewpoint_c'].toDouble(),
      dewpointF: json['dewpoint_f'].toDouble(),
      willItRain: json['will_it_rain'],
      chanceOfRain: json['chance_of_rain'],
      willItSnow: json['will_it_snow'],
      chanceOfSnow: json['chance_of_snow'],
      visKm: json['vis_km'].toDouble(),
      visMiles: json['vis_miles'].toDouble(),
      gustMph: json['gust_mph'].toDouble(),
      gustKph: json['gust_kph'].toDouble(),
      uv: json['uv'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time_epoch': timeEpoch,
      'time': time,
      'temp_c': tempC,
      'temp_f': tempF,
      'is_day': isDay,
      'condition': condition.toJson(),
      'wind_mph': windMph,
      'wind_kph': windKph,
      'wind_degree': windDegree,
      'wind_dir': windDir,
      'pressure_mb': pressureMb,
      'pressure_in': pressureIn,
      'precip_mm': precipMm,
      'precip_in': precipIn,
      'humidity': humidity,
      'cloud': cloud,
      'feelslike_c': feelslikeC,
      'feelslike_f': feelslikeF,
      'windchill_c': windchillC,
      'windchill_f': windchillF,
      'heatindex_c': heatindexC,
      'heatindex_f': heatindexF,
      'dewpoint_c': dewpointC,
      'dewpoint_f': dewpointF,
      'will_it_rain': willItRain,
      'chance_of_rain': chanceOfRain,
      'will_it_snow': willItSnow,
      'chance_of_snow': chanceOfSnow,
      'vis_km': visKm,
      'vis_miles': visMiles,
      'gust_mph': gustMph,
      'gust_kph': gustKph,
      'uv': uv,
    };
  }
}

class Condition {
  final String text;
  final String icon;
  final int code;

  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      icon: json['icon'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'icon': icon,
      'code': code,
    };
  }
}