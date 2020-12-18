

import 'package:flutter/material.dart';
import 'package:flutter_share/share_data.dart';
import 'package:flutter_share/splash_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Splash(),
    );
  }
}
