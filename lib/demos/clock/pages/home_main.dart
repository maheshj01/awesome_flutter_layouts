import 'package:awesome_flutter_layouts/demos/clock/constants/constants.dart';
import 'package:awesome_flutter_layouts/demos/clock/pages/navigation/cart.dart';
import 'package:awesome_flutter_layouts/demos/clock/pages/navigation/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int index = 0;
  final Color selectedColor = pink;
  @override
  Widget build(BuildContext context) {
    final List<BottomNavBarItem> _items = [
      BottomNavBarItem(
        child:
            Icon(Icons.home, color: index == 0 ? selectedColor : Colors.white),
      ),
      BottomNavBarItem(
        child: Icon(Icons.favorite,
            color: index == 1 ? selectedColor : Colors.white),
      ),
      BottomNavBarItem(
        child: Icon(Icons.shopping_basket_rounded,
            color: index == 2 ? selectedColor : Colors.white),
      ),
      BottomNavBarItem(
        child: Icon(Icons.person,
            color: index == 3 ? selectedColor : Colors.white),
      ),
    ];
    return Theme(
      data: ThemeData(
          iconTheme:
              const IconThemeData(color: black, size: size_ex_lg_24 * 1.2),
          inputDecorationTheme: const InputDecorationTheme(iconColor: black),
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: pink,
              ),
          textTheme: TextTheme(
            displayMedium: GoogleFonts.montserrat(
                fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
            displaySmall: GoogleFonts.dmSans(
                fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
            headlineMedium: GoogleFonts.dmSans(
                fontSize: 18, fontWeight: FontWeight.bold, color: black),
            headlineSmall: GoogleFonts.dmSans(
                fontSize: 16, fontWeight: FontWeight.w500, color: pink),
          )),
      child: Material(
          child: Stack(
        children: [
          IndexedStack(
            index: index,
            children: [
              const Home(),
              Container(
                alignment: Alignment.center,
                color: Colors.accents[index],
                child: const Text('Favourate'),
              ),
              const Cart(),
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
                index: index,
                onChange: (x) {
                  setState(() {
                    index = x;
                  });
                },
                children: _items),
          )
        ],
      )),
    );
  }
}

class KBottomNavigation extends StatefulWidget {

  const KBottomNavigation(
      {required this.children, required this.index, Key? key,
      this.onChange,
      this.hasLabel = false,
      this.backgroundColor = black})
      : super(key: key);
  final List<BottomNavBarItem> children;
  final Function(int)? onChange;
  final bool hasLabel;
  final Color backgroundColor;

  /// selected index;
  final int index;

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
            child: Transform.scale(
              scale: i == widget.index ? 1.2 : 1,
              child: widget.children[i].child,
            ),
          )
      ]),
    );
  }
}

class BottomNavBarItem extends StatelessWidget {

  const BottomNavBarItem(
      {required this.child, Key? key, this.label, this.isSelected = false})
      : super(key: key);
  final String? label;
  final Widget child;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        child,
        if (label != null)
          Text(
            label!,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: isSelected ? Colors.white : Colors.white,
                ),
          ),
      ],
    );
  }
}
