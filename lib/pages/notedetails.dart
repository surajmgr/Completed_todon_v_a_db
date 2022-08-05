// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NoteDetails extends StatefulWidget {
  final String appBarTitle;

  NoteDetails(this.appBarTitle);

  @override
  State<NoteDetails> createState() => NoteDetailsState(this.appBarTitle);
}

class NoteDetailsState extends State<NoteDetails> {
  static var _state = ['In-Progress', 'Completed'];
  static var _cState = _state[0];

  String appBarTitle;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  NoteDetailsState(this.appBarTitle);

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
          appBarTitle,
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

      // Dropdown State
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 15, 10, 20),
        child: ListView(
          children: [
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
                  value: _cState,
                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      _cState = "$valueSelectedByUser";
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
              child: TextField(
                controller: titleController,
                onChanged: (value) {
                  debugPrint("Something changed in the Title Text Field!");
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
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
              child: TextField(
                controller: descriptionController,
                onChanged: (value) {
                  debugPrint(
                      "Something changed in the Description Text Field!");
                },
                decoration: InputDecoration(
                  labelText: "Description...",
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

            // Buttons
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text(
                      "Save",
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      // _showAlertDialog('Status', 'No Note was deleted!');
                      setState(() {
                        moveToLastScreen();
                        _showAlertDialog('Status', 'Note Saved Successfully!');
                        debugPrint("Save button is clicked!");
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    child: Text(
                      "Delete",
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {
                        moveToLastScreen();
                        _showAlertDialog(
                            'Status', 'Note Deleted Successfully!');
                        debugPrint("Delete button is clicked!");
                      });
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
    Navigator.pop(context);
  }

  void updateState(String value) {
    switch (value) {
      case 'In-Progress':
        //note.state = 1;
        break;
      case 'Completed':
        //note.state = 2;
        break;
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      backgroundColor: Colors.black87,
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
