import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todon_v_a_db/constants/const.dart';
import 'package:todon_v_a_db/database/note.dart';
import 'package:todon_v_a_db/pages/completed.dart';
import 'package:todon_v_a_db/pages/homepg.dart';
import 'package:todon_v_a_db/pages/inprogress.dart';
import 'package:todon_v_a_db/pages/login.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late Box<Note> notesBox;
  late Box userBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userBox = Hive.box('userN');
    notesBox = Hive.box('notes');
    debugPrint("Notes: ${notesBox.keys}");
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF131617),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              // padding: EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF0B0D0E),
              ),
              accountName: Text(
                userBox.get('fName') + " " + userBox.get('lName'),
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
              accountEmail: Text(
                userBox.get('email'),
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/Akatsuki_sng_ur.png'),
              ),
            ),
            // All Notes
            ListTile(
              leading: const Icon(
                Icons.notes_sharp,
                color: Colors.white,
              ),
              title: Text(
                'All Notes',
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
              // subtitle: Text('Personal'),
              trailing: const Icon(
                Icons.list_alt_sharp,
                color: Colors.grey,
              ),
              onTap: () {
                _updateInfo();
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
                });
              },
            ),
            // In-Progress
            ListTile(
              leading: const Icon(
                Icons.notes_sharp,
                color: Colors.white,
              ),
              title: Text(
                'In-Progress',
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
              // subtitle: Text('Personal'),
              trailing: const Icon(
                Icons.check_circle_outlined,
                color: Colors.grey,
              ),
              onTap: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => InProgress()));
                });
              },
            ),
            // Completed
            ListTile(
              leading: const Icon(
                Icons.notes_sharp,
                color: Colors.white,
              ),
              title: Text(
                'Completed',
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
              // subtitle: Text('Personal'),
              trailing: const Icon(
                Icons.check_circle_outlined,
                color: Colors.green,
              ),
              onTap: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Completed()));
                });
              },
            ),
            // Delete All
            ListTile(
              leading: const Icon(
                Icons.warning_amber_sharp,
                color: Colors.white,
              ),
              title: Text(
                'Delete All',
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
              // subtitle: Text('Personal'),
              trailing: const Icon(
                Icons.delete_outline_sharp,
                color: Colors.red,
              ),
              onTap: () {
                deleteNote(context);
              },
            ),
            // Log-Out
            ListTile(
              leading: const Icon(
                Icons.bubble_chart_outlined,
                color: Colors.white,
              ),
              title: Text(
                'Logout',
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
              // subtitle: Text('Personal'),
              trailing: const Icon(
                Icons.logout_sharp,
                color: Colors.red,
              ),
              onTap: () {
                _updateInfo();
                setState(() {
                  navigateToLogin();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void navigateToLogin() async {
    Constants.prefs!.setBool("loggedIn", false);
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => const Login()));
  }

  _updateInfo() {
    userBox.put('fName', "Coders");
  }

  Future<dynamic> deleteNote(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black87,
            title: Text("Warning!"),
            content: Text("Do you really want to delete all the notes?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  notesBox.clear();
                  Navigator.pop(context, true);
                },
                child: Text("Yes!"),
              ),
            ],
          );
        });
  }
}
