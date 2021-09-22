import 'dart:math';
import 'package:flutter/material.dart';

class DarkTransition extends StatefulWidget {
  DarkTransition({Key? key, this.title = 'Dark Transition'}) : super(key: key);

  final String title;

  @override
  _DarkTransitionState createState() => _DarkTransitionState();
}

class _DarkTransitionState extends State<DarkTransition>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    // TODO: implement dispose
    _darkNotifier.dispose();
    super.dispose();
  }

  final _darkNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animationController.forward();
  }

  double diagonal(Size size) {
    return pow(pow(size.width, 2) + pow(size.width, 2), 0.5) as double;
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

  @override
  Widget build(BuildContext context) {
    isDark = _darkNotifier.value;
    final size = MediaQuery.of(context).size;
    final radius = diagonal(size);

    Widget _body(int index) {
      return ValueListenableBuilder<bool>(
          valueListenable: _darkNotifier,
          builder: (BuildContext context, bool isDark, Widget? child) {
            return Theme(
              data: index == 2
                  ? getTheme(_darkNotifier.value)
                  : getTheme(!_darkNotifier.value),
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
                        !_darkNotifier.value ? 'DarkMode' : 'LightMode',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  heroTag: null,
                  key: index == 1 ? key : null,
                  onPressed: () {
                    _darkNotifier.value = !_darkNotifier.value;
                    final RenderBox box =
                        key.currentContext!.findRenderObject() as RenderBox;
                    Offset position = box.localToGlobal(Offset.zero);
                    x = position.dx;
                    y = position.dy;
                    _animationController.reset();
                    _animationController.forward();
                    isDark = _darkNotifier.value;
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
              _body(2),
              ClipPath(
                  clipper: CircularClipper(_animationController.value * radius,
                      Offset(x + 20, y + 20)),
                  child: _body(1)),
            ],
          );
        });
  }
}

class CircularClipper extends CustomClipper<Path> {
  final double radius;
  final Offset center;

  CircularClipper(this.radius, this.center);

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
