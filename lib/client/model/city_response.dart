import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myspb/client/model/category_response.dart';

part "city_response.g.dart";

@immutable
@JsonSerializable()
class CityResponse {
  final int id;
  final String name;
  final List<CategoryResponse> categories;

  CityResponse(this.id, this.name, this.categories);

  factory CityResponse.fromJson(Map<String, dynamic> json) =>
      _$CityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CityResponseToJson(this);
}
