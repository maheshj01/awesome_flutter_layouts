import 'dart:ui';

import 'package:awesome_flutter_layouts/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'const/const.dart';

Future<void> main() async {
  fragmentProgram =
      await FragmentProgram.fromAsset('assets/shaders/shader.frag');
  runApp(MyApp());
}

late FragmentProgram fragmentProgram;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: appSetting,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
              title: 'BottomNavbar Demo',
              debugShowCheckedModeBanner: kDebugMode,
              themeMode:
                  appSetting.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              darkTheme: ThemeData.dark(
                useMaterial3: true,
              ).copyWith(
                  colorScheme: ColorScheme.fromSeed(
                      seedColor: appSetting.themeSeed,
                      brightness: Brightness.dark)),
              theme: ThemeData(
                  useMaterial3: true,
                  primaryColorDark: appSetting.themeSeed,
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: appSetting.themeSeed)),
              home: const MyHomePage(title: 'Awesome Flutter Layouts'));
        });
  }
}

AppSetting appSetting = AppSetting();
final List<Color> themeColorSeed = [
  Colors.blue,
  Colors.red,
  Colors.green,
  Colors.purple,
  Colors.orange,
  Colors.teal,
  Colors.pink,
  Colors.indigo,
  Colors.brown,
  Colors.cyan,
  Colors.deepOrange,
  Colors.deepPurple,
  Colors.lime,
  Colors.amber,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.yellow,
  Colors.grey,
];

class AppSetting extends ChangeNotifier {
  AppSetting({this.isDarkMode = false});
  bool isDarkMode;
  Color themeSeed = Colors.blue;

  void changeThemeSeed(Color color) {
    themeSeed = color;
    notifyListeners();
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _push(Widget child) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => child));
  }

  double index = 0;
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
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
        body: Column(
          children: [
            const Text('Theme Color'),
            Slider(
                value: index,
                min: 0,
                divisions: themeColorSeed.length - 1,
                label: themeColorSeed[index.toInt()].toColorString(),
                thumbColor: appSetting.themeSeed,
                max: themeColorSeed.length.toDouble() - 1,
                onChanged: (x) {
                  setState(() {
                    index = x;
                  });
                  appSetting.changeThemeSeed(themeColorSeed[index.toInt()]);
                }),
            Expanded(
              child: ListView.separated(
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
                    title:
                        Text(layout_title[currentitem % layout_title.length]),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
