import 'package:flutter/material.dart';

List<String> list1 = <String>['One', 'Two', 'Three', 'Four'];
List<String> list2 = <String>['One', 'Two', 'Three', 'Four'];

class ChangeSecurityQuestionPage extends StatefulWidget {
  const ChangeSecurityQuestionPage({super.key});

  @override
  State<ChangeSecurityQuestionPage> createState() => _ChangeSecurityQuestionPageState();
}

class _ChangeSecurityQuestionPageState extends State<ChangeSecurityQuestionPage> {
  String dropdownValue1 = list1.first;
  String dropdownValue2 = list2.first;

  final q1Controller = TextEditingController();
  final q2Controller = TextEditingController();
  /*final Map<String, dynamic> _question1 = LoginManager.getQuestion(0);
  final Map<String, dynamic> _question2 = LoginManager.getQuestion(1);
  String _invalidMessage = "";

  void _isValidMessage(bool value) {
    setState(() {
      if (value == true) {
        _invalidMessage = "";
      } else {
        _invalidMessage = "Incorrect answers";
      }
    });
  }*/

  @override
  void dispose() {
    q1Controller.dispose();
    q2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfffcfbfb),
        body: Column(
          // to structure the UI elements in a single column
              children: <Widget>[
                Container(
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.bottomLeft,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Color(0xff917248), width: 2))),
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
                                  )))),
                      Container(
                          height: 50,
                          width: 300,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Security Questions",
                            style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.left,
                          ))
                    ])
                ),
                DropdownButton(
                  value: dropdownValue1,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: const Color(0xff917248),
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue1 = value!;
                    });
                  },
                  items: list1.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    // constrained box to encapsulate user input text box
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(300, 80)),
                      child: TextFormField(
                        // styles user input text box
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xff917248), width: 3)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xff917248), width: 3)),
                            labelText: 'answer',
                            labelStyle: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          cursorColor: const Color(0xff917248),
                          controller: q1Controller),
                    )
                ),
                DropdownButton(
                  value: dropdownValue2,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: const Color(0xff917248),
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue2 = value!;
                    });
                  },
                  items: list2.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                // padding for email text box for better UI layout
                Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    // constrained box to encapsulate user input text box
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(300, 80)),
                      child: TextFormField(
                        // styles user input text box
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xff917248), width: 3)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xff917248), width: 3)),
                            labelText: 'New Password',
                            labelStyle: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          cursorColor: const Color(0xff917248),
                          controller: q2Controller),
                    )
                ),
                ElevatedButton(
                  onPressed: () {

                  },
                  // styles login button
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff043673)),
                  child: const Text('Confirm'),
                ),
              ],
        )
    );
  }
}