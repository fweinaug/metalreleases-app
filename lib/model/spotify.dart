import 'package:url_launcher/url_launcher.dart';

class Spotify {
  final String id;
  final String uri;
  final String url;

  Spotify({
    this.id,
    this.uri,
    this.url,
  });

  factory Spotify.fromJson(Map<String, dynamic> json) {
    return Spotify(
      id: json['id'] as String,
      uri: json['uri'] as String,
      url: json['url'] as String,
    );
  }
}

Future<void> launchSpotify(Spotify spotify) async {
  if (await canLaunch('spotify:')) {
    launch(spotify.uri);
  }
}