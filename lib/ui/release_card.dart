import 'package:flutter/material.dart';
import 'package:albumreleases_app/model/release.dart';
import 'package:intl/intl.dart';

class ReleaseCard extends StatelessWidget {
  final Release _release;

  ReleaseCard(this._release);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4),
        child: ListTile(
            trailing: _release.remainingDays > 0
                ? CircleAvatar(
                  child: Text(_release.remainingDays.toString(), style: TextStyle(fontWeight: FontWeight.w600)),
                  backgroundColor: Colors.white10,
                  foregroundColor: Colors.white54,
                )
                : null,
            title: Text(_release.artist.toUpperCase(), style: Theme.of(context).textTheme.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 8.0),
                  child: Text(_release.title, style: Theme.of(context).textTheme.subtitle),
                ),
                Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 3.0),
                        child: Icon(Icons.event, size: 16, color: Colors.white54),
                      ),
                      Text(DateFormat.yMMMMd().format(_release.releaseDate), style: Theme.of(context).textTheme.caption),
                    ]
                ),
              ],
            )
        ),
      ),
    );
  }
}