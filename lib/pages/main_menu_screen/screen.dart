import 'package:favorcito/pages/main_menu_screen/state.dart';
import 'package:favorcito/utilities/delegates/header_child_sliver_list.dart';
import 'package:favorcito/widgets/empty_weather_widget.dart';
import 'package:favorcito/widgets/location_tile.dart';
import 'package:favorcito/widgets/weather_authorities.dart';
import 'package:favorcito/widgets/weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  Widget _persistentTitle() {
    return SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate: HeaderChildSliverList(
            maxSize: 60,
            minSize: 60,
            child: const Hero(
                tag: "prueba-tecnica",
                child: ColoredBox(
                    color: Colors.black,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(children: [
                          Text("FavWeather",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.white))
                        ]))))));
  }

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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainMenuState>(
      init: MainMenuState(),
      builder: (state) => Scaffold(
          key: key,
          body: CustomScrollView(
            controller: state.scrollController,
            slivers: [
              _persistentTitle(),
              _persistentSearchBarWithResults(state),
              SliverToBoxAdapter(
                child: state.selectedLocation != null
                    ? WeatherWidget(
                        weatherData: state.selectedLocation!,
                        isLoading: state.weatherLoader.value,
                      )
                    : const EmptyWeatherWidget(),
              ),
              SliverVisibility(
                  visible: !state.weatherLoader.value,
                  sliver: _operationsWidget(context: context, state: state)),
            ],
          )),
    );
  }
}
