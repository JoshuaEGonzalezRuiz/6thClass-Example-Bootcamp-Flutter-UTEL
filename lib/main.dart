//import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';

import 'pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //DartVLC.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'U Class 6 Example',
      theme: ThemeData(
          useMaterial3: true, colorSchemeSeed: Colors.purpleAccent.shade200),
      home: const HomePage(),
    );
  }
}
