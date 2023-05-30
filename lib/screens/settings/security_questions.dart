import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:sps_app/http_handler.dart';

import '../../widgets/primitive/wits_app_bar.dart';

class ChangeSecurityQuestionPage extends StatefulWidget {
  const ChangeSecurityQuestionPage({super.key});

  @override
  State<ChangeSecurityQuestionPage> createState() =>
      _ChangeSecurityQuestionPageState();
}

class _ChangeSecurityQuestionPageState
    extends State<ChangeSecurityQuestionPage> {
  final q1Controller = TextEditingController();
  final q2Controller = TextEditingController();

  List<String> questions1 = [];
  List<String> questions2 = [];
  int q1ID = 0;
  int q2ID = 0;
  String dropdownValue1 = "";
  String dropdownValue2 = "";
  List<Map> newQuestions = [];
  String _sucessfulMessage = "";

  void _isSucessfulMessage(bool value) {
    setState(() {
      if (value == true) {
        _sucessfulMessage = "Change security questions successful";
      } else {
        _sucessfulMessage = "Change security questions Unsuccessful";
      }
    });
  }

  @override
  void dispose() {
    q1Controller.dispose();
    q2Controller.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HTTPManager.fetchAllSecurityQuestions(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary),
            ));
          } else {
            questions1.clear();
            dropdownValue1 = "";
            for (var q in snapshot.data) {
              if (q["questionText"] != null) {
                questions1.add(
                  q["questionText"],
                );
              }
            }
            questions2.clear();
            dropdownValue2 = "";
            for (var q in snapshot.data) {
              if (q["questionText"] != null) {
                questions2.add(
                  q["questionText"],
                );
              }
            }
            dropdownValue1 = questions1[0];
            dropdownValue2 = questions2[0];
            //questions1 = List.from(snapshot.data);
            // questions2 = snapshot.data;

            return Scaffold(
                appBar: WitsAppBar(context: context),
                backgroundColor: Theme.of(context).colorScheme.background,
                body: Column(
                  // to structure the UI elements in a single column
                  children: <Widget>[
                    Container(
                        height: 50,
                        width: double.infinity,
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    width: 2))),
                        child: Row(children: [
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
                                "Security Questions",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                                textAlign: TextAlign.left,
                              ))
                        ])),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                      child: DropdownButton(
                        dropdownColor: Theme.of(context).colorScheme.background,
                        focusColor: Theme.of(context).colorScheme.secondary,
                        value: dropdownValue1,
                        icon: Icon(
                          Icons.arrow_downward,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        elevation: 16,
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onBackground),
                        underline: Container(
                          height: 2,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        items: questions1
                            .map<DropdownMenuItem<String>>((String m) {
                          return DropdownMenuItem<String>(
                            value: m,
                            child: Text(m),
                          );
                        }).toList(),
                        onChanged: (String? newvalue) {
                          debugPrint(newvalue);
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue1 = newvalue!;
                            q1ID = questions1.indexOf(dropdownValue1) + 1;
                            debugPrint(dropdownValue1);
                          });
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        // constrained box to encapsulate user input text box
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints.tight(const Size(350, 80)),
                          child: TextFormField(
                              // styles user input text box
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 3)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 3)),
                                labelText: 'Answer',
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              cursorColor:
                                  Theme.of(context).colorScheme.secondary,
                              controller: q1Controller),
                        )),
                    DropdownButton(
                      dropdownColor: Theme.of(context).colorScheme.background,
                      focusColor: Theme.of(context).colorScheme.secondary,
                      value: dropdownValue2,
                      icon: Icon(
                        Icons.arrow_downward,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      elevation: 16,
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onBackground),
                      underline: Container(
                        height: 2,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      items:
                          questions2.map<DropdownMenuItem<String>>((String m) {
                        return DropdownMenuItem<String>(
                          value: m,
                          child: Text(m),
                        );
                      }).toList(),
                      onChanged: (String? newvalue) {
                        debugPrint(newvalue);
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue2 = newvalue!;
                          q2ID = questions2.indexOf(dropdownValue2) + 1;
                          debugPrint(dropdownValue2);
                        });
                      },
                    ),
                    // padding for email text box for better UI layout
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        // constrained box to encapsulate user input text box
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints.tight(const Size(350, 80)),
                          child: TextFormField(
                              // styles user input text box
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 3)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 3)),
                                labelText: 'Answer',
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              cursorColor:
                                  Theme.of(context).colorScheme.secondary,
                              controller: q2Controller),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 2),
                        child: ConstrainedBox(
                            constraints:
                                BoxConstraints.tight(const Size(400, 40)),
                            child: Text(_sucessfulMessage,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 14),
                                textAlign: TextAlign.center))),
                    ElevatedButton(
                      onPressed: () {
                        if (q1Controller.text != "" ||
                            q2Controller.text != "") {
                          var answer1 = _hashData(q1Controller.text).toString();
                          var answer2 = _hashData(q2Controller.text).toString();
                          newQuestions
                              .add({"questionID": q1ID, "answer": answer1});
                          newQuestions
                              .add({"questionID": q2ID, "answer": answer2});
                          //debugPrint(newQuestions.toString());
                          HTTPManager.postNewQuestions(newQuestions)
                              .then((_) => {_isSucessfulMessage(true)})
                              .catchError(
                                  (_) => {_isSucessfulMessage(false), null});
                        } else {
                          (_isSucessfulMessage(false));
                        }
                      },
                      // styles login button
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary),
                      child: const Text('Confirm'),
                    ),
                  ],
                ));
          }
        });
  }

  static Digest _hashData(String data) {
    var bytes = utf8.encode(data);
    return sha256.convert(bytes);
  }
}
