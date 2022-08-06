import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todon_v_a_db/database/drift_database.dart';
import 'package:todon_v_a_db/pages/homepg.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AppDatabase(),
      child: MaterialApp(
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
      ),
    );
  }
}
