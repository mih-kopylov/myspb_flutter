import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part "reason_response.g.dart";

@immutable
@JsonSerializable()
class ReasonResponse {
  final int id;
  final String name;
  @JsonKey(name: "wizard_widget")
  final int positionType;

  ReasonResponse(this.id, this.name, this.positionType);

  factory ReasonResponse.fromJson(Map<String, dynamic> json) =>
      _$ReasonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReasonResponseToJson(this);
}
