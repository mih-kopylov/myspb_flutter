import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myspb/client/model/reason_response.dart';

part "category_response.g.dart";

@immutable
@JsonSerializable()
class CategoryResponse {
  final int id;
  final String name;
  final List<ReasonResponse> reasons;

  CategoryResponse(this.id, this.name, this.reasons);

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
