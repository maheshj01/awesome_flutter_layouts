import 'package:awesome_flutter_layouts/const/colors.dart';
import 'package:awesome_flutter_layouts/widgets/picker_widget.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: beachRed,
      ),
      home: MyHomePage(title: 'BottomSheets'),
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
  void _showCustomTimePicker() {
    showModalBottomSheet(
        backgroundColor: beachRed[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) => TimePickerWidget(
              onChange: (newTime) => time = newTime,
            )).whenComplete(() {
      setState(() {});
    });
  }

  String time = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Push the Button to View the bottom Sheet:',
            ),
            Text(
              '$time',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCustomTimePicker,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
