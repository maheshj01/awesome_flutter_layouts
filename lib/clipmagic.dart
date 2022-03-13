import 'package:flutter/material.dart';

class ClipPathTorchEffect extends StatefulWidget {
  const ClipPathTorchEffect({Key? key, this.title = 'Flutter Torch Effect'})
      : super(key: key);
  final String title;

  @override
  _ClipPathTorchEffectState createState() => _ClipPathTorchEffectState();
}

class _ClipPathTorchEffectState extends State<ClipPathTorchEffect> {
  void _updateLocation(PointerEvent details) {
    _offsetNotifier.value = Offset(details.position.dx, details.position.dy);
  }

  final _offsetNotifier = ValueNotifier<Offset>(const Offset(100, 100));

  @override
  void dispose() {
    // TODO: implement dispose
    _offsetNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.9),
        body: ValueListenableBuilder<Offset>(
            valueListenable: _offsetNotifier,
            builder: (
              BuildContext context,
              Offset offset,
              Widget? child,
            ) {
              return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onHover: _updateLocation,
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      Opacity(opacity: 0.5, child: ImageWidget()),
                      ClipPath(
                          clipper: CircleClipper(
                            center: Offset(offset.dx, offset.dy),
                            radius: 100,
                          ),
                          child: const CounterApp()),
                    ],
                  ));
            }));
  }
}

class ImageWidget extends StatelessWidget {
  ImageWidget({Key? key}) : super(key: key);
  String image2 =
      'https://images.unsplash.com/photo-1593642634402-b0eb5e2eebc9?ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2938&q=80';

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image2,
      fit: BoxFit.fitHeight,
    );
  }
}

class CounterApp extends StatefulWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'Clip Magic',
        onPressed: () {
          setState(() {
            counter += 1;
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  final Offset center;
  final double radius;

  CircleClipper({required this.center, required this.radius});

  @override
  Path getClip(Size size) {
    return Path()..addOval(Rect.fromCircle(radius: radius, center: center));
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
