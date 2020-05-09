import 'package:flutter/material.dart';
import 'package:myspb/const.dart';
import 'package:myspb/model/reasons_model.dart';
import 'package:provider/provider.dart';

import 'widgets/index_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ReasonsModel>(
          create: (context) => ReasonsModel(),
        ),
      ],
      child: MaterialApp(
        title: TITLE,
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: IndexPage(),
      ),
    );
  }
}
