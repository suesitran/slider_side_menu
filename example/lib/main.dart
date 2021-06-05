import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:slider_side_menu/slider_side_menu.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.top, SystemUiOverlay.bottom]);

  runApp(ExampleSliderSideMenu());
}

class ExampleSliderSideMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExampleSliderSideMenuState();
  }
}

class _ExampleSliderSideMenuState extends State<ExampleSliderSideMenu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Slider Side Menu Demo" ,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Slider Side Menu Demo"),
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: Text("Demostration of Slider Side Menu Demo"),
            ),
            SliderSideMenu(childrenData: [
              MenuItem(
                  icon: Icon(Icons.thumb_up),
                  label: Text("Thumb up"),
                  onPressed: _thumbUp
              ),
              MenuItem(
                  icon: Icon(Icons.thumb_down),
                  label: Text("Thumb down"),
                  onPressed: _thumbDown
              )
            ], description: "Sample tooltip message")
          ],
        ),
      ),
    );
  }

  void _thumbUp() {

  }

  void _thumbDown() {

  }
}