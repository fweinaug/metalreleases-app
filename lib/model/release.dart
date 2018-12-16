import 'package:albumreleases_app/model/date.dart';

class Release {
  final int id;
  final String artist;
  final String title;
  final DateTime releaseDate;

  Release({this.id, this.artist, this.title, this.releaseDate});

  get remainingDays {
    return releaseDate.difference(getToday()).inDays;
  }

  factory Release.fromJson(Map<String, dynamic> json) {
    return Release(
      id: json['id'],
      artist: json['artist'],
      title: json['title'],
      releaseDate: DateTime.parse(json['releaseDate']),
    );
  }
}