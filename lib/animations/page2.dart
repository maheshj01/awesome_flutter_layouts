import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> with SingleTickerProviderStateMixin {
  Widget searchField() {
    return TextField(
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }

  AnimationController _backgroundController;
  Animation<Color> background;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    background = ColorTween(
      begin: Colors.orange,
      end: Colors.blueAccent,
    ).animate(_backgroundController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _backgroundController.reverse().whenComplete(() {
            _backgroundController.reset();
            _backgroundController.forward();
          });
        }
      });
    _backgroundController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedBuilder(
        animation: background,
        builder: (context, child) => Container(
          color: background.value,
          child: Center(
            child: Text(
              'Color Tween',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),

        //TODO:
        /// COLOR BACKGROUND ANIMATION
        /// TEXT WRITING ANIMATION
        /// TIMER ANIMATION
        /// DONE: SCREEN TRANSITION ANIMATION
        /// BOX ROTATION,TRANSLATE AND SCALE ANIMATION
      ),
    );
  }
}

// PageRouteBuilder(
//   pageBuilder: (context, animation, secondaryAnimation) => Page2(),
//   transitionsBuilder: (context, animation, secondaryAnimation, child) {
//     var begin = Offset(0.0, 1.0);
//     var end = Offset.zero;
//     var curve = Curves.ease;

//     var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//     return SlideTransition(
//       position: animation.drive(tween),
//       child: child,
//     );
//   },
// );}
