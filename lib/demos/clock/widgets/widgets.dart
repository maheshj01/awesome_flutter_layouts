import 'package:awesome_flutter_layouts/demos/clock/constants/constants.dart';
import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final double size;
  final Color color;

  const Circle(this.size, {Key? key, this.color = black}) : super(key: key);

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
  final Function? onTap;

  const LeadingIconBuilder({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!.call(),
      child: Column(
        children: [
          Row(
            children: const [
              Circle(circle_radius),
              SizedBox(width: size_sm_4),
              Circle(circle_radius, color: pink),
            ],
          ),
          const SizedBox(height: size_sm_4),
          Row(
            children: const [
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
  final Widget icon;
  final String? label;
  final Color labelColor;
  final Color color;
  final Function? onTap;
  final double? size;

  const KIcon(this.icon,
      {Key? key,
      this.label,
      this.onTap,
      this.size,
      this.labelColor = black,
      this.color = Colors.white})
      : super(key: key);

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
          label == null
              ? const SizedBox()
              : Positioned(
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
