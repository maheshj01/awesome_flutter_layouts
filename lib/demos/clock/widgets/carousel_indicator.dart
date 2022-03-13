import 'package:awesome_flutter_layouts/demos/clock/constants/constants.dart';
import 'package:flutter/material.dart';

class CarouselIndicator extends StatefulWidget {
  const CarouselIndicator(
      {Key? key,
      this.width = 20,
      this.height = 4,
      required this.count,
      required this.currentIndex})
      : super(key: key);

  final double width;
  final double height;
  final int count;
  final int currentIndex;

  @override
  _CarouselIndicatorState createState() => _CarouselIndicatorState();
}

class _CarouselIndicatorState extends State<CarouselIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < widget.count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: widget.height,
            margin: const EdgeInsets.symmetric(horizontal: size_sm_4),
            width: i == widget.currentIndex ? widget.width * 1.5 : widget.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size_md_6),
              color: i == widget.currentIndex ? pink : Colors.grey,
            ),
          )
      ],
    );
  }
}