import 'package:favorcito/models/current.dart';
import 'package:favorcito/models/current_wheater_model.dart';
import 'package:favorcito/models/location.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class WeatherWidget extends StatelessWidget {
  final WeatherModel weatherData;
  final bool isLoading;

  const WeatherWidget(
      {super.key, required this.weatherData, required this.isLoading});

  // Inicializar la localización una sola vez
  static bool _isLocaleInitialized = false;

  Future<void> _initLocale() async {
    if (!_isLocaleInitialized) {
      await initializeDateFormatting('es', null);
      _isLocaleInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final current = weatherData.current;
    final location = weatherData.location;

    return FutureBuilder<void>(
      future: _initLocale(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || isLoading) {
          return _buildLoadingWidget();
        }

        return Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          decoration: BoxDecoration(
            gradient: _getWeatherGradient(current.condition.text),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: colors.primary.withOpacity(0.1),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Stack(
              children: [
                // Patrón de fondo decorativo
                _buildBackgroundPattern(),

                // Contenido principal
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Encabezado con ubicación y fecha
                      _buildLocationHeader(location, theme),
                      const SizedBox(height: 32),

                      // Temperatura principal con icono
                      _buildMainTemperatureSection(current, theme),
                      const SizedBox(height: 32),

                      // Condición climática
                      _buildWeatherCondition(current, theme),
                      const SizedBox(height: 32),

                      // Detalles en cards
                      _buildWeatherDetails(current, colors),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildLoadingWidget() {
  return Container(
    margin: const EdgeInsets.all(16),
    height: 400,
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(32),
    ),
    child: const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Cargando datos del clima...',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    ),
  );
}

Widget _buildBackgroundPattern() {
  return Positioned.fill(
    child: CustomPaint(
      painter: WeatherPatternPainter(),
    ),
  );
}

LinearGradient _getWeatherGradient(String condition) {
  final conditionLower = condition.toLowerCase();

  if (conditionLower.contains('sunny') || conditionLower.contains('clear')) {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF4FC3F7),
        Color(0xFF29B6F6),
        Color(0xFF0288D1),
      ],
    );
  } else if (conditionLower.contains('rain') ||
      conditionLower.contains('storm')) {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF78909C),
        Color(0xFF546E7A),
        Color(0xFF37474F),
      ],
    );
  } else if (conditionLower.contains('cloud')) {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF90A4AE),
        Color(0xFF78909C),
        Color(0xFF607D8B),
      ],
    );
  } else if (conditionLower.contains('snow')) {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFE3F2FD),
        Color(0xFFBBDEFB),
        Color(0xFF90CAF9),
      ],
    );
  }

  // Gradiente por defecto
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF42A5F5),
      Color(0xFF1E88E5),
      Color(0xFF1565C0),
    ],
  );
}

Widget _buildLocationHeader(LocationModel location, ThemeData theme) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withOpacity(0.3)),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                location.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          "${location.region}, ${location.country}",
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          DateFormat('EEEE, dd MMM • HH:mm').format(location.localtime!),
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildMainTemperatureSection(CurrentWeather current, ThemeData theme) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.15),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: Colors.white.withOpacity(0.2)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Icono del clima grande
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.network(
            "https:${current.condition.icon}",
            width: 80,
            height: 80,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.wb_sunny,
                size: 80,
                color: Colors.white,
              );
            },
          ),
        ),

        // Información de temperatura
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${current.tempC.round()}°",
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w200,
                color: Colors.white,
                height: 0.8,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Sensación ${current.feelslikeC.round()}°",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildWeatherCondition(CurrentWeather current, ThemeData theme) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withOpacity(0.2)),
    ),
    child: Text(
      current.condition.text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _buildWeatherDetails(CurrentWeather current, ColorScheme colors) {
  final details = [
    WeatherDetailData(
      icon: Icons.water_drop_outlined,
      value: "${current.humidity}%",
      label: "Humedad",
    ),
    WeatherDetailData(
      icon: Icons.air,
      value: "${current.windKph.round()} km/h",
      label: "Viento",
    ),
    WeatherDetailData(
      icon: Icons.visibility_outlined,
      value: "${current.visKm.round()} km",
      label: "Visibilidad",
    ),
    WeatherDetailData(
      icon: Icons.grain,
      value: "${current.precipMm} mm",
      label: "Precipitación",
    ),
    WeatherDetailData(
      icon: Icons.compress,
      value: "${current.pressureMb.round()} hPa",
      label: "Presión",
    ),
    WeatherDetailData(
      icon: Icons.light_mode_outlined,
      value: current.uv.toString(),
      label: "Índice UV",
    ),
  ];

  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 1.1,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
    ),
    itemCount: details.length,
    itemBuilder: (context, index) {
      return _buildDetailItem(details[index]);
    },
  );
}

Widget _buildDetailItem(WeatherDetailData data) {
  return Container(
    padding: const EdgeInsets.all(1),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.15),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.white.withOpacity(0.2)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          data.icon,
          color: Colors.white,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          data.value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 13,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          data.label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// Clase helper para los datos de detalles del clima
class WeatherDetailData {
  final IconData icon;
  final String value;
  final String label;

  WeatherDetailData({
    required this.icon,
    required this.value,
    required this.label,
  });
}

// Painter personalizado para el patrón de fondo
class WeatherPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    // Círculos decorativos
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.2),
      40,
      paint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.7),
      60,
      paint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.8),
      25,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
