import 'package:favorcito/pages/main_menu_screen/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const FavWeatherApp());
}

class FavWeatherApp extends StatelessWidget {
  const FavWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "FavWeather - Prueba Tecnica",
      theme: ThemeData(
        // Esquema de colores de la app
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5), // Azul principal
          brightness: Brightness.light,
          primary: const Color(0xFF1E88E5),
          primaryContainer: const Color(0xFF4FC3F7),
          secondary: const Color(0xFF42A5F5),
          secondaryContainer: const Color(0xFF90CAF9),
          tertiary: const Color(0xFF29B6F6),
          surface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: const Color(0xFF1A1C1E),
        ),

        // Fondo principal con degradado sutil
        scaffoldBackgroundColor: const Color(0xFFF8FAFE),

        // Configuración general
        brightness: Brightness.light,
        useMaterial3: true,

        // AppBar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E88E5),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),

        // Botones elevados
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E88E5),
            foregroundColor: Colors.white,
            textStyle:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            shadowColor: const Color(0xFF1E88E5).withOpacity(0.3),
          ),
        ),

        // Botones de texto
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF1E88E5),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),

        // Cards 
        cardTheme: CardTheme(
          color: Colors.white,
          shadowColor: const Color(0xFF1E88E5).withOpacity(0.1),
          surfaceTintColor: Colors.white,
          elevation: 4,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        // Checkbox theme
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const Color(0xFF1E88E5);
            }
            return Colors.white;
          }),
          checkColor: WidgetStateProperty.all(Colors.white),
          side: const BorderSide(color: Color(0xFF1E88E5), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        // Switch theme
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            }
            return const Color(0xFF90A4AE);
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const Color(0xFF1E88E5);
            }
            return const Color(0xFFE0E0E0);
          }),
        ),

        // Divider theme
        dividerTheme: DividerThemeData(
          color: const Color(0xFF1E88E5).withOpacity(0.2),
          thickness: 1,
        ),

        // Input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                BorderSide(color: const Color(0xFF1E88E5).withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                BorderSide(color: const Color(0xFF1E88E5).withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),

        // Bottom navigation bar theme
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF1E88E5),
          unselectedItemColor: Color(0xFF90A4AE),
          elevation: 8,
          type: BottomNavigationBarType.fixed,
        ),

        // Floating action button theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF1E88E5),
          foregroundColor: Colors.white,
          elevation: 6,
        ),

        // Progress indicator theme
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFF1E88E5),
          linearTrackColor: Color(0xFFE3F2FD),
          circularTrackColor: Color(0xFFE3F2FD),
        ),
      ),
      home: const MainMenuScreen(),
    );
  }
}
