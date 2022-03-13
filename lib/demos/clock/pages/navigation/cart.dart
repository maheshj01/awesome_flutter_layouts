import 'package:awesome_flutter_layouts/demos/clock/constants/constants.dart';
import 'package:awesome_flutter_layouts/demos/clock/pages/detail.dart';
import 'package:flutter/material.dart';
import 'package:awesome_flutter_layouts/demos/clock/widgets/appbar.dart';
import 'package:awesome_flutter_layouts/demos/clock/widgets/widgets.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: size_md_6 * 3),
        child: Column(
          children: [
            const SizedBox(
              height: size_md_6 * 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: size_md_6),
              child: ClockBar(
                title: Text(
                  'Cart',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontSize: 20),
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: clocks.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: size_sm_4, vertical: size_md_6 * 2),
                        child: CartListTile(
                          clock: clocks[index],
                        ),
                      );
                    })),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(size_ex_lg_24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          '\$1072',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: pink,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  KButton(
                    width: 200,
                    onTap: () {},
                    label: 'Checkout',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CartListTile extends StatelessWidget {
  final ClockModel clock;
  const CartListTile({Key? key, required this.clock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size_ex_lg_24),
          color: Colors.white,
          boxShadow: [shadowLight]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: size_ex_lg_24 * 3,
              width: size_ex_lg_24 * 3,
              margin: const EdgeInsets.all(size_md_6 * 2),
              padding: const EdgeInsets.all(size_md_6 * 2),
              decoration: BoxDecoration(
                  color: clockGrey,
                  borderRadius: BorderRadius.circular(size_ex_lg_24 * 0.5)),
              child: Image.asset(clock.image)),
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: black),
                          children: [
                            TextSpan(text: '${clock.title}'),
                            TextSpan(
                                text: '   1x',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: Colors.grey))
                          ]),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text('\$${clock.price}',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: pink,
                              fontWeight: FontWeight.w700,
                            )),
                  ],
                ),
              ),
              SizedBox(
                  height: 50,
                  width: 50,
                  child: KIcon(
                      const Icon(Icons.delete, size: 20, color: Colors.grey),
                      onTap: () {}))
            ],
          )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
