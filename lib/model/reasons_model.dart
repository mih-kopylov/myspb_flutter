import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:myspb/model/reason.dart';

class ReasonsModel extends ChangeNotifier {
  final List<Reason> _reasons = [
    Reason(1, null, "Бумажные объявления", null, null),
    Reason(2, null, "Надписи", null, null),
    Reason(3, 1, "На ТСОДД", 5, "Бумажные объявления на ТСОДД"),
    Reason(4, 2, "На ТСОДД", 5, "Надписи на ТСОДД"),
    Reason(5, 1, "На опоре", 5, "Бумажные объявления на опоре освещения"),
  ];

  UnmodifiableListView<Reason> get items => UnmodifiableListView(_reasons);

  void add(Reason reason) {
    _reasons.add(reason);
    notifyListeners();
  }

  void update(Reason reason) {
    final foundIndex = _getReasonIndex(reason);
    _reasons.removeAt(foundIndex);
    _reasons.insert(foundIndex, reason);
    notifyListeners();
  }

  void remove(Reason reason) {
    final foundIndex = _getReasonIndex(reason);
    _reasons.removeAt(foundIndex);
    notifyListeners();
  }

  int size() {
    return _reasons.length;
  }

  List<Reason> ofRoot(int rootId) {
    return _reasons.where((o) => rootId == o.parentId).toList();
  }

  Reason ofId(int reasonId) {
    return _reasons.firstWhere((o) => reasonId == o.id, orElse: () {
      return null;
    });
  }

  Reason get(int index) {
    return _reasons[index];
  }

  int _getReasonIndex(Reason reason) {
    var foundIndex = _reasons.indexWhere((r) => r.id == reason.id);
    if (foundIndex < 0) {
      throw FormatException("Can't find a reason with id = ${reason.id}");
    }
    return foundIndex;
  }
}
