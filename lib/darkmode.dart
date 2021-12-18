import 'dart:math';
import 'package:flutter/material.dart';

class DarkTransition extends StatefulWidget {
  const DarkTransition({Key? key, this.title = 'Dark Transition'})
      : super(key: key);

  final String title;

  @override
  _DarkTransitionState createState() => _DarkTransitionState();
}

class _DarkTransitionState extends State<DarkTransition>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    _darkNotifier.dispose();
    super.dispose();
  }

  final _darkNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
  }

  double _radius(Size size) {
    final maxVal = max(size.width, size.height);
    return maxVal * 1.5;
  }

  late AnimationController _animationController;
  GlobalKey key = GlobalKey();
  double x = 0;
  double y = 0;
  bool isDark = false;

  ThemeData getTheme(bool dark) {
    if (dark)
      return ThemeData.dark();
    else
      return ThemeData.light();
  }

  void _updateCoOrdinates() {
    final RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);
    x = position.dx;
    y = position.dy;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _updateCoOrdinates();
    });
  }

  bool innerTheme = true;
  bool outerTheme = false;
  @override
  Widget build(BuildContext context) {
    isDark = _darkNotifier.value;
    final size = MediaQuery.of(context).size;
    final radius = _radius(size);
    innerTheme = !isDark;
    outerTheme = isDark;
    Widget _body(int index) {
      return ValueListenableBuilder<bool>(
          valueListenable: _darkNotifier,
          builder: (BuildContext context, bool isDark, Widget? child) {
            return Theme(
              data: index == 2 ? getTheme(innerTheme) : getTheme(outerTheme),
              child: Scaffold(
                appBar: AppBar(
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
                        isDark ? 'DarkMode' : 'LightMode',
                        style: const TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  heroTag: null,
                  key: index == 1 ? key : null,
                  onPressed: () {
                    if (x == 0 || y == 0) {
                      // prevent rerecomputing
                      _updateCoOrdinates();
                    }
                    isDark = _darkNotifier.value;
                    if (isDark) {
                      _animationController.reverse();
                      _darkNotifier.value = false;
                      outerTheme = false;
                    } else {
                      _animationController.reset();
                      _animationController.forward();
                      _darkNotifier.value = true;
                      innerTheme = true;
                    }
                  },
                  // tooltip: 'Increment',
                  child: Icon(_darkNotifier.value
                      ? Icons.wb_sunny_outlined
                      : Icons.bubble_chart),
                ),
              ),
            );
          });
    }

    return AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              _body(1),
              ClipPath(
                  clipper: CircularClipper(_animationController.value * radius,
                      Offset(x + 20, y + 20)),
                  child: _body(2)),
            ],
          );
        });
  }
}

class CircularClipper extends CustomClipper<Path> {
  const CircularClipper(this.radius, this.center);
  final double radius;
  final Offset center;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addOval(Rect.fromCircle(radius: radius, center: center));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
