// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todon_v_a_db/pages/notedetails.dart';
import 'package:todon_v_a_db/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  var txt = "List of the Notes";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(
              Icons.auto_awesome,
              size: 25,
            ),
          ),
        ),
        title: Text(
          txt,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: const Color(0xFF0B0D0E),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_sharp),
          )
        ],
      ),
      body: getNotesListView(),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(190, 12, 12, 12),
        onPressed: (() {
          navigateToDetails("Add Note");
          // _showSnackBar('context', "New Add Notes!");
        }),
        child: const Center(
          child: Icon(
            Icons.add,
            size: 35.0,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  ListView getNotesListView() {
    // TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: 0,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(40, 28, 40, 0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            color: Colors.white12,
            child: ListTile(
              leading: Icon(Icons.check_circle_outline),
              title: Text(
                "this.noteList![index].title!",
                style: TextStyle(
                  // decoration: TextDecoration.underline,
                  // color: Colors.amberAccent,
                  fontFamily: 'EDU VIC',
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
              subtitle: Text(
                "this.noteList![index].description!\n",
                style: TextStyle(
                  color: Colors.white70,
                  fontFamily: 'Edu VIC',
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: GestureDetector(
                child: Icon(Icons.delete),
                onTap: () {
                  // _delete(context, noteList![index]);
                },
              ),
              onTap: () {
                debugPrint("List Tile is tapped!");
                navigateToDetails("Edit Note");
              },
            ),
          ),
        );
      },
    );
  }

  // void _showSnackBar(BuildContext context, String message) {
  //   final snackBar = SnackBar(content: Text(message));
  //   Scaffold.of(context).showSnackBar(snackBar);
  // }

  void navigateToDetails(String title) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetails(title);
    }));
  }
}
