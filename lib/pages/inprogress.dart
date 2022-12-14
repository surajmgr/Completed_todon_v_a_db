// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todon_v_a_db/database/note.dart';
import 'package:todon_v_a_db/pages/homepg.dart';
import 'package:todon_v_a_db/pages/notedetails.dart';
import 'package:todon_v_a_db/widgets/drawer.dart';

class InProgress extends StatefulWidget {
  // const HomePage({Key? key});

  @override
  State<InProgress> createState() => _InProgressState();
}

class _InProgressState extends State<InProgress> {
  var txt = "In-Progress Notes";
  int? red;

  late Box<Note> notesBox;
  late Box userBox;

  int completedNoteLength = 0;
  int incompletedNoteLength = 0;

  //Hide Status
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
    notesBox = Hive.box('notes');
    userBox = Hive.box('userN');
    debugPrint("Notes: ${notesBox.keys}");
  }

  // Close Hive Box
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    completedNoteLength =
        notesBox.values.where((note) => note.isCompleted).length;
    incompletedNoteLength =
        notesBox.values.where((note) => !note.isCompleted).length;

    // .forEach(((element) => completedNoteLength++));
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
            onPressed: () {
              setState(() {
                notesBox.clear();
              });
            },
            icon: const Icon(Icons.search_sharp),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 5, bottom: 20),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              HeadingHP(
                name: userBox.get('fName') != ""
                    ? userBox.get('fName')
                    : "Coders",
                iLength: incompletedNoteLength,
                cLength: completedNoteLength,
              ),
              // List Builder
              noteListUI(),
              // End
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "End of the List!",
                    style: TextStyle(
                      // decoration: TextDecoration.underline,
                      // color: Colors.amberAccent,
                      fontFamily: 'EDU VIC',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(190, 12, 12, 12),
        onPressed: (() {
          navigateToDetails('Add Note', red);
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

  Widget noteListUI() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: notesBox.length,
      itemBuilder: (BuildContext context, int index) {
        var noteData = notesBox.getAt(index)!;
        // var noteData = filtered[index];
        debugPrint("${noteData.key}: $index");
        if (!noteData.isCompleted) {
          return InkWell(
            onTap: () {
              navigateToDetails('Edit Note', index);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                color: Colors.white12,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 12, 12, 7),
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
                                    var _cP = checkNote(noteData.isCompleted);
                                    notesBox.putAt(
                                        index,
                                        Note(
                                          title: noteData.title,
                                          description: noteData.description,
                                          date: noteData.date,
                                          isCompleted: _cP,
                                        ));
                                  });
                                  debugPrint("List Tile is Checked!");
                                },
                                icon: Icon(
                                  Icons.check_circle_outline,
                                  color: getStateColor(noteData.isCompleted),
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.fromLTRB(10, 0, 3, 0),
                                constraints: BoxConstraints(),
                                // splashRadius: 15,
                                onPressed: () {
                                  deleteNote(context, index);
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
                          noteData.description ?? "\n",
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
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Future<dynamic> deleteNote(BuildContext context, int index) {
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
                    notesBox.deleteAt(index);
                  });
                },
                child: Text("Yes!"),
              ),
            ],
          );
        });
  }

  void navigateToDetails(String title, int? index) async {
    bool res =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetails(
        appBarTitle: title,
        noteBox: notesBox,
        index: index,
      );
    }));
    if (res == true) {
      debugPrint("Hey It's restated!");
      setState(() {});
    }
  }

  Color getStateColor(bool _cPn) {
    switch (_cPn) {
      case false:
        return Colors.white70;
        break;
      case true:
        return Colors.green;
        break;
      default:
        return Colors.white70;
    }
  }

  bool checkNote(bool isCompleted) {
    if (isCompleted == false) {
      return true;
    } else {
      return false;
    }
  }
}
