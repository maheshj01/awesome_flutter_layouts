import 'package:flutter/material.dart';

class Typewriter extends StatefulWidget {
  @override
  _TypewriterState createState() => _TypewriterState();
}

class _TypewriterState extends State<Typewriter>
    with SingleTickerProviderStateMixin {
  String animatedText = "";
  final String text =
      "Lorem Ipsum is simply dummy text of the prdoubleing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.. comes from a line in section 1.10.32.";

  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 10000),
    );
    textAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: (text.length - 1).toDouble()),
          weight: 40.0,
        ),
        //   TweenSequenceItem<double>(
        //     tween: ConstantTween<double>(10.0),
        //     weight: 20.0,
        //   ),
        //   TweenSequenceItem<double>(
        //     tween: Tween<double>(begin: 10.0, end: 5.0)
        //         .chain(CurveTween(curve: Curves.ease)),
        //     weight: 40.0,
        //   ),
      ],
    ).animate(animationController);
  }

  Animation<double> textAnimation;
  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double start = 0;
    double end = (text.length - 1).toDouble();

    return Scaffold(
        backgroundColor: Colors.indigo,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: AnimatedBuilder(
                animation: textAnimation,
                builder: (ctx, child) {
                  animatedText += text[textAnimation.value.toInt()];
                  return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${textAnimation.value.toInt()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 20,
                          ),
                          // Text(animatedText,
                          //     style: TextStyle(color: Colors.white)),
                          // TweenAnimationBuilder<int>(
                          //     tween: Tween(begin: 0, end: 100000000),
                          //     duration: Duration(seconds: 5),
                          //     builder: (ctx, value, child) {
                          //       return Text(
                          //         '$value',
                          //         style: TextStyle(color: Colors.white),
                          //       );
                          //     }),
                        ]),
                  );
                })),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              if (animationController.isAnimating) {
                animationController.stop();
              } else {
                if (animationController.status == AnimationStatus.completed) {
                  animatedText = '';
                  setState(() {});
                  animationController.reset();
                  animationController.forward();
                } else {
                  animationController.forward();
                }
              }
            },
            tooltip: 'Increment',
            child: AnimatedIcon(
                icon: AnimatedIcons.play_pause, progress: textAnimation),
          ),
        ]));
  }
}
