import 'package:flutter/material.dart';
import 'const.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Awesome Flutter Layouts'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: layout_title.length,
          itemBuilder: (BuildContext context, int currentitem) {
            return Container(
              width: double.infinity,
              height: 80,
              child: Column(
                children: <Widget>[
                  Container(
                      height: 80,
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => layoutList[
                                          currentitem % layoutList.length]));
                            },
                            leading: Icon(Icons.list),
                            title: Text(layout_title[
                                currentitem % layout_title.length]),
                          ),
                          Container(
                            width: double.infinity,
                            height: 0.1,
                            color: Colors.black,
                          )
                        ],
                      )),
                ],
              ),
            );
          },
        ));
  }
}
