// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todon_v_a_db/pages/notedetails.dart';
import 'package:todon_v_a_db/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Container(
        padding: EdgeInsets.only(top: 5, bottom: 20),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              HeadingHP(name: 'Suraj'),
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
          navigateToDetails('Add Note');
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
      itemCount: 0,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            navigateToDetails('Edit Note');
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
                          "noteData.title",
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
                                setState(() {});
                                debugPrint("List Tile is Checked!");
                              },
                              icon: Icon(
                                Icons.check_circle_outline,
                                color: getStateColor(1),
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.fromLTRB(10, 0, 3, 0),
                              constraints: BoxConstraints(),
                              // splashRadius: 15,
                              onPressed: () {
                                deleteNote(context);
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
                        "{noteData.description}",
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
                      children: const [
                        Text(
                          "2022-08-28",
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
      },
    );
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
                  setState(() {});
                },
                child: Text("Yes!"),
              ),
            ],
          );
        });
  }

  void navigateToDetails(String title) async {
    bool res =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetails(appBarTitle: title);
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
    required this.name,
  }) : super(key: key);

  final String? name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.indigoAccent,
            radius: 32,
            child: CircleAvatar(
              backgroundColor: Colors.black87,
              radius: 30,
              backgroundImage: AssetImage('assets/Akatsuki_sng_ur.png'),
              // child: ClipRRect(
              //   child: Image.asset('assets/Akatsuki_sng_ur.png'),
              //   borderRadius: BorderRadius.circular(50.0),
              // ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Hello, ${name ?? 'Coders'}!",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Alex Brush',
              fontSize: 50,
              //backgroundColor: Colors.amberAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "This is your todo-list.\nYou still have 5 tasks in the list.",
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
