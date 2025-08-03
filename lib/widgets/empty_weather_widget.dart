import 'package:flutter/material.dart';

class EmptyWeatherWidget extends StatelessWidget {
  final VoidCallback? onAddLocationPressed;

  const EmptyWeatherWidget({
    super.key,
    this.onAddLocationPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF90CAF9),
            Color(0xFF64B5F6),
            Color(0xFF42A5F5),
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
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icono principal
                  _buildMainIcon(),
                  const SizedBox(height: 24),

                  // Título principal
                  const Text(
                    '¡Bienvenido a FavWeather!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  // Descripción
                  Text(
                    'Para comenzar a ver el pronóstico del tiempo, busca tu ubicación.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Botón de acción
                  _buildActionButton(),
                  const SizedBox(height: 24),

                  // Características
                  _buildFeatures(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundPattern() {
    return Positioned.fill(
      child: CustomPaint(
        painter: EmptyStatePatternPainter(),
      ),
    );
  }

  Widget _buildMainIcon() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
      ),
      child: const Icon(
        Icons.location_on_outlined,
        size: 64,
        color: Colors.white,
      ),
    );
  }

  Widget _buildActionButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onAddLocationPressed,
        icon: const Icon(Icons.add_location_alt_outlined, size: 24),
        label: const Text(
          'Busca tu ubicación',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF1E88E5),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildFeatures() {
    return Column(
      children: [
        Text(
          'Con FavWeather puedes:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFeatureItem(
              icon: Icons.thermostat_outlined,
              label: 'Temperatura\nactual',
            ),
            _buildFeatureItem(
              icon: Icons.water_drop_outlined,
              label: 'Humedad y\nprecipitación',
            ),
            _buildFeatureItem(
              icon: Icons.air,
              label: 'Velocidad\ndel viento',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withOpacity(0.8),
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Painter personalizado para el patrón de fondo del estado vacío
class EmptyStatePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    // Círculos decorativos más suaves
    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.2),
      30,
      paint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.3),
      45,
      paint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.1, size.height * 0.7),
      35,
      paint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.8),
      20,
      paint,
    );

    // Líneas onduladas sutiles
    final wavePaint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    path.moveTo(0, size.height * 0.4);

    for (double x = 0; x <= size.width; x += 20) {
      path.quadraticBezierTo(
          x + 10, size.height * 0.4 + 10, x + 20, size.height * 0.4);
    }

    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Widget compacto alternativo para espacios más pequeños
class CompactEmptyWeatherWidget extends StatelessWidget {
  final VoidCallback? onAddLocationPressed;

  const CompactEmptyWeatherWidget({
    super.key,
    this.onAddLocationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF90CAF9),
            Color(0xFF42A5F5),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 48,
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          const Text(
            'Sin ubicación seleccionada',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Agrega una ubicación para ver el clima',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: onAddLocationPressed,
            icon: const Icon(Icons.add),
            label: const Text('Agregar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1E88E5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
