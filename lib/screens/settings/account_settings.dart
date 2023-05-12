import 'dart:typed_data';

import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  var username = TextEditingController();
  var cellNumber = TextEditingController();
  var email = ''; //come back
  final Uint8List photo = Uint8List(0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            width: double.infinity,
            alignment: Alignment.bottomLeft,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xff917248), width: 2)
                )
            ),
            child: Row(children: [
              Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 30,
                            color: Colors.black,
                          )
                      )
                  )
              ),
              Container(
                  height: 50,
                  width: 300,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Account Settings",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.left,
                  )
              )
            ],
            ),
          ),
          const Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          ),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: const Color(0xFF043673),
              border: Border.all(
                color: const Color(0xff917248),
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(75),
            ),
            //child: CircleAvatar(
              //radius: 25,
              //backgroundImage: MemoryImage(bytes, {scale: 1}),
            //),
          ),
          const Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          ),
          Container(
            height: 40,
            width: 300,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xff917248), width:2)
              )
            ),
            child: const Text(
                "username",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
            ),
          ),
          const Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          ),
          Container(
            height: 40,
            width: 300,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xff917248), width:2)
                )
            ),
            child: const Text(
              "phone number",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
            ),
          ),
          const Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          ),
          Container(
            height: 40,
            width: 300,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xff917248), width:2)
                )
            ),
            child: const Text(
              "email",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }
}