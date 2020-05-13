import 'package:flutter/material.dart';

@immutable
class Group {
  final int id;
  final int parentId;
  final String name;
  final String description;

  Group(this.id, this.parentId, this.name, this.description);
}
