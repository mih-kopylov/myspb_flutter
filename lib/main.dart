import 'package:flutter/material.dart';
import 'package:myspb/const.dart';

import 'widgets/index_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TITLE,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: IndexPage(),
    );
  }
}
