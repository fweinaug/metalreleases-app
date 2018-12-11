import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

void showAbout(BuildContext context) async {
  final info = await PackageInfo.fromPlatform();

  showAboutDialog(
      context: context,
      applicationName: info.appName,
      applicationVersion: info.version,
      applicationIcon: Image.asset('images/logo.png'),
      applicationLegalese: 'Developed by Florian Weinaug\nMetal Horns made by Freepik from flaticon.com',
      children: [
        RaisedButton(child: Text('Send Feedback'), onPressed: sendFeedback,),
        RaisedButton(child: Text('Visit Website'), onPressed: openWebsite,),
      ],
  );
}

void openWebsite() async {
  const url = 'http://florianweinaug.de';

  if (await canLaunch(url)) {
    await launch(url);
  }
}

void sendFeedback() async {
  final info = await PackageInfo.fromPlatform();
  final url = "mailto:fweinaug-apps@outlook.com?subject=${info.appName}";

  if (await canLaunch(url)) {
    await launch(url);
  }
}