import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: isDark ? _darkGradient() : _lightGradient(),
      ),
      child: Stack(
        children: [
          // Additional radial gradient for light mode
          if (!isDark)
            Container(
              decoration: BoxDecoration(
                gradient: _lightRadialGradient(),
              ),
            ),
          // Subtle pattern overlay
          _buildPattern(context, isDark),
          // Main content
          child,
        ],
      ),
    );
  }

  LinearGradient _darkGradient() {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF0A0A0A), // Dark background
        Color(0xFF1A1A1A), // Slightly lighter
        Color(0xFF0F0F0F), // Dark background variant
        Color(0xFF1F1F1F), // Additional depth
      ],
      stops: [0.0, 0.3, 0.7, 1.0],
    );
  }

  LinearGradient _lightGradient() {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFE8E8E8), // Subtle gray start
        Color(0xFFF5F5F5), // Light gray
        Color(0xFFFFFFFF), // Pure white
        Color(0xFFF0F0F0), // Slightly darker end
      ],
      stops: [0.0, 0.3, 0.7, 1.0],
    );
  }

  // Add radial gradient overlay for more depth
  RadialGradient _lightRadialGradient() {
    return RadialGradient(
      center: Alignment.topRight,
      radius: 1.5,
      colors: [
        const Color(0xFFFF6B35).withOpacity(0.02), // Subtle orange tint
        Colors.transparent,
      ],
      stops: const [0.0, 1.0],
    );
  }

  Widget _buildPattern(BuildContext context, bool isDark) {
    return Positioned.fill(
      child: CustomPaint(
        painter: PatternPainter(isDark: isDark),
      ),
    );
  }
}

class PatternPainter extends CustomPainter {
  final bool isDark;

  PatternPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark
          ? Colors.white.withOpacity(0.02)
          : Colors.black.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    // Create a subtle dot pattern
    const double spacing = 40.0;
    const double dotRadius = 1.0;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(
          Offset(x + spacing / 2, y + spacing / 2),
          dotRadius,
          paint,
        );
      }
    }

    // Add some subtle lines
    final linePaint = Paint()
      ..color = isDark
          ? Colors.white.withOpacity(0.01)
          : Colors.black.withOpacity(0.03)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Diagonal lines
    for (double i = -size.height; i < size.width; i += 80) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FloatingShapesWidget extends StatefulWidget {
  final Widget child;

  const FloatingShapesWidget({
    super.key,
    required this.child,
  });

  @override
  State<FloatingShapesWidget> createState() => _FloatingShapesWidgetState();
}

class _FloatingShapesWidgetState extends State<FloatingShapesWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Floating shapes
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: FloatingShapesPainter(
                animation: _animation.value,
                isDark: Theme.of(context).brightness == Brightness.dark,
              ),
              size: Size.infinite,
            );
          },
        ),
        // Main content
        widget.child,
      ],
    );
  }
}

class FloatingShapesPainter extends CustomPainter {
  final double animation;
  final bool isDark;

  FloatingShapesPainter({required this.animation, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark
          ? const Color(0xFFFF6B35).withOpacity(0.03)
          : const Color(0xFFFF6B35).withOpacity(0.08)
      ..style = PaintingStyle.fill;

    // Create floating circles
    final shapes = [
      {'x': 0.8, 'y': 0.2, 'radius': 60.0, 'speed': 0.5},
      {'x': 0.2, 'y': 0.7, 'radius': 40.0, 'speed': 0.3},
      {'x': 0.9, 'y': 0.8, 'radius': 30.0, 'speed': 0.7},
      {'x': 0.1, 'y': 0.3, 'radius': 50.0, 'speed': 0.4},
    ];

    for (final shape in shapes) {
      final x = (shape['x'] as double) * size.width;
      final y = (shape['y'] as double) * size.height +
          (animation * (shape['speed'] as double) * 100) % 100;
      final radius = shape['radius'] as double;

      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
