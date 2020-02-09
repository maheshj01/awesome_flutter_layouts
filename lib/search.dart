import 'dart:convert';

import 'package:awesome_flutter_layouts/bloc/userbloc.dart';
import 'package:awesome_flutter_layouts/const.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'models/usermodel.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> tabBarTitle = ['Fruits', 'Vegetables', 'Nuts & Seeds', 'Dairy'];

  int selectedTab = 2;

  ScrollController _controller = ScrollController();
  ScrollController _controller1 = ScrollController();

  var data;
  Future<void> fetchRandomUsers() async {
    http.Response response = await http.get(RANDOM_URL);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      final Iterable list = body["results"];
      // map each json object to model and addto list and return the list of models
      final List<RandomUserModel> userList =
          list.map((model) => RandomUserModel.fromJson(model)).toList();
      userBloc.userController.sink.add(userList);
    }
  }

  Future<void> getFilteredList() async {}

  Widget _vegetablesWidget() {
    return Center(
      child: Text('Vegetable Widgets'),
    );
  }

  Widget _nutsWidget() {
    return Center(
      child: Text('Nuts & Seeds Widgets'),
    );
  }

  Widget _dairyWidget() {
    return Center(
      child: Text('DAIRY Widget'),
    );
  }

  Widget usersWidget() {
    return StreamBuilder(
        stream: userBloc.userController.stream,
        builder: (BuildContext buildContext,
            AsyncSnapshot<List<RandomUserModel>> snapshot) {
          if (snapshot == null) {
            return CircularProgressIndicator();
          }
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _fruitWidget(snapshot: snapshot);
        });
  }

  Widget _showAd() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 200,
      decoration: BoxDecoration(
          color: materialColors[5], borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.center,
      child: Text('Ad'),
    );
  }

  Widget _fruitWidget({AsyncSnapshot<List<RandomUserModel>> snapshot}) {
    return GestureDetector(
      onPanUpdate: (details) {
        //print(details.globalPosition.dy);
        if (details.delta.dy > 0) {
          if (_controller.offset < 0) {
            _controller.jumpTo(0);
          }
          if (_controller1.offset < 0) {
            _controller1.animateTo(0,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
            _controller.animateTo(0,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          }
          // print('We are swiping up');
          //  print(details.delta.dy);
          _controller.jumpTo(_controller.offset - details.delta.dy);
          _controller1.jumpTo(_controller1.offset - details.delta.dy);
        } else if (details.delta.dy < 0) {
          print('We are swiping down');
          double maxScroll = _controller.position.maxScrollExtent;
          double currentScroll = _controller.position.pixels;
          double maxScroll1 = _controller1.position.maxScrollExtent;
          double currentScroll1 = _controller1.position.pixels;

          ///lets say that we reached 99% of the screen
          double delta =
              230; // or something else.. you have to do the math yourself
          if (maxScroll - currentScroll <= delta) {
            print('reached the end ?');

            _controller.jumpTo(_controller.position.maxScrollExtent);
          }
          if (maxScroll1 - currentScroll1 <= delta) {
            print('reached the end ?');

            _controller1.jumpTo(_controller1.position.maxScrollExtent);
          }

          _controller.jumpTo(_controller.offset - details.delta.dy);
          _controller1.jumpTo(_controller1.offset - details.delta.dy);
        }
      },
      child: Container(
        color: Colors.cyan[50], //background
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: _controller,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index.isEven) {
                    return Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color:
                                  materialColors[index % materialColors.length],
                              borderRadius: BorderRadius.circular(20)),
                          height: 300,
                          margin:
                              EdgeInsets.only(right: 5, bottom: 10, top: 10),
                          width: MediaQuery.of(context).size.width / 2 - 10,
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${snapshot.data[index].first} ${snapshot.data[index].last}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Opacity(
                          opacity: 0.4,
                          child: Container(
                              height: 200,
                              alignment: Alignment.center,
                              child: Image.network(
                                '${snapshot.data[index].picture}',
                                fit: BoxFit.contain,
                              )),
                        )
                      ],
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _controller1,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 1) {
                    return _showAd();
                  }
                  if (index.isOdd) {
                    return Container(
                      height: 300,
                      decoration: BoxDecoration(
                          color: materialColors[index % materialColors.length],
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.only(left: 5, bottom: 10, top: 10),
                      width: MediaQuery.of(context).size.width / 2 - 50,
                      alignment: Alignment.center,
                      child: Text(
                        '${snapshot.data[index].first} ${snapshot.data[index].last}',
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      // _controller.jumpTo(_controller.offset);
    });
    _controller1.addListener(() {
      // _controller1.animateTo(_controller.offset,
      //     curve: Curves.linear, duration: Duration(milliseconds: 500));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(icon: Icon(Icons.menu), onPressed: null),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.shopping_basket), onPressed: null)
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 3.1, color: Colors.red),
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            Container(
              height: 50,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: tabBarTitle.length,
                itemBuilder: (BuildContext context, int x) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = x;
                      });
                      if (x == 1) {
                        fetchRandomUsers();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: x == selectedTab
                                      ? Colors.green
                                      : Colors.white))),
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '${tabBarTitle[x]}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
                child: selectedTab == 0
                    ? _fruitWidget()
                    : selectedTab == 1
                        ? usersWidget()
                        : selectedTab == 2 ? _nutsWidget() : _dairyWidget())
          ],
        ),
      ),
    );
  }
}

//emilecode: we create a list of fruits
List<String> listOfFruits = [
  'Papaya',
  'Apricot',
  'Durian',
  'Boysenberry',
  'Longan',
  'Prune',
  'Common fig',
  'Muskmelon',
  'Pomelo',
  'Tangelo',
  'Coconut',
  'Raspberry',
  'Apple',
  'Persimmon',
  'Pineapple',
  'Lime',
  'Quince',
  'Cherry',
  'Pear',
  'Tangerine',
  'Strawberry',
  'Zebosu',
  'Eanda',
  'Anach',
  'Kuriac',
  'Eto',
  'Salty Chicory',
  'Crimson Chives',
  'Sea Celery',
  'Daydream Grape',
  'Young Tamarind',
];
