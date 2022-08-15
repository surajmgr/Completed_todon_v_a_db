import 'package:flutter/material.dart';
import 'package:todon_v_a_db/constants/const.dart';
import 'package:todon_v_a_db/pages/homepg.dart';

class Login extends StatefulWidget {
  // const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  // final avatarController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: 330,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Edu VIC',
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          // decoration: TextDecoratio
                        ),
                      ),
                    ),
                  ),
                  // Profile Picture
                  Container(
                    // height: 100,
                    width: 330,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          CircleAvatar(radius: 50),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              bottom: 2, // Space between underline and text
                            ),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: Colors.purple,
                              width: 1.0, // Underline thickness
                            ))),
                            child: const Text(
                              "Profile Picture",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // First Name
                  Container(
                    width: 320,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 15, left: 30, right: 30),
                      child: TextFormField(
                        maxLength: 15,
                        maxLines: 1,
                        controller: firstNameController,
                        onChanged: (value) {
                          debugPrint(
                              "Something changed in the Title Text Field!");
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          counterText: "",
                          labelText: "First name",
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1.2, color: Colors.black),
                            // borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1.2, color: Colors.purple),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          contentPadding: EdgeInsets.only(
                              left: 5, bottom: 0, top: 5, right: 5),
                        ),
                      ),
                    ),
                  ),
                  // Last Name
                  Container(
                    width: 320,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 30, right: 30),
                      child: TextFormField(
                        maxLength: 15,
                        maxLines: 1,
                        controller: lastNameController,
                        onChanged: (value) {
                          debugPrint(
                              "Something changed in the Title Text Field!");
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          counterText: "",
                          labelText: "Last name",
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.2, color: Colors.black),
                            // borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1.2, color: Colors.purple),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          contentPadding: EdgeInsets.only(
                              left: 5, bottom: 0, top: 5, right: 5),
                        ),
                      ),
                    ),
                  ),
                  // Email
                  Container(
                    width: 320,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 30, right: 30),
                      child: TextFormField(
                        // maxLength: 15,
                        maxLines: 1,
                        controller: emailController,
                        onChanged: (value) {
                          debugPrint(
                              "Something changed in the Title Text Field!");
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          counterText: "",
                          labelText: "Email address",
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.2, color: Colors.black),
                            // borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1.2, color: Colors.purple),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          contentPadding: EdgeInsets.only(
                              left: 5, bottom: 0, top: 5, right: 5),
                        ),
                      ),
                    ),
                  ),
                  // Button
                  Container(
                    width: 330,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 50, right: 50, bottom: 30),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              // side: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Login",
                          // textScaleFactor: 1.5,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToDetails() async {
    bool res =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomePage();
    }));
    if (res == true) {
      debugPrint("Hey It's restated!");
      setState(() {});
    }
  }
}
