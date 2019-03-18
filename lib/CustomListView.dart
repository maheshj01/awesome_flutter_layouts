import 'package:flutter/material.dart';
import 'const.dart';

class CustomListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Container(
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purpleAccent, Colors.purple],
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                            icon: Icon(Icons.menu, color: Colors.white),
                            onPressed: () {})
                      ],
                    ),
                  )),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purpleAccent, Colors.purple],
                  ),
                ),
                child: TabBar(
                  tabs: <Widget>[
                    Tab(
                      child: Text("Designer"),
                    ),
                    Tab(
                      child: Text("Category"),
                    ),
                    Tab(
                      child: Text("Attention"),
                    )
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: ListView.builder(
                        itemCount: 20, //total no of list items
                        itemBuilder: (BuildContext context, int currentitem) {
                          return GestureDetector(
                            onTap: () {
                              print("tapped on item $currentitem");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors:
                                        colors[currentitem % colors.length]),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  new BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 3.5,
                                      offset: new Offset(1.0, 2.0)),
                                ],
                              ),
                              margin: EdgeInsets.only(
                                  top: 10, left: 20, right: 20, bottom: 10),
                              height: 150,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    //left half image avtar of listitem
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      margin:
                                          EdgeInsets.only(left: 20, top: 15),
                                      child: CircleAvatar(
                                        radius: 30,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    //center of listitem
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding:
                                          EdgeInsets.only(top: 20, left: 5),
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
                                                      "Lorem Ipsum",
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    Text("Some SubTitle")
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
                                                        Text("$currentitem\43"),
                                                        Text("Popularity",
                                                            style: TextStyle(
                                                                fontSize: 12))
                                                      ],
                                                    )),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                        child: Column(
                                                      children: <Widget>[
                                                        Text(
                                                            "$currentitem\433"),
                                                        Text("Like",
                                                            style: TextStyle(
                                                                fontSize: 12))
                                                      ],
                                                    )),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                        child: Column(
                                                      children: <Widget>[
                                                        Text(
                                                            "$currentitem\4333"),
                                                        Text(
                                                          "Followed",
                                                          style: TextStyle(
                                                              fontSize: 12),
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
                                    flex: 1,
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          IconButton(
                                              icon: Icon(Icons.more_horiz),
                                              onPressed: (){},),
                                          Text(
                                            "$currentitem",
                                            style: TextStyle(fontSize: 22),
                                          ),
                                          Text("Ranking")
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
                    ),
                    Container(
                      color: Colors.green,
                    ),
                    Container(
                      color: Colors.red,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
