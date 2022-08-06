// ignore_for_file: prefer_const_constructors

import 'package:drift/drift.dart' as dr;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todon_v_a_db/database/drift_database.dart';
import 'package:todon_v_a_db/pages/notedetails.dart';
import 'package:todon_v_a_db/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppDatabase database;

  var txt = "List of the Notes";

  //Hide Status
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    database = Provider.of<AppDatabase>(context);
    return Scaffold(
      // extendBodyBehindAppBar: true,
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
      body: FutureBuilder<List<NoteData>>(
        future: _getNoteFromDatabase(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<NoteData>? noteList = snapshot.data;
            if (noteList != null) {
              if (noteList.isEmpty) {
                debugPrint("Note List is Empty!");
                return Center(
                  child: getNotesListView(),
                );
              } else {
                debugPrint("Something's in the Note List!");
                return Container(
                  padding: EdgeInsets.only(top: 5, bottom: 20),
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      children: [
                        HeadingHP(noteList: noteList),
                        noteListUI(noteList),
                      ],
                    ),
                  ),
                );
              }
            }
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return Center(
            child: Container(),
          );
        },
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(190, 12, 12, 12),
        onPressed: (() {
          navigateToDetails(
              'Add Note',
              NoteCompanion(
                title: dr.Value(''),
                description: dr.Value(''),
                date: dr.Value(DateTime.now()),
                priority: dr.Value(1),
                color: dr.Value(7),
              ));
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
                // navigateToDetails("Edit Note");
              },
            ),
          ),
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Future<List<NoteData>> _getNoteFromDatabase() async {
    return await database.getNoteList;
  }

  Widget noteListUI(List<NoteData> noteList) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: noteList.length,
      itemBuilder: (BuildContext context, int index) {
        NoteData noteData = noteList[index];
        return InkWell(
          onTap: () {
            navigateToDetails(
                'Edit Note',
                NoteCompanion(
                  id: dr.Value(noteData.id),
                  title: dr.Value(noteData.title),
                  description: dr.Value(noteData.description),
                  priority: dr.Value(noteData.priority),
                  date: dr.Value(noteData.date),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              color: Colors.white12,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Title & Trailings
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          noteData.title,
                          style: TextStyle(
                            // decoration: TextDecoration.underline,
                            // color: Colors.amberAccent,
                            fontFamily: 'EDU VIC',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Check & Delete
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              padding: EdgeInsets.fromLTRB(10, 0, 7, 0),
                              constraints: BoxConstraints(),
                              // splashRadius: 15,
                              onPressed: () {
                                setState(() {
                                  int _cPP;
                                  if (noteData.priority != 2) {
                                    _cPP = 2;
                                  } else {
                                    _cPP = 1;
                                  }
                                  database.updateNote(NoteData(
                                    id: noteData.id,
                                    title: noteData.title,
                                    description: noteData.description,
                                    date: DateTime.now(),
                                    // color: Value(1),
                                    priority: _cPP,
                                  ));
                                  // database.updateNote(NoteData(
                                  //     id: noteData.id,
                                  //     title: noteData.title,
                                  //     priority: 2));
                                });
                                debugPrint("List Tile is Checked!");
                              },
                              icon: Icon(
                                Icons.check_circle_outline,
                                color: getStateColor(noteData.priority!),
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.fromLTRB(10, 0, 3, 0),
                              constraints: BoxConstraints(),
                              // splashRadius: 15,
                              onPressed: () {
                                deleteNote(context, noteData);
                              },
                              icon: Icon(
                                Icons.delete_outlined,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    //Descriptions
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Text(
                        "${noteData.description}",
                        style: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Edu VIC',
                          // fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    //Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          noteData.date.toString().substring(0, 16),
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    )
                    // ListTile(
                    //   leading: GestureDetector(
                    //     child: Icon(
                    //       Icons.check_circle_outline,
                    //       color: getStateColor(noteData.priority!),
                    //     ),
                    //     onTap: () {
                    //       setState(() {
                    //         //Update Color
                    //       });
                    //       debugPrint("List Tile is Checked!");
                    //     },
                    //   ),
                    //   title: Text(
                    //     noteData.title,
                    //     style: TextStyle(
                    //       // decoration: TextDecoration.underline,
                    //       // color: Colors.amberAccent,
                    //       fontFamily: 'EDU VIC',
                    //       fontSize: 28,
                    //       fontWeight: FontWeight.w400,
                    //     ),
                    //   ),
                    //   subtitle: Text(
                    //     "${noteData.description}\n",
                    //     style: TextStyle(
                    //       color: Colors.white70,
                    //       fontFamily: 'Edu VIC',
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.w300,
                    //     ),
                    //   ),
                    //   trailing: GestureDetector(
                    //     child: Icon(Icons.delete),
                    //     onTap: () {
                    //       // _delete(context, noteList![index]);
                    //       debugPrint("List Tile is Deleted!");
                    //     },
                    //   ),
                    //   onTap: () {
                    //     debugPrint("List Tile is tapped!");
                    //     // navigateToDetails("Edit Note");
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> deleteNote(BuildContext context, NoteData noteData) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black87,
            title: Text("Warning!"),
            content: Text("Do you really want to delete this note?"),
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
                  setState(() {
                    database.deleteNote(noteData);
                  });
                },
                child: Text("Yes!"),
              ),
            ],
          );
        });
  }

  void navigateToDetails(String title, NoteCompanion noteCompanion) async {
    bool res =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetails(
        appBarTitle: title,
        noteCompanion: noteCompanion,
      );
    }));
    if (res == true) {
      debugPrint("Hey It's restated!");
      setState(() {});
    }
  }

  Color getStateColor(int state) {
    switch (state) {
      case 1:
        return Colors.white70;
        break;
      case 2:
        return Colors.green;
        break;
      default:
        return Colors.white70;
    }
  }
}

class HeadingHP extends StatelessWidget {
  const HeadingHP({
    Key? key,
    required this.noteList,
  }) : super(key: key);

  final List<NoteData>? noteList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello, Coders!",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Alex Brush',
              fontSize: 50,
              //backgroundColor: Colors.amberAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "This is your todo-list, Today, you have ${noteList?.length} tasks to complete.",
            style: TextStyle(
              color: Colors.white70,
              fontFamily: 'Edu VIC',
              fontSize: 19,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }
}
