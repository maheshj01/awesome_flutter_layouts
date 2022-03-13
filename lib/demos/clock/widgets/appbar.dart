import 'package:flutter/material.dart';

class ClockBar extends StatefulWidget {
  final Widget? title;
  final Widget? leading;
  final Widget? trailing;
  const ClockBar({Key? key, this.title, this.leading, this.trailing})
      : super(key: key);

  @override
  ClockBarState createState() => ClockBarState();
}

class ClockBarState extends State<ClockBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        widget.leading ?? const SizedBox(),
        widget.title ?? const SizedBox(),
        widget.trailing ?? const SizedBox(),
      ],
    );
  }
}
