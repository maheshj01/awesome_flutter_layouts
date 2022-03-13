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
    return const Center(
      child: Text('_acquaintance will apear here'),
    );
  }

  Widget _friends() {
    return const Center(
      child: Text('Friends will appear here '),
    );
  }

  Widget _colleagues() {
    return const Center(
      child: Text('Colleagues will appear here'),
    );
  }

  Widget usersWidget() {
    return StreamBuilder(
        stream: userBloc.userController.stream,
        builder: (BuildContext buildContext,
            AsyncSnapshot<List<RandomUserModel>?> snapshot) {
          if (snapshot == null) {
            return const CircularProgressIndicator();
          }
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _randomUsers(snapshot: snapshot);
        });
  }

  Widget _showAd() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 200,
      decoration: BoxDecoration(
          color: materialColors[5], borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.center,
      child: const Text('Ad'),
    );
  }

  Widget _cardWidget(
      AsyncSnapshot<List<RandomUserModel>?> snapshot, int index) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          blurRadius: 5.0, // soften the shadow
          spreadRadius: 1.0, //extend the shadow
          offset: const Offset(
            2.0, // Move to right 10  horizontally
            2.0, // Move to bottom 10 Vertically
          ),
        )
      ]),
      child: Stack(fit: StackFit.expand, children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(snapshot.data![index].picture)),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.only(left: 5, bottom: 10, top: 10),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.8), Colors.transparent]),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 24),
          child: Text(
            '${snapshot.data![index].first} ${snapshot.data![index].last}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ]),
    );
  }

  Widget _randomUsers(
      {required AsyncSnapshot<List<RandomUserModel>?> snapshot}) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dy > 0) {
          if (_controller.offset < 0) {
            _controller.jumpTo(0);
            _controller1.jumpTo(0);
          }

          _controller.jumpTo(_controller.offset - details.delta.dy);
          _controller1.jumpTo(_controller1.offset - details.delta.dy);
        } else if (details.delta.dy < 0) {
          final double maxScroll = _controller.position.maxScrollExtent;
          final double currentScroll = _controller.position.pixels;
          final double maxScroll1 = _controller1.position.maxScrollExtent;
          final double currentScroll1 = _controller1.position.pixels;

          ///lets say that we reached 99% of the screen
          const double delta =
              230; // or something else.. you have to do the math yourself
          if (maxScroll - currentScroll <= delta) {
            _controller.jumpTo(_controller.position.maxScrollExtent);
          }
          if (maxScroll1 - currentScroll1 <= delta) {
            _controller1.jumpTo(_controller1.position.maxScrollExtent);
          }

          _controller.jumpTo(_controller.offset - details.delta.dy);
          _controller1.jumpTo(_controller1.offset - details.delta.dy);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView.builder(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index.isEven) {
                      return Container(
                          height: 200, child: _cardWidget(snapshot, index));
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView.builder(
                  controller: _controller1,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == random || index == 1) {
                      return _showAd();
                    }
                    if (index.isOdd) {
                      return Container(
                          height: 300, child: _cardWidget(snapshot, index));
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
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
    for (final user in totalUsers) {
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

  Widget _buildBody() {
    return index == 0
        ? _friends()
        : index == 1
            ? usersWidget()
            : index == 2
                ? _acquaintance()
                : _colleagues();
  }

  late int random;
  List<RandomUserModel> totalUsers = [];
  Random rng = Random();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        actions: const <Widget>[
          IconButton(icon: Icon(Icons.shopping_basket), onPressed: null)
        ],
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (text) => _searchUser(text),
              decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.search),
                  hintText: 'Search',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3.1, color: Colors.red),
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Tabs(
              index: index,
              list: tabBarTitle,
              onIndexChange: (x) {
                setState(() {
                  index = x;
                });
                if (x == 1) {
                  random = rng.nextInt(100);
                  fetchRandomUsers();
                }
              },
            ),
          ),
          Expanded(child: _buildBody())
        ],
      ),
    );
  }
}

class Tabs extends StatelessWidget {
  Tabs(
      {Key? key,
      required this.list,
      required this.onIndexChange,
      required this.index})
      : super(key: key);
  final List<String> list;
  Function(int) onIndexChange;
  int index;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: list.length,
      initialIndex: index,
      child: TabBar(
        // indicatorColor: primaryColorGreen,
        indicatorSize: TabBarIndicatorSize.label,
        onTap: (index) {
          onIndexChange(index);
        },
        isScrollable: true,
        tabs: [
          for (int i = 0; i < list.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                list[i],
                style: const TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}
