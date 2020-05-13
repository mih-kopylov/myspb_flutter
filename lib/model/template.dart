import 'package:flutter/material.dart';

@immutable
class Template {
  final int id;
  final int groupId;
  final String name;
  final int reasonId;
  final String body;

  Template(this.id, this.groupId, this.name, this.reasonId, this.body);
}
