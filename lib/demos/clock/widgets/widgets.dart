import 'package:awesome_flutter_layouts/demos/clock/constants/constants.dart';
import 'package:flutter/material.dart';

class Circle extends StatelessWidget {

  const Circle(this.size, {Key? key, this.color = black}) : super(key: key);
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class LeadingIconBuilder extends StatelessWidget {

  const LeadingIconBuilder({Key? key, this.onTap}) : super(key: key);
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!.call(),
      child: const Column(
        children: [
          Row(
            children: [
              Circle(circle_radius),
              SizedBox(width: size_sm_4),
              Circle(circle_radius, color: pink),
            ],
          ),
          SizedBox(height: size_sm_4),
          Row(
            children: [
              Circle(circle_radius),
              SizedBox(width: size_sm_4),
              Circle(circle_radius),
            ],
          )
        ],
      ),
    );
  }
}

class KIcon extends StatelessWidget {

  const KIcon(this.icon,
      {Key? key,
      this.label,
      this.onTap,
      this.size,
      this.labelColor = black,
      this.color = Colors.white})
      : super(key: key);
  final Widget icon;
  final String? label;
  final Color labelColor;
  final Color color;
  final Function? onTap;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size,
              width: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: color,
                  boxShadow: [shadowLight],
                  borderRadius: BorderRadius.circular(size_sm_4 * 2)),
              padding: const EdgeInsets.all(size_sm_4 * 2),
              child: icon,
            ),
          ),
          if (label == null) const SizedBox() else Positioned(
                  left: size_md_6 * 5,
                  top: size_sm_4,
                  child: Container(
                      alignment: Alignment.center,
                      height: size_md_6 * 3,
                      width: size_md_6 * 3,
                      decoration: BoxDecoration(
                          color: labelColor, shape: BoxShape.circle),
                      child: Text(
                        label!,
                        style: const TextStyle(
                            color: Colors.white, fontSize: size_md_6 * 1.8),
                      )),
                ),
        ],
      ),
    );
  }
}
