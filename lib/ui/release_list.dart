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
        if (snapshot.connectionState == ConnectionState.waiting
            || snapshot.connectionState == ConnectionState.active)
          return Center(child: CircularProgressIndicator());

        if (snapshot.hasData) {
          if (snapshot.data.length == 0)
            return Center(child: Text('No releases found.'));

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

        return Container();
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

class SearchReleaseList extends ReleaseList {
  @override
  Future<List<Release>> _fetchReleases() {
    return null;
  }

  @override
  ReleaseListState createState() => SearchReleaseListState();
}

class SearchReleaseListState extends ReleaseListState {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final parent = super.build(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TextField(
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _canSearch()
                    ? () {
                      _search();
                    }
                    : null
              ),
              hintText: 'Search by artist or title',
            ),
            onChanged: (text) {
              setState(() {
                _query = text;
              });
            },
            onSubmitted: (text) {
              if (_canSearch())
                _search();
            },
          ),
        ),
        Expanded(
          child: parent,
        ),
      ],
    );
  }

  bool _canSearch() => _query.length >= 2;

  void _search() {
    setState(() {
      _releases = _fetchReleases();
    });
  }

  Future<List<Release>> _fetchReleases() async {
    final api = ReleaseApi();

    return await api.searchReleases(_query);
  }
}