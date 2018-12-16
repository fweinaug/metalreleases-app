import 'package:flutter/material.dart';
import 'package:albumreleases_app/ui/release_list.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: SearchReleaseList(),
    );
  }
}