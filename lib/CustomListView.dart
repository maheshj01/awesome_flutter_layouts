import 'dart:convert';

import 'package:awesome_flutter_layouts/const/const.dart';
import 'package:awesome_flutter_layouts/const/strings.dart';
import 'package:awesome_flutter_layouts/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'const/const.dart';

class CustomListView extends StatefulWidget {
  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  var data;
  @override
  void initState() {
    super.initState();
    fetchRandomData();
  }

  void fetchRandomData() async {
    http.Response response = await http.get(RANDOM_URL);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      data = body["results"];
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _designerTab() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: isLoading == true
              ? showLoading()
              : ListView.builder(
                  itemCount: data.length, //total no of list items
                  itemBuilder: (BuildContext context, int currentItem) {
                    return DesignerCardWidget(
                      currentItem: currentItem,
                      name: data[currentItem]["name"]["first"].toString() +
                          " " +
                          data[currentItem]["name"]["last"].toString(),
                      avatarUrl: data[currentItem]["picture"]["medium"],
                      phone: data[currentItem]["phone"].toString(),
                    );
                  },
                ),
        ),
        FloatingSnackBar(
          text: 'Some Message in the snacbar',
          animationController: _animationController,
        )
      ],
    );
  }

  void show() {
    _animationController.reset();
    _animationController.forward();
  }

  AnimationController _animationController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              show();
            },
          ),
          body: Column(
            children: <Widget>[
              Container(
                  height: 80,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purpleAccent, Colors.purple],
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                            icon: const Icon(Icons.menu, color: Colors.white),
                            onPressed: () {})
                      ],
                    ),
                  )),
              Container(
                height: 50,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purpleAccent, Colors.purple],
                  ),
                ),
                child: TabBar(
                    tabs: List.generate(tabBarTitle.length, (index) {
                  return Tab(
                    child: Text(tabBarTitle[index]),
                  );
                })),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    _designerTab(),
                    Container(
                      color: Colors.green,
                      alignment: Alignment.center,
                      child: const Text('Yet to Build'),
                    ),
                    Container(
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: const Text('Build something Awesome'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class FloatingSnackBar extends StatefulWidget {
  FloatingSnackBar({Key key, this.text, this.animationController})
      : super(key: key);

  final String text;
  AnimationController animationController;

  @override
  FloatingSnackBarState createState() => FloatingSnackBarState();
}

class FloatingSnackBarState extends State<FloatingSnackBar>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  void _init() {
    if (widget.animationController != null) {
      widget.animationController = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 500));
      _animationController.addStatusListener((status) {
        if (_animationController.status == AnimationStatus.completed) {
          Future.delayed(const Duration(seconds: 2), () {
            _animationController.reverse();
          });
        }
      });
    }
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animationController.addStatusListener((status) {
      if (_animationController.status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 2), () {
          _animationController.reverse();
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  double getHeight() {
    if (widget.animationController != null) {
      return widget.animationController.value * 50;
    }
    return _animationController.value * 50;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (ctx, child) => Container(
        color: Colors.black,
        width: double.infinity,
        height: getHeight(),
        child: Text(
          widget.text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class DesignerCardWidget extends StatelessWidget {
  final int currentItem;
  final String name;
  final String avatarUrl;
  final String phone;
  final int popularity;
  final int ranking;

  const DesignerCardWidget(
      {Key key,
      this.currentItem,
      this.name,
      this.avatarUrl,
      this.phone,
      this.popularity,
      this.ranking})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors[currentItem % colors.length]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          const BoxShadow(
              color: Colors.black54, blurRadius: 3.5, offset: Offset(1.0, 2.0)),
        ],
      ),
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      height: MediaQuery.of(context).size.height / 4.5,
      child: Row(
        children: <Widget>[
          Expanded(
            //left half image avtar of listitem
            flex: 4,
            child: Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20, top: 15),
              child: CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl),
                radius: 30,
              ),
            ),
          ),
          Expanded(
            //center of listitem
            flex: 9,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.only(top: 20, left: 5),
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              name,
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(phone)
                          ],
                        ),
                      )),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                                child: Column(
                              children: <Widget>[
                                Text("$currentItem\43"),
                                Text("Popularity", style: subHeadingTextStyle)
                              ],
                            )),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                                child: Column(
                              children: <Widget>[
                                Text("$currentItem\433"),
                                Text(
                                  "Like",
                                  style: subHeadingTextStyle,
                                )
                              ],
                            )),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                                child: Column(
                              children: <Widget>[
                                Text("$currentItem\4333"),
                                Text(
                                  "Followed",
                                  style: subHeadingTextStyle,
                                )
                              ],
                            )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {},
                  ),
                  Text(
                    "$currentItem",
                    style: TextStyle(fontSize: 22),
                  ),
                  Text("Ranking")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
