import 'package:awesome_flutter_layouts/darkmode.dart';
import 'package:flutter/material.dart';
import 'const/const.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(title: 'Awesome Flutter Layouts'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _push(Widget child) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => child));
  }

  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return DarkTransition(
      isDark: isDark,
      offset: Offset(mediaQuery.size.width - 50, 40),
      duration: const Duration(milliseconds: 800),
      childBuilder: (context, int index) {
        return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              actions: [
                IconButton(
                  icon: isDark
                      ? const Icon(Icons.wb_sunny)
                      : const Icon(Icons.brightness_2),
                  onPressed: () {
                    setState(() {
                      isDark = !isDark;
                    });
                  },
                )
              ],
            ),
            body: ListView.separated(
              itemCount: layout_title.length,
              separatorBuilder: (BuildContext context, int currentitem) {
                return Container(
                  width: double.infinity,
                  height: 0.1,
                  color: Colors.black,
                );
              },
              itemBuilder: (BuildContext context, int currentitem) {
                return ListTile(
                  onTap: () {
                    final Widget child =
                        layoutList[currentitem % layoutList.length];
                    _push(child);
                  },
                  leading: const Icon(Icons.list),
                  title: Text(layout_title[currentitem % layout_title.length]),
                );
              },
            ));
      },
    );
  }
}
