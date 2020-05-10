import 'package:flutter/material.dart';

import 'home.page.dart';

void main(){
  runApp(MyApp()); 
}


final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.deepOrange[100],
  primaryColorBrightness: Brightness.light
);

final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.purple,
 accentColor: Colors.orangeAccent[400]
);

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

return MaterialApp(
      title: 'Chat Online',
      theme: Theme.of(context).platform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme,
      home: HomePage(),
    );
  }
  
}
