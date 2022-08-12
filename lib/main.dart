import 'package:flutter/material.dart';
import 'package:todon_v_a_db/database/note.dart';
import 'package:todon_v_a_db/pages/homepg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  // Initialize
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Registing Adapter for the custom objects
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(UserInfoAdapter());

  // Open Box
  await Hive.openBox<Note>('notes');
  await Hive.openBox<UserInfo>('user');

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
      home: HomePage(),
      theme: ThemeData(
        primaryColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
        scaffoldBackgroundColor: const Color(0xFF131617),
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}
