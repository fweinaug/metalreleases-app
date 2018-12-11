class Release {
  final int id;
  final String artist;
  final String title;
  final DateTime releaseDate;

  Release({this.id, this.artist, this.title, this.releaseDate});

  get remainingDays {
    return releaseDate.difference(DateTime.now()).inDays + 1;
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