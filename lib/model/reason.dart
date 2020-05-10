import 'package:flutter/material.dart';

@immutable
class Reason {
  final int id;
  final int parentId;
  final String name;
  final int externalReasonId;
  final String description;

  Reason(this.id, this.parentId, this.name, this.externalReasonId,
      this.description);
}
