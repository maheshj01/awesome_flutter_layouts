import 'dart:convert';

import 'package:awesome_flutter_layouts/const/const.dart';
import 'package:awesome_flutter_layouts/const/strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'const/const.dart';

class CustomListView extends StatefulWidget {
  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  bool isLoading = true;
  var data;
  @override
  void initState() {
    fetchRandomData();
    super.initState();
  }

  Future<void> fetchRandomData() async {
    final http.Response response = await http.get(Uri.parse(RANDOM_URL));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      data = body['results'];
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget designerTab() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: data.length, //total no of list items
              itemBuilder: (BuildContext context, int currentitem) {
                return GestureDetector(
                  onTap: () {
                    print('tapped on item $currentitem');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: colors[currentitem % colors.length]),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 3.5,
                            offset: Offset(1.0, 2.0)),
                      ],
                    ),
                    margin: const EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 10),
                    height: MediaQuery.of(context).size.height / 4.5,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          //left half image avtar of listitem
                          flex: 4,
                          child: Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(left: 20, top: 15),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  data[currentitem]['picture']['medium']),
                              radius: 30,
                            ),
                          ),
                        ),
                        Expanded(
                          //center of listitem
                          flex: 9,
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.only(top: 20, left: 5),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                    flex: 4,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            data[currentitem]['name']['first']
                                                    .toString() +
                                                ' ' +
                                                data[currentitem]['name']
                                                        ['last']
                                                    .toString(),
                                            style: const TextStyle(fontSize: 18),
                                          ),
                                          Text(data[currentitem]['phone']
                                              .toString())
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
                                              Text('$currentitem\43'),
                                              Text('Popularity',
                                                  style: subHeadingTextStyle)
                                            ],
                                          )),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              child: Column(
                                            children: <Widget>[
                                              Text('$currentitem\433'),
                                              Text(
                                                'Like',
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
                                              Text('$currentitem\4333'),
                                              Text(
                                                'Followed',
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
                          //right half of listitem
                          flex: 3,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.more_horiz),
                                  onPressed: () {},
                                ),
                                Text(
                                  '$currentitem',
                                  style: const TextStyle(fontSize: 22),
                                ),
                                const Text('Ranking')
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
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
                    designerTab(),
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
