import 'package:flutter/material.dart';
import 'package:albumreleases_app/ui/about.dart';
import 'package:albumreleases_app/ui/custom_icons.dart';
import 'package:albumreleases_app/ui/release_list.dart';
import 'package:albumreleases_app/ui/search.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Metal', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white70)),
            Text('Releases', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white54)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Search(),
                    fullscreenDialog: true,
                ),
              );
            },
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'about',
                  child: Text('About'),
                )
              ];
            },
            onSelected: (result) {
              switch (result) {
                case 'about':
                  showAbout(context);
                  break;
              }
            }
          )
        ],
      ),
      body: Stack(
        children: [
          Offstage(
            offstage: _currentIndex != 0,
            child: TickerMode(
              enabled: _currentIndex == 0,
              child: WeekReleaseList(),
            ),
          ),
          Offstage(
            offstage: _currentIndex != 1,
            child: TickerMode(
              enabled: _currentIndex == 1,
              child: UpcomingReleaseList(),
            ),
          ),
          Offstage(
            offstage: _currentIndex != 2,
            child: TickerMode(
              enabled: _currentIndex == 2,
              child: RecentReleaseList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.metal_horns),
              title: Text('This Week')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range),
              title: Text('Upcoming')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text('Recent')
          ),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}