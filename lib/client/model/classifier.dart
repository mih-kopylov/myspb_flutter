import 'package:flutter/material.dart';

@immutable
class Classifier {
  final String city;
  final String category;
  final int reasonId;
  final String reasonName;
  final int reasonPositionType;

  Classifier(this.city, this.category, this.reasonId, this.reasonName,
      this.reasonPositionType);
}
