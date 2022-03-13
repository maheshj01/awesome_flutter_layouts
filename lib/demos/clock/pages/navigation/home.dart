import 'package:awesome_flutter_layouts/demos/clock/constants/constants.dart';
import 'package:awesome_flutter_layouts/demos/clock/pages/detail.dart';
import 'package:awesome_flutter_layouts/demos/clock/widgets/appbar.dart';
import 'package:awesome_flutter_layouts/demos/clock/widgets/gridtile.dart';
import 'package:awesome_flutter_layouts/demos/clock/widgets/new_header.dart';
import 'package:awesome_flutter_layouts/demos/clock/widgets/search.dart';
import 'package:awesome_flutter_layouts/demos/clock/widgets/tabbar.dart';
import 'package:awesome_flutter_layouts/demos/clock/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String selected;
  @override
  void initState() {
    selected = tabs[0];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Material(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: size_md_6 * 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: size_lg_14, horizontal: size_md_6 * 3),
              child: ClockBar(
                leading: const LeadingIconBuilder(),
                trailing: KIcon(
                  Image.asset(
                    '$assetsPath/bell.png',
                    height: size_md_6 * 4,
                  ),
                  onTap: () {},
                  label: "24",
                ),
              ),
            ),
            SearchBuilder(
              hint: 'Search product',
              leadingIcon: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    '$assetsPath/search.jpg',
                    height: size_sm_4 * 8,
                  )),
              trailingIcon: Container(
                width: size_md_6 * 1.2,
                height: size_md_6 * 1.2,
                margin: const EdgeInsets.all(size_md_6),
                decoration: BoxDecoration(
                  color: pink,
                  borderRadius: BorderRadius.circular(size_sm_4 * 3),
                ),
                alignment: Alignment.center,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.tune,
                      color: Colors.white,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: size_lg_14 * 2),
              child: HorizontalTabBuilder(
                tabs: tabs,
                selected: selected,
                onChange: (x) {
                  setState(() {
                    selected = x;
                  });
                },
              ),
            ),
            NewArrivalsHeader(
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(size_ex_lg_24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Products 🔥',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'See All',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: pink),
                  )
                ],
              ),
            ),
            GridView.builder(
                shrinkWrap: true,
                itemCount: clocks.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                        horizontal: size_ex_lg_24, vertical: size_ex_lg_24) +
                    const EdgeInsets.only(
                        bottom: kBottomNavigationBarHeight * 1.5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 160 / 218,
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 6),
                itemBuilder: (_, index) {
                  return Hero(
                    tag: 'item $index',
                    child: KGridTile(
                      clock: clocks[index],
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ClockDetail(
                                  heroTag: 'item $index',
                                  clock: clocks[index],
                                )));
                      },
                    ),
                  );
                })
          ],
        ),
      )),
    );
  }
}
