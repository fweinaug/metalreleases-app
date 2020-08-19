import 'package:albumreleases_app/config_reader.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:albumreleases_app/api/api_exception.dart';
import 'package:albumreleases_app/model/release.dart';
import 'dart:convert';

class ReleaseApi {
  Future<List<Release>> getWeeksReleases() async {
    return await _query("/releases/week");
  }

  Future<List<Release>> getUpcomingReleases() async {
    return await _query('/releases/upcoming');
  }

  Future<List<Release>> getRecentReleases() async {
    return await _query('/releases/recent');
  }

  Future<List<Release>> searchReleases(String query) async {
    return await _query('/releases/search?q=$query');
  }

  Future<List<Release>> _query(String url) async {
    final response = await http.get("${ConfigReader.getApiUrl()}$url");

    if (response.statusCode == 200) {
      return compute(_parseReleases, response.body);
    } else {
      throw ApiException('Failed to load releases');
    }
  }
}

List<Release> _parseReleases(String responseBody) {
  final list = List<Release>();

  final data = json.decode(responseBody)['data'];
  data.forEach((item) {
    var release = Release.fromJson(item);

    list.add(release);
  });

  return list;
}