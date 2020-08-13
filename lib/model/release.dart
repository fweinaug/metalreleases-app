import 'package:albumreleases_app/model/date.dart';
import 'package:albumreleases_app/model/spotify.dart';

class Release {
  final int id;
  final String artist;
  final String title;
  final DateTime releaseDate;
  final Spotify spotify;

  Release({
    this.id,
    this.artist,
    this.title,
    this.releaseDate,
    this.spotify,
  });

  int get remainingDays {
    return releaseDate.difference(getToday()).inDays;
  }

  bool get isReleased => remainingDays <= 0;

  bool get isPlayable => spotify != null;

  factory Release.fromJson(Map<String, dynamic> json) {
    return Release(
      id: json['id'],
      artist: json['artist'],
      title: json['title'],
      releaseDate: DateTime.parse(json['releaseDate']),
      spotify: json['spotify'] != null
        ? Spotify.fromJson(json['spotify'] as Map<String, dynamic>)
        : null,
    );
  }
}