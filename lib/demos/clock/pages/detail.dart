import 'package:awesome_flutter_layouts/demos/clock/constants/constants.dart';
import 'package:awesome_flutter_layouts/demos/clock/widgets/appbar.dart';
import 'package:awesome_flutter_layouts/demos/clock/widgets/carousel_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClockDetail extends StatefulWidget {
  final String heroTag;
  final ClockModel clock;
  const ClockDetail({Key? key, required this.heroTag, required this.clock})
      : super(key: key);

  @override
  ClockDetailState createState() => ClockDetailState();
}

class ClockDetailState extends State<ClockDetail> {
  int carouselIndex = 0;
  int carouselCount = 3;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.5,
              child: Stack(
                children: [
                  Hero(
                    tag: widget.heroTag,
                    child: PageView(
                      onPageChanged: (x) {
                        setState(() {
                          carouselIndex = x;
                        });
                      },
                      children: [
                        for (int i = 0; i < carouselCount; i++)
                          Container(
                            margin: const EdgeInsets.all(size_md_6),
                            height: size.height * 0.5,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(
                                        '$assetsPath/clock_home.png'),
                                    fit: BoxFit.cover),
                                borderRadius:
                                    BorderRadius.circular(circle_radius * 4)),
                          ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: size_md_6 * 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: size_lg_14, horizontal: size_md_6 * 3),
                        child: ClockBar(
                          leading: const BackButton(
                            color: Colors.white,
                          ),
                          trailing: Icon(CupertinoIcons.heart_fill,
                              color: Colors.white.withOpacity(0.69)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: size_md_6,
            ),
            CarouselIndicator(
              count: 3,
              currentIndex: carouselIndex,
            ),
            Padding(
              padding: const EdgeInsets.all(size_ex_lg_24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.clock.title,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    '\$${widget.clock.price}',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: pink),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: size_ex_lg_24),
                child: RatingsIndicator(
                  rating: widget.clock.rating,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: size_md_6 * 2, horizontal: size_ex_lg_24),
              child: Text(
                widget.clock.description,
                style: const TextStyle(height: 2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: size_ex_lg_24, vertical: size_lg_14),
              child: Row(
                children: [
                  KChip(
                    label: widget.clock.type.name,
                    category: 'Type',
                  ),
                  KChip(
                    label: widget.clock.material.name,
                    category: 'Material',
                  ),
                ],
              ),
            ),
            KButton(onTap: () {}, label: 'Add to cart')
          ],
        ),
      ),
    );
  }
}

class KButton extends StatefulWidget {
  final Function onTap;
  final String label;
  final double? width;
  final double? height;

  const KButton(
      {Key? key,
      required this.onTap,
      required this.label,
      this.height = size_ex_lg_24 * 3,
      this.width = 350})
      : super(key: key);

  @override
  _KButtonState createState() => _KButtonState();
}

class _KButtonState extends State<KButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size_ex_lg_24),
            )),
            elevation: MaterialStateProperty.all<double>(0),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
        onPressed: () => widget.onTap(),
        child: Text(
          widget.label,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class RatingsIndicator extends StatelessWidget {
  const RatingsIndicator(
      {Key? key, required this.rating, this.totalRatings = 10})
      : super(key: key);
  final int rating;
  final int totalRatings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 5; i++)
          Icon(Icons.star_sharp,
              size: 14, color: rating > i ? ratingsYellow : Colors.grey),
        const SizedBox(width: size_md_6),
        Text('$rating/5'),
        Text('($totalRatings)'),
      ],
    );
  }
}

enum Type { digital, analog }
enum ClockMaterial { plastic, metal }

class ClockModel {
  final String title;
  final String description;
  final String image;
  final int price;
  final Type type;
  final ClockMaterial material;
  final int rating;

  ClockModel(this.title, this.description,
      {this.price = 200,
      required this.rating,
      this.material = ClockMaterial.plastic,
      this.image = '$assetsPath/clock_dark_pink.png',
      this.type = Type.analog});
}

class KChip extends StatelessWidget {
  final String label;
  final String category;
  const KChip({Key? key, required this.label, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(fontSize: 14, color: lightGrey),
        ),
        Chip(
            backgroundColor: lightPink,
            label: Text(
              label,
              style: const TextStyle(color: pink),
            ))
      ],
    );
  }
}
