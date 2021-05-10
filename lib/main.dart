import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/ui/main/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid Coffee',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Color(0xFF535353)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
