import 'package:favorcito/pages/main_menu_screen/state.dart';
import 'package:favorcito/widgets/common_scaffold.dart';
import 'package:favorcito/widgets/empty_weather_widget.dart';
import 'package:favorcito/widgets/forecast_widget.dart';
import 'package:favorcito/widgets/location_tile.dart';
import 'package:favorcito/widgets/weather_authorities.dart';
import 'package:favorcito/widgets/weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  Widget _persistentSearchBarWithResults(final MainMenuState state) {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Column(
            children: [
              SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SearchBar(
                    controller: state.searchController,
                    onChanged: state.onSearchUpdated,
                    hintText: "España, Londres, Tijuana...",
                    trailing: const [Icon(Icons.search, size: 35)],
                  ),
                ),
              ),
              Obx(() => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: state.searchBarLoader.value
                        ? const SizedBox(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [CircularProgressIndicator()],
                            ))
                        : state.locations.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.locations.length,
                                itemBuilder: (context, index) => LocationTile(
                                  location: state.locations[index],
                                  onTap: () => state.onLocationSelected(
                                      state.locations[index]),
                                ),
                              )
                            : state.searchValue.value.isNotEmpty
                                ? const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text("No se encontraron resultados"),
                                  )
                                : const SizedBox.shrink(),
                  )),
            ],
          ),
        ]),
      ),
    );
  }

  Widget _operationsWidget(
      {required final BuildContext context,
      required final MainMenuState state}) {
    return SliverList.separated(
        itemCount: state.authorities.length,
        itemBuilder: (context, index) => (item) {
              return WeatherAuthoritiesWidget(
                authority: item,
              );
            }(state.authorities[index]),
        separatorBuilder: (context, index) => const SizedBox(height: 10));
  }

  Row _buttons(MainMenuState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Opacity(
          opacity: state.selectedButton == 1 ? 1.0 : 0.5,
          child: DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(state.selectedButton == 1 ? .2 : .0),
                  blurRadius: 4.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              onPressed: () => state.selectButton(1),
              child: Text(
                "Diario",
                style: TextStyle(
                  color: state.selectedButton == 1 ? Colors.black : Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: state.selectedButton == 2 ? 1.0 : 0.5,
          child: DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(state.selectedButton == 2 ? 0.2 : 0),
                  blurRadius: 4.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              onPressed: () => state.selectButton(2),
              child: Text(
                "Semanal",
                style: TextStyle(
                  color: state.selectedButton == 2 ? Colors.black : Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainMenuState>(
        init: MainMenuState(),
        builder: (state) => WeatherCommonScaffold(
              key: key,
              sliversChildren: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: _buttons(state),
                  ),
                ),
                _persistentSearchBarWithResults(state),
                SliverToBoxAdapter(
                    child: state.selectedLocation == null
                        ? const EmptyWeatherWidget()
                        : state.selectedLocation != null &&
                                state.selectedButton == 1
                            ? WeatherWidget(
                                weatherData: state.selectedLocation!,
                                isLoading: state.weatherLoader.value)
                            : state.forecast != null
                                ? ForecastWidget(
                                    forecastData: state.forecast!,
                                    isLoading: state.weatherLoader.value)
                                : null),
                SliverVisibility(
                    visible: !state.weatherLoader.value,
                    sliver: _operationsWidget(context: context, state: state)),
              ],
            ));
  }
}
