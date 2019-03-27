import 'package:flutter/material.dart';
import 'const.dart';

class AwesomeEndDrawer extends StatefulWidget {
  @override
  _AwesomeEndDrawerState createState() => _AwesomeEndDrawerState();
}

class _AwesomeEndDrawerState extends State<AwesomeEndDrawer> {
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        endDrawer: Drawer(
            child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black87, Colors.grey[800]],
              )),
            ),
            Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Row(children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: FractionalTranslation(
                        translation: Offset(-0.5, 0.0),
                        child: Container(
                          height: 50,
                          width: 50,
                          margin: EdgeInsets.only(
                            top: 10,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white),
                          padding: EdgeInsets.all(5),
                          child: CircleAvatar(
                            minRadius: 30,
                            backgroundColor: Colors.white,
                            child: Image.network(
                              "https://everipedia-storage.s3-accelerate.amazonaws.com/ProfilePics/6969909036-1492880896.jpeg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                          height: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                imagetitle[0],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                              Text(
                                "Tesla",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          )),
                    )
                  ]),
                ),
                Expanded(
                    flex: 7,
                    child: Column(
                      children: <Widget>[
                       Expanded(
                         child: ListView.builder(
                         itemCount: 4,
                         itemBuilder: (BuildContext context,int item){
                           return Container(
                             height: 200,
                             child:  Row(
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
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  padding: EdgeInsets.all(5),
                                  child: CircleAvatar(
                                    minRadius: 30,
                                    backgroundColor: Colors.grey,
                                    child: Image.network(
                                      "https://everipedia-storage.s3-accelerate.amazonaws.com/ProfilePics/6969909036-1492880896.jpeg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                                ],
                              )
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                height: 130,
                                width: 150,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 5.0),
                                      blurRadius: 2.0,
                                      color: colors[item][0],
                                    )
                                  ],
                                  color: colors[item][0],
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(padding: EdgeInsets.all(10),
                                            child: Text("Brian Mansion",style: TextStyle(color: Colors.white),),
                                          ),
                                          Container(padding: EdgeInsets.all(10),
                                            child: Text("18:50",style: TextStyle(color: Colors.white),),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text("This isisddkl sfndkf sjfjkdf bkjfdbkfjbkf dbvkfjdbvkfd jvbkdbv kdbvkdbvkbdkjvbjkdbvjkdb",style: TextStyle(color: Colors.white),),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                           );
                         },
                       ),
                       )
                      ],
                    ))
              ],
            )
          ],
        )),
        appBar: AppBar(
          actions: [
            Builder(
              builder: (context) => IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
            ),
          ],
        ),
        body: new Container(
          child: Center(
            child: Text("Tap the Menu on Top Right"),
          ),
        ),
      ),
    );
  }
}

// Stack(
//                     children: <Widget>[
//                     ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     itemCount: 4,
//                     itemBuilder: (BuildContext context, int currentitem) {
//                       return Container(
//                         height: 200,
//                           child: Row(children: <Widget>[
//                         Expanded(
//                           flex: 1,
//                           child: FractionalTranslation(
//                             translation: Offset(-0.5, 0.0),
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               margin: EdgeInsets.only(
//                                 top: 10,
//                               ),
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.orangeAccent),
//                               padding: EdgeInsets.all(5),
//                               child: CircleAvatar(
//                                 minRadius: 30,
//                                 backgroundColor: Colors.white,
//                                 child: Image.network(
//                                   "https://everipedia-storage.s3-accelerate.amazonaws.com/ProfilePics/6969909036-1492880896.jpeg",
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),

//                       ]));
//                     },
//                   ),
//                     ],
//                   )
