import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todon_v_a_db/constants/const.dart';
import 'package:todon_v_a_db/database/note.dart';
import 'package:todon_v_a_db/pages/homepg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todon_v_a_db/pages/login.dart';

Future main() async {
  // Initialize
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Registing Adapter for the custom objects
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(UserInfoAdapter());

  // Open Box
  int _reverseOrder(k1, k2) {
    if (k1 is int) {
      if (k2 is int) {
        if (k1 > k2) {
          return -1;
        } else if (k1 < k2) {
          return 1;
        } else {
          return 0;
        }
      } else {
        return -1;
      }
    }
    return 0;
  }

  await Hive.openBox<Note>('notes', keyComparator: _reverseOrder);
  await Hive.openBox('userN');

  // Shared Prefs
  Constants.prefs = await SharedPreferences.getInstance();

  // Run the widgets
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "New TODO App Practice",
      home: Constants.prefs!.getBool("loggedIn") == true ? HomePage() : Login(),
      theme: ThemeData(
        primaryColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
        scaffoldBackgroundColor: const Color(0xFF131617),
        primarySwatch: Colors.deepPurple,
        primaryTextTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
            fontFamily: 'Edu VIC',
            letterSpacing: 1,
            fontSize: 18,
          ),
          bodyText2: TextStyle(
            color: Colors.black,
            fontFamily: 'Edu VIC',
            letterSpacing: 1,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
