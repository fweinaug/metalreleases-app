import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:albumreleases_app/api/api_exception.dart';
import 'package:albumreleases_app/model/release.dart';
import 'dart:convert';

class ReleaseApi {
  static const _baseUrl = '<replace-me>/releases';

  Future<List<Release>> getWeeksReleases() async {
    return await _query("$_baseUrl/week");
  }

  Future<List<Release>> getUpcomingReleases() async {
    return await _query('$_baseUrl/upcoming');
  }

  Future<List<Release>> getRecentReleases() async {
    return await _query('$_baseUrl/recent');
  }

  Future<List<Release>> _query(String url) async {
    final response = await http.get(url);

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