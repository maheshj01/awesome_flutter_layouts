import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class Particle {
  double x;
  double y;
  double size;
  Color color;
  double speedX;
  double speedY;
  double alpha;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.color,
    required this.speedX,
    required this.speedY,
    required this.alpha,
  });
}

class ParticleData extends ChangeNotifier {
  List<Particle> particles = [];

  void createParticles(double x, double y) {
    const numberOfParticles = 50;
    for (int i = 0; i < numberOfParticles; i++) {
      final size = Random().nextDouble() * 5 + 2;
      final color = Color.fromRGBO(
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        1,
      );
      final speedX = Random().nextDouble() * 4 - 2;
      final speedY = Random().nextDouble() * 4 - 2;
      particles.add(
        Particle(
          x: x,
          y: y,
          size: size,
          color: color,
          speedX: speedX,
          speedY: speedY,
          alpha: 1,
        ),
      );
    }
    notifyListeners();
  }

  void updateParticles() {
    for (int i = 0; i < particles.length; i++) {
      particles[i].x += particles[i].speedX;
      particles[i].y += particles[i].speedY;
      particles[i].alpha -= 0.02;

      if (particles[i].alpha <= 0) {
        particles.removeAt(i);
        i--; // Adjust index after removal
      }
    }
    notifyListeners();
  }
}

class ParticleAnimationPage extends StatefulWidget {
  const ParticleAnimationPage({super.key});

  @override
  State<ParticleAnimationPage> createState() => _ParticleAnimationPageState();
}

class _ParticleAnimationPageState extends State<ParticleAnimationPage>
    with TickerProviderStateMixin {
  late Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      Provider.of<ParticleData>(context, listen: false).updateParticles();
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) {
          Provider.of<ParticleData>(
            context,
            listen: false,
          ).createParticles(details.localPosition.dx, details.localPosition.dy);
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: CustomPaint(
            painter: ParticlePainter(
              particles: Provider.of<ParticleData>(context).particles,
            ),
          ),
        ),
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final paint =
          Paint()
            ..color = particle.color.withOpacity(particle.alpha)
            ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(particle.x, particle.y), particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) {
    return true;
  }
}
