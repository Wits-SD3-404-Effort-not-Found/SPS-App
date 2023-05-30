//import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sps_app/http_handler.dart';
import 'package:sps_app/screens/settings/settings.dart';
import 'package:sps_app/widgets/primitive/wits_app_bar.dart';
import '../../account_manager.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  var usernameController = TextEditingController();
  var cellNumberController = TextEditingController();
  var email = AccountManager.getEmail();
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

  Future<bool> _autoSave() async {
    AccountManager.setUsername(usernameController.text);
    AccountManager.setCellNumber(cellNumberController.text);
    HTTPManager.putUpdatedAccountSettings();
    return true;
  }

// coverage:ignore-start
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HTTPManager.getAccountSettings(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          //debugPrint(snapshot.data['username']);
          if (snapshot.data == null) {
            return Scaffold(
                appBar: WitsAppBar(context: context),
                backgroundColor: Theme.of(context).colorScheme.background,
                body: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ));
          } else {
            AccountManager.setUsername(snapshot.data[0]);
            AccountManager.setCellNumber(snapshot.data[1]);
          }

          return Scaffold(
            appBar: WitsAppBar(context: context),
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 2))),
                  child: Row(
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    size: 30,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  )))),
                      Container(
                          height: 50,
                          width: 300,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Account Settings",
                            style: TextStyle(
                                fontSize: 30,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                            textAlign: TextAlign.left,
                          ))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                Container(
                    height: 40,
                    width: 300,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Username:",
                      style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).colorScheme.onBackground),
                      textAlign: TextAlign.left,
                    )),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                Container(
                  height: 40,
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 2))),
                  child: TextField(
                    controller: usernameController,
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onBackground),
                    textAlign: TextAlign.left,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                Container(
                    height: 50,
                    width: 300,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Cellphone Number:",
                      style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).colorScheme.onBackground),
                      textAlign: TextAlign.left,
                    )),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                Container(
                  height: 40,
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 2))),
                  child: TextField(
                    controller: cellNumberController,
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onBackground),
                    textAlign: TextAlign.left,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                Container(
                    height: 40,
                    width: 300,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email:",
                      style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).colorScheme.onBackground),
                      textAlign: TextAlign.left,
                    )),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                Container(
                  height: 40,
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 2))),
                  child: Text(
                    email,
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onBackground),
                    textAlign: TextAlign.left,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                ElevatedButton(
                    onPressed: () {
                      _autoSave();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary),
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 16),
                    ))
              ],
            ),
          );
        });
  } // coverage:ignore-end
}
