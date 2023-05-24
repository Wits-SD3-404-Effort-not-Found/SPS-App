import 'package:flutter/material.dart';

abstract class ListItem {
  Widget buildTitle(BuildContext context);
}

class ProfessorItem implements ListItem {
  final String firstName;
  final String lastName;
  final String email;
  final String cellNumber;

  ProfessorItem(this.firstName, this.lastName, this.email, this.cellNumber);

  @override
  Widget buildTitle(BuildContext context) {
    return Text("$firstName $lastName \n$email \n$cellNumber" ,
        style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 20)
    );
  }

  Widget buildItem(BuildContext context) {
    return SizedBox(
        width: 300,
        height: 100,
            child: Stack(children: [
              buildTitle(context),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 2)
                    )
                ),
              ),
            ])
    );
  } //
}