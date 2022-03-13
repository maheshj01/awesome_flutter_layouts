import 'package:awesome_flutter_layouts/const/colors.dart';
import 'package:awesome_flutter_layouts/widgets/picker_widget.dart';
import 'package:flutter/material.dart';

class BottomSheetApp extends StatefulWidget {
  const BottomSheetApp({Key? key, this.title = 'Custom Bottom sheet example'})
      : super(key: key);

  final String title;

  @override
  _BottomSheetAppState createState() => _BottomSheetAppState();
}

class _BottomSheetAppState extends State<BottomSheetApp> {
  void _showCustomTimePicker() {
    showModalBottomSheet(
        backgroundColor: beachRed[50],
        shape: const RoundedRectangleBorder(
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
            const Text(
              'Push the Button to View the bottom Sheet:',
            ),
            Text(
              time,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'Column-Picker',
        onPressed: _showCustomTimePicker,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
