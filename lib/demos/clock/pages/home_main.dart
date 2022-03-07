import 'package:awesome_flutter_layouts/demos/clock/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigation/home.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    List<BottomNavBarItem> _items = const [
      BottomNavBarItem(
        child: Icon(CupertinoIcons.home, color: Colors.white),
      ),
      BottomNavBarItem(
        child: Icon(CupertinoIcons.heart, color: Colors.white),
      ),
      BottomNavBarItem(
        child: Icon(CupertinoIcons.bag, color: Colors.white),
      ),
      BottomNavBarItem(
        child: Icon(CupertinoIcons.person_fill, color: Colors.white),
      ),
    ];
    return Material(
        child: Stack(
      children: [
        IndexedStack(
          index: index,
          children: [
            Home(),
            Container(
              alignment: Alignment.center,
              color: Colors.accents[index],
              child: const Text('Favourate'),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.accents[index],
              child: const Text('Explore'),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.accents[index],
              child: const Text('Profile'),
            ),
          ],
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: KBottomNavigation(
              hasLabel: false,
              onChange: (x) {
                setState(() {
                  index = x;
                });
              },
              children: _items),
        )
      ],
    ));
  }
}

class KBottomNavigation extends StatefulWidget {
  final List<BottomNavBarItem> children;
  final Function(int)? onChange;
  final bool hasLabel;
  final Color backgroundColor;

  const KBottomNavigation(
      {Key? key,
      required this.children,
      this.onChange,
      this.hasLabel = false,
      this.backgroundColor = black})
      : super(key: key);

  @override
  _KBottomNavigationState createState() => _KBottomNavigationState();
}

class _KBottomNavigationState extends State<KBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      height: 70,
      decoration: BoxDecoration(
          borderRadius: defaultRadius * 2, color: widget.backgroundColor),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        for (int i = 0; i < widget.children.length; i++)
          GestureDetector(
            onTap: () {
              widget.onChange?.call(i);
            },
            child: Container(
              child: widget.children[i].child,
            ),
          )
      ]),
    );
  }
}

class BottomNavBarItem extends StatelessWidget {
  final String? label;
  final Widget child;
  final bool isSelected;

  const BottomNavBarItem(
      {Key? key, this.label, required this.child, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        child,
        if (label != null)
          Text(
            label!,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: isSelected ? Colors.white : Colors.white,
                ),
          ),
      ],
    );
  }
}
