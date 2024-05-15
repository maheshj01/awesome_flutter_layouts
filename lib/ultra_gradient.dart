import 'dart:ui';

import 'package:flutter/material.dart';

import 'main.dart';

class UltraGradientDemo extends StatefulWidget {
  const UltraGradientDemo({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  State<UltraGradientDemo> createState() => _UltraGradientDemoState();
}

class _UltraGradientDemoState extends State<UltraGradientDemo> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class BackgroundWidget extends StatefulWidget {
  const BackgroundWidget({required this.child, super.key});
  final Widget child;

  @override
  State<BackgroundWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 6));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeStatusListener((status) {});
    _controller.dispose();

    super.dispose();
  }

  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: BackgroundPainter(
                      _animation, fragmentProgram.fragmentShader()),
                  child: Container(),
                );
              }),
          BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: Container(
                color: Colors.black.withOpacity(0.1),
              )),
          widget.child,
        ],
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  BackgroundPainter(this.animation, this.shader);
  Offset getOffset(Path path) {
    final pms = path.computeMetrics(forceClosed: false).elementAt(0);
    final length = pms.length;
    final offset = pms.getTangentForOffset(length * animation.value)!.position;
    return offset;
  }

  final Animation<double> animation;
  final FragmentShader shader;

  // Offset getOffset(Path path) {
  //   final pms = path.computeMetrics(forceClosed: false).elementAt(0);
  //   final length = pms.length;
  //   final offset = pms.getTangentForOffset(length * animation.value)!.position;
  //   return offset;
  // }

  void drawSquare(Canvas canvas, Size size, Paint paint1) {
    paint1.color = Colors.blue.shade300;
    paint1.maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);
    paint1.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(size.width * 0.75, 100),
            width: 300,
            height: 300,
          ),
          const Radius.circular(20),
        ),
        paint1);
  }

  void drawEllipse(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    paint.color = Colors.purple;
    paint.style = PaintingStyle.stroke;
    path.moveTo(size.width * 0.4, -100);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.6,
        size.width * 1.2, size.height * 0.4);
    // canvas.drawPath(path, paint);

    paint.style = PaintingStyle.fill;
    canvas.drawOval(
        Rect.fromCenter(
          center: getOffset(path),
          width: 450,
          height: 250,
        ),
        paint);
  }

  void drawTriangle(Canvas canvas, Size size, paint) {
    paint.color = Colors.green;
    final path = Path();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 10.0;
    path.moveTo(-100.0, size.height * 0.5);
    path.quadraticBezierTo(
        300, size.height * 0.7, size.width, size.height * 1.2);
    // canvas.drawPath(path, paint);
    paint.style = PaintingStyle.fill;

    // draw triangle
    final offset = getOffset(path);
    canvas.drawPath(
        Path()
          ..moveTo(offset.dx, offset.dy)
          ..lineTo(offset.dx + 450, offset.dy + 150)
          ..lineTo(offset.dx + 250, offset.dy - 500)
          ..close(),
        paint);
  }

  void drawCircle(Canvas canvas, Size size, Paint paint) {
    paint.color = Colors.orange;
    final Path path = Path();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 10.0;
    path.moveTo(size.width * 1.1, size.height / 4);
    path.quadraticBezierTo(
        size.width / 2, size.height * 1.0, -100, size.height / 4);
    // canvas.drawPath((path), paint);
    paint.style = PaintingStyle.fill;
    final offset = getOffset(path);
    canvas.drawCircle(offset, 150, paint);
  }

  void drawAbstractShapes(Canvas canvas, Size size, Paint paint) {
    final Path path = Path();
    path.moveTo(size.width * 1.2, 0);
    path.quadraticBezierTo(
        size.width * 1.2, 300, size.width * 0.4, size.height * 0.6);
    path.quadraticBezierTo(
        size.width * 0.1, size.height * 0.7, -100, size.height * 1.2);
    path.lineTo(-50, -50);
    path.close();
    paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);
    canvas.drawPath(
        path,
        paint
          ..color = Colors.purple.shade200
          ..style = PaintingStyle.fill);
    drawSquare(canvas, size, paint);
  }

  void drawContrastingBlobs(Canvas canvas, Size size, Paint paint) {
    paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);
    paint.blendMode = BlendMode.overlay;
    drawCircle(canvas, size, paint);
    drawTriangle(canvas, size, paint);
    drawEllipse(canvas, size, paint);
  }

  void paintBackground(Canvas canvas, Size size, Paint paint) {
    canvas.drawRect(
        Rect.fromCenter(
          center: Offset(size.width * 0.5, size.height * 0.5),
          width: size.width,
          height: size.height,
        ),
        paint..color = Colors.black);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // Set color information as uniforms in the shader
//     shader.setFloat(0, size.width);
//     shader.setFloat(1, size.height);
//     shader.setFloat(
//         2, paint.color.red / 255.0); // Red component normalized to [0, 1]
//     shader.setFloat(
//         3, paint.color.green / 255.0); // Green component normalized to [0, 1]
//     shader.setFloat(
//         4, paint.color.blue / 255.0); // Blue component normalized to [0, 1]
// // Create shader from the fragment shader
//     paint.shader = shader;
    // Use shaderPaint for drawing background and shapes
    paintBackground(canvas, size, paint);
    drawAbstractShapes(
        canvas, size, paint); // Use shaderPaint for drawing shapes
    drawContrastingBlobs(
        canvas, size, paint); // Use shaderPaint for drawing shapes
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
