import 'package:favorcito/models/weather_forecast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ForecastWidget extends StatefulWidget {
  final ForecastModel forecastData;
  final bool isLoading;

  const ForecastWidget({
    super.key,
    required this.forecastData,
    required this.isLoading,
  });

  @override
  State<ForecastWidget> createState() => _ForecastWidgetState();
}

class _ForecastWidgetState extends State<ForecastWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedDayIndex = 0;
  
  // Inicializar la localización una sola vez
  static bool _isLocaleInitialized = false;
  
  Future<void> _initLocale() async {
    if (!_isLocaleInitialized) {
      await initializeDateFormatting('es', null);
      _isLocaleInitialized = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.forecastData.forecast.forecastday.length,
      vsync: this,
    );
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _selectedDayIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return _buildLoadingWidget();
    }

    return FutureBuilder<void>(
      future: _initLocale(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingWidget();
        }
        
        return Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF4FC3F7),
                Color(0xFF29B6F6),
                Color(0xFF0288D1),
              ],
            ),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: const Color(0xFF1E88E5).withOpacity(0.1),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Column(
              children: [
                _buildHeader(),
                _buildWeeklyOverview(),
                _buildDayTabs(),
                _buildSelectedDayDetails(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 600,
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
              'Cargando pronóstico...',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: const Icon(
              Icons.calendar_month,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pronóstico Extendido',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${widget.forecastData.forecast.forecastday.length} días • ${widget.forecastData.location.name}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyOverview() {
    return Container(
      height: 230,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.forecastData.forecast.forecastday.length,
        itemBuilder: (context, index) {
          final day = widget.forecastData.forecast.forecastday[index];
          final date = DateTime.parse(day.date);
          final isSelected = index == _selectedDayIndex;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDayIndex = index;
                _tabController.animateTo(index);
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected 
                    ? Colors.white.withOpacity(0.3)
                    : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected 
                      ? Colors.white.withOpacity(0.5)
                      : Colors.white.withOpacity(0.2),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEE').format(date),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('dd').format(date),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Image.network(
                    "https:${day.day.condition.icon}",
                    width: 24,
                    height: 24,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.wb_sunny,
                        size: 24,
                        color: Colors.white,
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${day.day.maxtempC.round()}°',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDayTabs() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.2)),
          bottom: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: Colors.white,
        indicatorWeight: 7,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withOpacity(0.7),
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
        tabs: widget.forecastData.forecast.forecastday.map((day) {
          final date = DateTime.parse(day.date);
          return Tab(
            text: DateFormat('EEE dd').format(date),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSelectedDayDetails() {
    return Container(
      height: 400,
      child: TabBarView(
        controller: _tabController,
        children: widget.forecastData.forecast.forecastday.map((day) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDayMainInfo(day),
                const SizedBox(height: 20),
                _buildDayStats(day),
                const SizedBox(height: 20),
                _buildAstroInfo(day.astro),
                const SizedBox(height: 20),
                _buildHourlyForecast(day.hour),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDayMainInfo(ForecastDay day) {
    final date = DateTime.parse(day.date);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEEE, dd MMMM').format(date),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  day.day.condition.text,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      '${day.day.maxtempC.round()}°',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '/${day.day.mintempC.round()}°',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.network(
              "https:${day.day.condition.icon}",
              width: 60,
              height: 60,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.wb_sunny,
                  size: 60,
                  color: Colors.white,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayStats(ForecastDay day) {
    final stats = [
      StatData(Icons.water_drop, '${day.day.avghumidity.round()}%', 'Humedad'),
      StatData(Icons.air, '${day.day.maxwindKph.round()} km/h', 'Viento máx'),
      StatData(Icons.grain, '${day.day.totalprecipMm} mm', 'Precipitación'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Detalles del día',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: stats.map((stat) => Expanded(
            child: _buildStatItem(stat),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildStatItem(StatData data) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(data.icon, color: Colors.white, size: 20),
          const SizedBox(height: 6),
          Text(
            data.value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            data.label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAstroInfo(Astro astro) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Información astronómica',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildAstroItem(Icons.wb_sunny, 'Amanecer', astro.sunrise),
              ),
              Expanded(
                child: _buildAstroItem(Icons.wb_twilight, 'Atardecer', astro.sunset),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildAstroItem(Icons.nightlight_round, 'Fase lunar', astro.moonPhase),
              ),
              Expanded(
                child: _buildAstroItem(Icons.brightness_3, 'Iluminación', '${astro.moonIllumination}%'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAstroItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white.withOpacity(0.8)),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHourlyForecast(List<Hour> hours) {
    // Mostrar solo algunas horas clave (cada 3 horas)
    final keyHours = hours.where((hour) {
      final time = DateTime.parse(hour.time);
      return time.hour % 3 == 0;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pronóstico por horas',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: keyHours.length,
            itemBuilder: (context, index) {
              final hour = keyHours[index];
              final time = DateTime.parse(hour.time);
              
              return Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(time),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Image.network(
                      "https:${hour.condition.icon}",
                      width: 20,
                      height: 20,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          hour.isDay == 1 ? Icons.wb_sunny : Icons.nightlight_round,
                          size: 20,
                          color: Colors.white,
                        );
                      },
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${hour.tempC.round()}°',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (hour.chanceOfRain > 0) ...[
                      const SizedBox(height: 2),
                      Text(
                        '${hour.chanceOfRain}%',
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Clase helper para datos estadísticos
class StatData {
  final IconData icon;
  final String value;
  final String label;

  StatData(this.icon, this.value, this.label);
}