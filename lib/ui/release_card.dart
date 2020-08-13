import 'package:albumreleases_app/model/spotify.dart';
import 'package:flutter/material.dart';
import 'package:albumreleases_app/model/release.dart';
import 'package:intl/intl.dart';

class ReleaseCard extends StatelessWidget {
  final Release release;

  const ReleaseCard(this.release);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
        child: ListTile(
            trailing: release.isPlayable
                ? PlayButton(release)
                : !release.isReleased
                  ? RemainingDays(release)
                  : null,
            title: Text(release.artist.toUpperCase(), style: Theme.of(context).textTheme.headline6),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 8.0),
                  child: Text(release.title, style: Theme.of(context).textTheme.subtitle2),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 3.0),
                      child: Icon(Icons.event, size: 16.0, color: Colors.white54),
                    ),
                    Text(DateFormat.yMMMMd().format(release.releaseDate), style: Theme.of(context).textTheme.caption),
                  ],
                ),
              ],
            ),
        ),
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  final Release release;

  const PlayButton(this.release);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.white12,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Icon(Icons.play_arrow, size: 26.0),
        ),
        onTap: () => launchSpotify(release.spotify),
      ),
    );
  }
}

class RemainingDays extends StatelessWidget {
  final Release release;

  const RemainingDays(this.release);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        release.remainingDays.toString(),
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      backgroundColor: Colors.white10,
      foregroundColor: Colors.white54,
    );
  }
}