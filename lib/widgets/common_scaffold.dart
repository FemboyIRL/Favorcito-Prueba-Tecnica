import 'package:flutter/material.dart';

class WeatherCommonScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Future<void> Function()? onRefresh;
  final List<Widget>? appbarActions;
  final List<Widget> sliversChildren;
  final Widget? endDrawer;
  final Widget? floatingActionButton;
  final bool showBackButton;
  final bool hideWeatherHeader;
  final String? title;
  final Widget? customTitle;
  final bool showBottomNavigation;
  final int? currentBottomNavIndex;
  final Function(int)? onBottomNavTap;

  const WeatherCommonScaffold({
    super.key,
    this.scaffoldKey,
    this.onRefresh,
    this.appbarActions,
    required this.sliversChildren,
    this.endDrawer,
    this.floatingActionButton,
    this.showBackButton = true,
    this.hideWeatherHeader = false,
    this.title,
    this.customTitle,
    this.showBottomNavigation = false,
    this.currentBottomNavIndex,
    this.onBottomNavTap,
  });

  AppBar _buildAppBar(BuildContext context) {    
    return AppBar(
      automaticallyImplyLeading: showBackButton,
      elevation: 0,
      backgroundColor: const Color(0xFF1E88E5),
      foregroundColor: Colors.white,
      title: customTitle ?? _buildDefaultTitle(),
      actions: [
        ...?appbarActions,
        if (appbarActions?.isNotEmpty ?? false) const SizedBox(width: 8),
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E88E5),
              Color(0xFF1976D2),
              Color(0xFF1565C0),
            ],
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.3),
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultTitle() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.wb_sunny_outlined,
            size: 24,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title ?? 'FavWeather',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Pronóstico del tiempo',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white.withOpacity(0.8),
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1E88E5),
            Color(0xFF42A5F5),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: const Icon(
              Icons.cloud_outlined,
              size: 32,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'FavWeather',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                'Tu app de confianza para el clima',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherFooter() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF90CAF9),
            Color(0xFF64B5F6),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Datos meteorológicos',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Información proporcionada por servicios meteorológicos confiables.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withOpacity(0.9),
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          _buildWeatherSourcesRow(),
        ],
      ),
    );
  }

  Widget _buildWeatherSourcesRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSourceItem(Icons.satellite_alt, 'Satélites'),
        _buildSourceItem(Icons.radar, 'Radar'),
        _buildSourceItem(Icons.thermostat, 'Estaciones'),
      ],
    );
  }

  Widget _buildSourceItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    if (!showBottomNavigation) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1E88E5),
        unselectedItemColor: Colors.grey.shade600,
        currentIndex: currentBottomNavIndex ?? 0,
        onTap: onBottomNavTap,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            activeIcon: Icon(Icons.location_on),
            label: 'Ubicaciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule_outlined),
            activeIcon: Icon(Icons.schedule),
            label: 'Pronóstico',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8FAFE),
            Color(0xFFFFFFFF),
          ],
        ),
      ),
      child: CustomScrollView(
        slivers: [
          // Header del clima (opcional)
          if (!hideWeatherHeader)
            SliverToBoxAdapter(child: _buildWeatherHeader()),

          // Contenido principal
          ...sliversChildren,

          // Espaciado
          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          // Footer con información meteorológica
          SliverToBoxAdapter(child: _buildWeatherFooter()),

          // Espaciado final
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: _buildAppBar(context),
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: _buildBottomNavigation(),
      body: SafeArea(
        child: Scrollbar(
          child: onRefresh != null
              ? RefreshIndicator(
                  onRefresh: onRefresh!,
                  color: const Color(0xFF1E88E5),
                  backgroundColor: Colors.white,
                  child: _buildPageContent(),
                )
              : _buildPageContent(),
        ),
      ),
    );
  }
}

extension WeatherScaffoldExtensions on WeatherCommonScaffold {
  static Widget withBottomNav({
    required List<Widget> sliversChildren,
    required int currentIndex,
    required Function(int) onNavTap,
    String? title,
    List<Widget>? appbarActions,
    Future<void> Function()? onRefresh,
  }) {
    return WeatherCommonScaffold(
      sliversChildren: sliversChildren,
      showBottomNavigation: true,
      currentBottomNavIndex: currentIndex,
      onBottomNavTap: onNavTap,
      title: title,
      appbarActions: appbarActions,
      onRefresh: onRefresh,
    );
  }

  static Widget simple({
    required List<Widget> sliversChildren,
    String? title,
    List<Widget>? appbarActions,
    bool showBackButton = true,
    Future<void> Function()? onRefresh,
  }) {
    return WeatherCommonScaffold(
      sliversChildren: sliversChildren,
      title: title,
      appbarActions: appbarActions,
      showBackButton: showBackButton,
      onRefresh: onRefresh,
    );
  }
}