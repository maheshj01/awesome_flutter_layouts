import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> tabBarTitle = ['Fruits', 'Vegetables', 'Nuts & Seeds', 'Dairy'];
  int selectedTab = 0;

  ScrollController _controller = ScrollController();
  ScrollController _controller1 = ScrollController();
// Future<> fetchFruits(){

// }
  int items = 21;

  // return FutureBuilder(
  //   future: fetchFruits,
  //   builder: (BuildContext, AsyncSnapshot snapshot) {
  //   if (snapshot == null) {
  //     return CircularProgressIndicator();
  //   }
  //   snapshot.connectionState == ConnectionState.waiting
  //       ? CircularProgressIndicator()
  //       : Container();
  // });

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

  Widget _fruitWidget() {
    return GestureDetector(
      onPanUpdate: (details) {
        print(details.globalPosition.dy);
        // _controller.animateTo(details.globalPosition.dy,
        //     curve: Curves.linear, duration: Duration(milliseconds: 500));
        // _controller1.animateTo(details.globalPosition.dy,
        //     curve: Curves.linear, duration: Duration(milliseconds: 500));
        _controller.jumpTo(details.globalPosition.dy);
        _controller1.jumpTo(details.globalPosition.dy);
        // print(details.delta.dy);
      },
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListView(
              controller: _controller,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate((items / 2).floor(), (x) {
                return Container(
                  height: 200,
                  color: Colors.red,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  width: MediaQuery.of(context).size.width / 2 - 50,
                  alignment: Alignment.center,
                  child: Text('$x'),
                );
              }),
            ),
          ),
          Expanded(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              controller: _controller1,
              children: List.generate(items - (items / 2).floor(), (k) {
                return Container(
                  color: Colors.green,
                  height: 300,
                  margin: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width / 2 - 50,
                  alignment: Alignment.center,
                  child: Text('$k'),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      _controller.jumpTo(_controller.offset);
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
                        ? _vegetablesWidget()
                        : selectedTab == 2 ? _nutsWidget() : _dairyWidget())
          ],
        ),
      ),
    );
  }
}
