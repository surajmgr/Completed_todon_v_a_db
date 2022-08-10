// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todon_v_a_db/database/note.dart';

class NoteDetails extends StatefulWidget {
  final String appBarTitle;
  late Box<Note> noteBox;
  late int? index;

  NoteDetails({
    Key? key,
    required this.appBarTitle,
    required this.noteBox,
    required this.index,
  }) : super(key: key);

  @override
  State<NoteDetails> createState() => NoteDetailsState();
}

class NoteDetailsState extends State<NoteDetails> {
  static var _state = ['In-Progress', 'Completed'];
  bool _cP = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var noteData;

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();

    super.initState();
    if (widget.index != null) {
      noteData = widget.noteBox.getAt(widget.index!);
      titleController.text = noteData.title;
      descriptionController.text = noteData.description ?? "";
      _cP = noteData.isCompleted;
      debugPrint("Notes: ${noteData!.key}");
    } else {
      noteData = null;
      debugPrint("Notes: ${widget.noteBox.keys}");
      _cP = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => moveToLastScreen(),
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 25,
            ),
          ),
        ),
        title: Text(
          widget.appBarTitle,
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
              iconPress("Save");
              debugPrint("Saved!!!");
            },
            icon: const Icon(Icons.save_outlined),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                deleteNote(context);
              },
              icon: const Icon(Icons.delete_outlined),
            ),
          )
        ],
      ),

      // Details Page
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 15, 10, 20),
        child: ListView(
          children: [
            // Dropdown State
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ListTile(
                title: DropdownButton(
                  hint: Text("State of the Note"),
                  // focusColor: Colors.amberAccent,
                  dropdownColor: Color.fromARGB(190, 12, 12, 12),
                  items: _state.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  value: updateString(_cP),
                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      if (valueSelectedByUser == 'In-Progress') {
                        _cP = false;
                      } else {
                        _cP = true;
                      }
                      debugPrint("User selected $valueSelectedByUser");
                    });
                  },
                ),
              ),
            ),

            // Title Text Field
            Padding(
              padding:
                  EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
              child: TextFormField(
                maxLength: 30,
                maxLines: 1,
                controller: titleController,
                onChanged: (value) {
                  debugPrint("Something changed in the Title Text Field!");
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  counterText: "",
                  labelText: "Title...",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1.7, color: Colors.white),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1.7, color: Colors.purple),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),

            // Description Text Field
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 15, left: 20, right: 20),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.top,
                maxLength: 255,
                minLines: 1,
                maxLines: 15,
                controller: descriptionController,
                onChanged: (value) {
                  debugPrint(
                      "Something changed in the Description Text Field!");
                },
                decoration: InputDecoration(
                  counterStyle: TextStyle(color: Colors.white),
                  label: Text(
                    "Description...",
                    style: TextStyle(color: Colors.white),
                  ),
                  alignLabelWithHint: true,
                  // hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1.7, color: Colors.white),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1.7, color: Colors.purple),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),

            // Buttons
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Save
                  ElevatedButton(
                    child: Text(
                      "Save",
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      // _showAlertDialog('Status', 'No Note was deleted!');
                      iconPress("Save");
                      if (noteData == null) {
                        _addInfo();
                      } else {
                        _updateInfo();
                      }
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  // Delete
                  ElevatedButton(
                    child: Text(
                      "Delete",
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      deleteNote(context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      backgroundColor: Colors.black87,
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void iconPress(String title) {
    setState(() {
      moveToLastScreen();
      _showAlertDialog('Status', 'Note ${title}d Successfully!');
      debugPrint("$title button is clicked!");
    });
  }

  updateString(bool? _cPn) {
    if (_cPn == true) {
      return 'Completed';
    } else {
      return 'In-Progress';
    }
  }

  Future<dynamic> deleteNote(BuildContext context) {
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
                  iconPress("Delete");
                },
                child: Text("Yes!"),
              ),
            ],
          );
        });
  }

  // Add the data
  _addInfo() {
    Note newNote = Note(
      title: titleController.text,
      description: descriptionController.text,
      date: DateTime.now(),
      isCompleted: _cP,
    );
    widget.noteBox.add(newNote);
    debugPrint("Info Added: \n $newNote");
    debugPrint("Key: ${newNote.key}");
    moveToLastScreen();
  }

  // Update the data
  _updateInfo() {
    Note updateNote = Note(
      title: titleController.text,
      description: descriptionController.text,
      date: DateTime.now(),
      isCompleted: _cP,
    );
    widget.noteBox.putAt(widget.index!, updateNote);
    debugPrint("Info Added: \n $updateNote");
    debugPrint("Key: ${updateNote.key}");
    moveToLastScreen();
  }
}
