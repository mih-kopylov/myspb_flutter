import 'package:flutter/material.dart';
import 'package:myspb/widgets/tabs/problems_tab.dart';

import 'tabs/categories_tab.dart';
import 'tabs/in_progress_tab.dart';
import 'tabs/problems_tab.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  static List<Widget> _tabWidgets = <Widget>[
    CategoriesTab(),
    InProgressTab(),
    ProblemsTab(),
  ];
  int _activeTabIndex = 0;

  void _onBottomNavBarTap(int index) {
    setState(() {
      _activeTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(TITLE),
//      ),
      body: _tabWidgets[_activeTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text("Категории"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync),
            title: Text("Очередь"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text("Созданные"),
          ),
        ],
        currentIndex: _activeTabIndex,
        onTap: _onBottomNavBarTap,
      ),
    );
  }
}
