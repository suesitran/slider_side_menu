# slider_side_menu

Slider Side Menu that is hidden to the side of the screen, and only open when user taps on the controller button.

## Demo

![Sample Demo](https://github.com/suesitran/slider_side_menu/blob/master/screenrecord/demo.gif)

## How to use

In your pubspec.yaml, include the package [dependencies into your pubspec.yaml](https://flutter.dev/docs/development/packages-and-plugins/using-packages)

In your code, add import
```
import 'package:slider_side_menu/slider_side_menu.dart';
```

Then add the widget to your screen
```
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
```

Sample code: https://github.com/suesitran/slider_side_menu/blob/master/example/lib/main.dart
