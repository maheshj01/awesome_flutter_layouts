import 'package:awesome_flutter_layouts/demos/clock/constants/constants.dart';
import 'package:flutter/material.dart';

class NewArrivalsHeader extends StatefulWidget {
  final Function? onTap;
  const NewArrivalsHeader({Key? key, this.onTap}) : super(key: key);

  @override
  _NewArrivalsHeaderState createState() => _NewArrivalsHeaderState();
}

class _NewArrivalsHeaderState extends State<NewArrivalsHeader> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => widget.onTap!.call(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: size_md_6 * 3,
              ),
              child: Container(
                height: 160,
                margin: const EdgeInsets.symmetric(horizontal: size_ex_lg_24),
                decoration: BoxDecoration(
                  color: pink,
                  borderRadius: BorderRadius.circular(size_sm_4 * 8),
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: size_ex_lg_24 * 2,
              child: Text('New\nArrivals',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2),
            ),
            Positioned(
                top: 0,
                right: size_md_6 * 4,
                child: Image.asset(
                  '$assetsPath/clock_dark.png',
                  height: 160,
                ))
          ],
        ));
  }
}
