import 'package:mobx/mobx.dart';

part 'tabs.g.dart';

class Tabs = _Tabs with _$Tabs;

abstract class _Tabs with Store {
  @observable
  int activeTabIndex = 0;

  @action
  void setActiveTabIndex(int value) {
    activeTabIndex = value;
  }
}
