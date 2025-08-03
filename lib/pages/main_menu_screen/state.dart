import 'package:favorcito/models.dart/current_wheater_model.dart';
import 'package:favorcito/models.dart/location.dart';
import 'package:favorcito/models.dart/weather_authorities.dart';
import 'package:favorcito/services/api_consumer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainMenuState extends GetxController {
  // resources
  final api = ApiConsumer(apiToken: "d2e1246a0ceb41bc87c235135250108");
  ScrollController scrollController = ScrollController();
  final searchController = TextEditingController();
  final searchValue = ''.obs;
  final locations = <LocationModel>[].obs;
  WeatherModel? selectedLocation;
  final searchBarLoader = false.obs;
  final weatherLoader = false.obs;

  final authorities = <WeatherAuthoritiesModel>[
    WeatherAuthoritiesModel(
        name: 'Servicio meteorológico nacional',
        description:
            'El SMN es el encargado de informar sobre el clima a escala nacional',
        backgroundImage: Image.asset("assets/images/SMN.png"),
        icon: Image.asset("assets/images/sistemameteorologiconacional.jpg"),
        heroTag: 'Servicio meteorológico nacional',
        onTap: (context) {}),
    WeatherAuthoritiesModel(
        name: 'NEXRAD',
        description:
            'NEXRAD detecta precipitaciones y movimientos atmosféricos o viento',
        backgroundImage: Image.asset("assets/images/nexrad.png"),
        icon: Image.asset("assets/images/nexradLogo.jpg"),
        heroTag: 'NEXRAD',
        onTap: (context) {})
  ];

  //methods

  void onLocationSelected(LocationModel location) async {
    // Scrollea al inicio de la pantalla
    scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);

    try {
      weatherLoader.value = true;
      final name = location.name;
      // Fetching de los datos de location.name
      final result = await api.getCurrentWeather(name);
      // Guardar los datos de la ubicacion seleccionada
      selectedLocation = result;
      // Cerramos
      clearSearch();
    } catch (e) {
      // Mostrar mensaje de error
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text("No se encontró la ubicación seleccionada"),
        ),
      );
    } finally {
      weatherLoader.value = false;
      update();
    }
  }

  void clearSearch() {
    searchController.clear();
    searchValue.value = '';
    locations.clear();
  }

  Future<void> onSearchUpdated(String query) async {
    searchValue.value = query;
    if (query.isEmpty) {
      locations.clear();
      return;
    }

    searchBarLoader.value = true;
    try {
      final results = await api.searchLocations(query);
      locations.assignAll(results);
    } finally {
      searchBarLoader.value = false;
    }
  }

  //disposal

  @override
  void dispose() {
    searchValue.close();
    searchBarLoader.close();
    weatherLoader.close();
    locations.close();
    super.dispose();
  }
}
