import 'package:flutter/material.dart';
import 'const.dart';

class AwesomeEndDrawer extends StatefulWidget {
  @override
  _AwesomeEndDrawerState createState() => _AwesomeEndDrawerState();
}

class _AwesomeEndDrawerState extends State<AwesomeEndDrawer> {
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
          child: Stack(
        children: <Widget>[
          // background of the drawer
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black87, Colors.grey[800]],
            )),
          ),
          ListView(
              children: List.generate(7, (x) {
            if (x == 0) {
              return Container(
                height: 100,
                alignment: Alignment.center,
                child: Text(
                  'TITLE',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Stack(
                      children: <Widget>[
                        FractionalTranslation(
                          translation: Offset(-0.5, 0.30),
                          child: Container(
                            height: 50,
                            width: 50,
                            margin: EdgeInsets.only(
                              top: 10,
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            padding: EdgeInsets.all(5),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage('${imageurl[0]}'),
                              radius: 40,
                              backgroundColor: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 130,
                    width: 150,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 5.0),
                            blurRadius: 2.0,
                            color: colors[0][0],
                          )
                        ],
                        color: colors[0][0],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "John Doe",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "18:50",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              '$SOMETEXT',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }))
        ],
      )),
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
      body: new Container(
        child: Center(
          child: Text("Tap the Menu on Top Right"),
        ),
      ),
    );
  }
}
