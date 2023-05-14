//import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sps_app/http_handler.dart';
import '../../account_manager.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  var usernameController = TextEditingController();
  var cellNumberController = TextEditingController();
  var email = ''; //come back
  //Uint8List photo = Uint8List(0);

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController.fromValue(
      TextEditingValue(
        text: AccountManager.getUsername(),
      ),
    );
    AccountManager.setUsername(usernameController.text);

    cellNumberController = TextEditingController.fromValue(
      TextEditingValue(
        text: AccountManager.getCellNumber(),
      ),
    );
    AccountManager.setCellNumber(cellNumberController.text);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HTTPManager.getAccountSettings(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          //debugPrint(snapshot.data['username']);
        if (snapshot.data == null) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
            child: CircularProgressIndicator(
            color: Color(0xff917248),
            ),
          ));
        } else {
          AccountManager.setUsername(snapshot.data[0]);
          AccountManager.setCellNumber(snapshot.data[1]);
          //AccountManager.setPhoto(snapshot.data[2]);
          //debugPrint(snapshot.data[2]);
        }

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
          /*
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              //color: const Color(0xFF043673),
              color: Colors.lightGreen,
              border: Border.all(
                color: const Color(0xff917248),
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(75),
            ),

            child: Image(
              //radius: 25,
              //backgroundImage: MemoryImage(AccountManager.getPhoto()),
              image: MemoryImage(AccountManager.getPhoto()),
            ),
          ),*/
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
            child: TextField(
              controller: usernameController,
              style: const TextStyle(fontSize: 20),
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
            child: TextField(
              controller: cellNumberController,
              style: const TextStyle(fontSize: 20),
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
    );
  }
}