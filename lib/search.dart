import 'dart:convert';
import 'dart:math';

import 'package:awesome_flutter_layouts/bloc/userbloc.dart';
import 'package:awesome_flutter_layouts/const/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/usermodel.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> tabBarTitle = [
    'Friends',
    'Random Users',
    'Acquaintance',
    'Colleagues'
  ];

  int selectedTab = 2;

  final ScrollController _controller = ScrollController();
  final ScrollController _controller1 = ScrollController();

  var data;

  Future<void> getFilteredList() async {}

  Widget _acquaintance() {
    return Center(
      child: Text('_acquaintance will apear here'),
    );
  }

  Widget _friends() {
    return Center(
      child: Text('Friends will appear here '),
    );
  }

  Widget _colleagues() {
    return Center(
      child: Text('Colleagues will appear here'),
    );
  }

  Widget usersWidget() {
    return StreamBuilder(
        stream: userBloc.userController.stream,
        builder: (BuildContext buildContext,
            AsyncSnapshot<List<RandomUserModel>?> snapshot) {
          if (snapshot == null) {
            return CircularProgressIndicator();
          }
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _randomUsers(snapshot: snapshot);
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

  Widget _cardWidget(
      AsyncSnapshot<List<RandomUserModel>?> snapshot, int index) {
    return Stack(fit: StackFit.expand, children: <Widget>[
      Opacity(
        opacity: 0.7,
        child: Container(
          decoration: BoxDecoration(
              color: materialColors[index % materialColors.length],
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(snapshot.data![index].picture)),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 2, offset: Offset(1, 0.5), spreadRadius: 0.5)
              ]),
          margin: EdgeInsets.only(left: 5, bottom: 10, top: 10),
          alignment: Alignment.center,
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
          '${snapshot.data![index].first} ${snapshot.data![index].last}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      )
    ]);
  }

  Widget _randomUsers(
      {required AsyncSnapshot<List<RandomUserModel>?> snapshot}) {
    return GestureDetector(
      onPanUpdate: (details) {
        //print(details.globalPosition.dy);
        if (details.delta.dy > 0) {
          if (_controller.offset < 0) {
            _controller.jumpTo(0);
            _controller1.jumpTo(0);
          }

          _controller.jumpTo(_controller.offset - details.delta.dy);
          _controller1.jumpTo(_controller1.offset - details.delta.dy);
        } else if (details.delta.dy < 0) {
          print('We are swiping down');
          final double maxScroll = _controller.position.maxScrollExtent;
          final double currentScroll = _controller.position.pixels;
          final double maxScroll1 = _controller1.position.maxScrollExtent;
          final double currentScroll1 = _controller1.position.pixels;

          ///lets say that we reached 99% of the screen
          final double delta =
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
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index.isEven) {
                    return Container(
                        height: 200, child: _cardWidget(snapshot, index));
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: ListView.builder(
                controller: _controller1,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  // if (index == random || index == 1) {
                  //   return _showAd();
                  // }
                  if (index.isOdd) {
                    return Container(
                        height: 300, child: _cardWidget(snapshot, index));
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
    _controller1.addListener(() {});
  }

  void _searchUser(String searchQuery) {
    final List<RandomUserModel> searchResult = [];
    userBloc.userController.sink.add(null);
    print('total users = ${totalUsers.length}'); //
    if (searchQuery.isEmpty) {
      userBloc.userController.sink.add(totalUsers);
      return;
    }
    for (var user in totalUsers) {
      if (user.first.toLowerCase().contains(searchQuery.toLowerCase()) ||
          user.last.toLowerCase().contains(searchQuery.toLowerCase())) {
        searchResult.add(user);
      }
    }
    userBloc.userController.sink.add(searchResult);
  }

  Future<void> fetchRandomUsers() async {
    final http.Response response = await http.get(Uri.parse(RANDOM_URL));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final Iterable list = body['results'];
      // map each json object to model and addto list and return the list of models
      totalUsers =
          list.map((model) => RandomUserModel.fromJson(model)).toList();
      userBloc.userController.sink.add(totalUsers);
    }
  }

  late int random;
  List<RandomUserModel> totalUsers = [];
  Random rng = Random();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: BackButton(
            color: Colors.black,
          ),
          actions: const <Widget>[
            IconButton(icon: Icon(Icons.shopping_basket), onPressed: null)
          ],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (text) => _searchUser(text),
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
                        random = rng.nextInt(100);
                        print('random = $random');
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
                        tabBarTitle[x],
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
                child: selectedTab == 0
                    ? _friends()
                    : selectedTab == 1
                        ? usersWidget()
                        : selectedTab == 2
                            ? _acquaintance()
                            : _colleagues())
          ],
        ),
      ),
    );
  }
}
