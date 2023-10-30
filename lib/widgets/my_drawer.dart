import 'package:alrabb/screens/meetings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 30),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Meeting()));
            },
            leading: Text(
              "Attend Alrabb Class",
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            onTap: () async {
              final url = 'https://meet.google.com/';
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
            leading: Text(
              "Create Google class",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
