import 'package:flutter/material.dart';
import 'package:albumreleases_app/api/release_api.dart';
import 'package:albumreleases_app/model/release.dart';
import 'package:albumreleases_app/ui/release_card.dart';

abstract class ReleaseList extends StatefulWidget {
  Future<List<Release>> _fetchReleases();

  @override
  ReleaseListState createState() => ReleaseListState();
}

class ReleaseListState extends State<ReleaseList> {
  Future<List<Release>> _releases;

  @override
  void initState() {
    super.initState();

    _releases = widget._fetchReleases();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Release>>(
      future: _releases,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ReleaseCard(snapshot.data[index]);
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.white12, size: 60),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Text('An error accured! Sorry :(', style: Theme.of(context).textTheme.subhead),
                ),
                RaisedButton(
                  child: Text('Retry'),
                  onPressed: () {
                    setState(() {
                      _releases = widget._fetchReleases();
                    });
                  }
                )
              ]
            )
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class WeekReleaseList extends ReleaseList {
  @override
  Future<List<Release>> _fetchReleases() async {
    final api = ReleaseApi();

    return await api.getWeeksReleases();
  }
}

class UpcomingReleaseList extends ReleaseList {
  @override
  Future<List<Release>> _fetchReleases() async {
    final api = ReleaseApi();

    return await api.getUpcomingReleases();
  }
}

class RecentReleaseList extends ReleaseList {
  @override
  Future<List<Release>> _fetchReleases() async {
    final api = ReleaseApi();

    return await api.getRecentReleases();
  }
}