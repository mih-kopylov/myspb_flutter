import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:myspb/store/tabs.dart';
import 'package:myspb/widgets/tabs/problems_tab.dart';

import 'tabs/categories_tab.dart';
import 'tabs/in_progress_tab.dart';
import 'tabs/problems_tab.dart';

class IndexPage extends StatelessWidget {
  static List<Widget> _tabWidgets = <Widget>[
    CategoriesTab(),
    InProgressTab(),
    ProblemsTab(),
  ];
  final Tabs _tabs = Tabs();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        body: _tabWidgets[_tabs.activeTabIndex],
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
          currentIndex: _tabs.activeTabIndex,
          onTap: (value) => _tabs.setActiveTabIndex(value),
        ),
      ),
    );
  }
}
