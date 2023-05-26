import 'package:flutter/material.dart';

class PublicNoteMenuItemController {
  bool? value;
}

class PublicNoteMenuItem extends StatefulWidget {
  //final String protocolTitle;
  //final String body;
  final PublicNoteMenuItemController controller;
  const PublicNoteMenuItem({super.key, required this.controller});

  @override
  State<StatefulWidget> createState() => _PublicNoteMenuItemState();
}

class _PublicNoteMenuItemState extends State<PublicNoteMenuItem> {
  bool _publicNote = false;
  @override
  void initState() {
    super.initState();
    _publicNote = widget.controller.value!;
  }

  void onChanged(bool? value) {
    setState(
      () {
        _publicNote = !_publicNote;
        widget.controller.value = _publicNote;
        // widget.noteContent
        //    .setIsPublicNote(publicNote!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        "Public Note",
        style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground, fontSize: 17),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          child: Checkbox(
              value: _publicNote,
              onChanged: onChanged,
              checkColor: Theme.of(context).colorScheme.onBackground,
              side: BorderSide(
                  color: Theme.of(context).colorScheme.onBackground))),
      IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  title: Text(
                    "Make Note Public",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  content: Text(
                    "Making this note public will allow your supervisors to see your note. Your note will still be private to fellow students.",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                );
              });
        },
        icon: Icon(
          Icons.info_outline_rounded,
          size: 25,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      )
    ]);
  }
}
