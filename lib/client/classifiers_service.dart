import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:myspb/client/api.dart';
import 'package:myspb/client/model/category_response.dart';
import 'package:myspb/client/model/city_response.dart';
import 'package:myspb/client/model/classifier.dart';
import 'package:myspb/client/model/reason_response.dart';

class ClassifiersService {
  List<Classifier> _getCityClassifiers(CityResponse cityResponse) {
    List<Classifier> result = [];
    for (CategoryResponse categoryResponse in cityResponse.categories) {
      for (ReasonResponse reasonResponse in categoryResponse.reasons) {
        result.add(Classifier(
            cityResponse.name,
            categoryResponse.name,
            reasonResponse.id,
            reasonResponse.name,
            reasonResponse.positionType));
      }
    }
    return result;
  }

  Future<List<Classifier>> loadClassifiers() async {
    final response = await http.get(Api.CLASSIFIER,
        headers: {HttpHeaders.acceptHeader: ContentType.json.value});
    if (response.statusCode != 200) {
      return Future.error("Can't fetch classifiers");
    }
    String decoded = utf8.decode(response.bodyBytes);
    final Iterable iter = json.decode(decoded);
    return List.of(iter)
        .cast<Map<String, dynamic>>()
        .map<CityResponse>((json) => CityResponse.fromJson(json))
        .expand(_getCityClassifiers)
        .toList();
  }
}
