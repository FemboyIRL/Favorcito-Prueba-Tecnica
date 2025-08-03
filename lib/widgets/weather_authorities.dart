import 'package:favorcito/models/weather_authorities.dart';
import 'package:flutter/material.dart';

class WeatherAuthoritiesWidget extends StatefulWidget {
  final WeatherAuthoritiesModel authority;

  const WeatherAuthoritiesWidget({super.key, required this.authority});

  @override
  State<WeatherAuthoritiesWidget> createState() =>
      _WeatherAuthoritiesWidgetState();
}

class _WeatherAuthoritiesWidgetState extends State<WeatherAuthoritiesWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Información de texto
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Nombre de la autoridad
                Text(
                  widget.authority.name,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 3,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),

                // Descripción
                if (widget.authority.description != null)
                  Text(
                    widget.authority.description!,
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white.withOpacity(0.95),
                      fontWeight: FontWeight.w400,
                      height: 1,
                      shadows: const [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                const SizedBox(height: 12),

                // Indicador de acción
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Ver más',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Icono/Logo
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: _buildIconContainer(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconContainer() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: widget.authority.icon ?? _buildDefaultIcon(),
        ),
      ),
    );
  }

  Widget _buildDefaultIcon() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4FC3F7),
            Color(0xFF1E88E5),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Icon(
          Icons.cloud_outlined,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildPatternOverlay() {
    return Positioned.fill(
      child: CustomPaint(
        painter: AuthorityPatternPainter(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.authority.heroTag,
      child: Material(
        type: MaterialType.transparency,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                height: 230,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  onTapCancel: _onTapCancel,
                  onTap: () => widget.authority.onTap(context),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.black.withOpacity(_isPressed ? 0.1 : 0.15),
                          blurRadius: _isPressed ? 8 : 15,
                          offset: Offset(0, _isPressed ? 2 : 6),
                        ),
                        BoxShadow(
                          color: const Color(0xFF1E88E5).withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        children: [
                          // Imagen de fondo si existe
                          if (widget.authority.backgroundImage != null)
                            Positioned.fill(
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: widget.authority.backgroundImage!,
                              ),
                            ),

                          // Patrón decorativo
                          _buildPatternOverlay(),

                          // Contenido principal
                          _buildContent(),

                          // Brillo al presionar
                          if (_isPressed)
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Painter personalizado para el patrón de fondo
class AuthorityPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    // Círculos decorativos
    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.25),
      15,
      paint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.75),
      20,
      paint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.8),
      10,
      paint,
    );

    // Líneas curvas decorativas
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    path.moveTo(0, size.height * 0.3);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.1,
      size.width,
      size.height * 0.4,
    );

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Widget alternativo más compacto
class CompactWeatherAuthoritiesWidget extends StatelessWidget {
  final WeatherAuthoritiesModel authority;

  const CompactWeatherAuthoritiesWidget({super.key, required this.authority});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: authority.heroTag,
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          height: 120,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: InkWell(
            onTap: () => authority.onTap(context),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF42A5F5),
                    Color(0xFF1E88E5),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Icono
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: authority.icon ??
                          const Icon(
                            Icons.cloud_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                    ),

                    const SizedBox(width: 16),

                    // Información
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            authority.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (authority.description != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              authority.description!,
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Flecha
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white.withOpacity(0.8),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
