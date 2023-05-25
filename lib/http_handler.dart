import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sps_app/screens/authentication/login_manager.dart';
import 'package:sps_app/account_manager.dart';
import 'package:sps_app/screens/notes/note_content.dart';
import 'package:sps_app/screens/calendar/calendar_manager.dart';

// handles all the http requests for the data transfer with the backend
class HTTPManager {
  HTTPManager();

  static const String serverAddress = '164.92.183.156';
  static const String serverPort = '80';

  // posts user credentials to validate them
  // Returns true if its a newly created account
  static Future<bool> postLoginCredentials(
      String username, String password) async {
    var data = {'email': username, 'hashed_password': password};
    var uri = 'http://$serverAddress:$serverPort/authentication/credentials';
    final response = await http.post(
      Uri.parse(uri),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      var mapAuthResponse = jsonDecode(response.body);
      AccountManager.setID(mapAuthResponse['account_id']);
      AccountManager.setSessionToken(mapAuthResponse['session_token']);
      return Future.value(mapAuthResponse['new_account']);
    } else {
      var responseCode = response.statusCode;
      var responseMessage = response.body;
      throw Exception(
          'Failed Authentication with code $responseCode and message $responseMessage');
    }
  }

  static Future<bool> postEmail(String username) async {
    var email = {'email': username};
    final response = await http.post(
      Uri.parse(
          'http://$serverAddress:$serverPort/authentication/security_questions'),
      body: jsonEncode(email),
    );

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      LoginManager.setAccountID(responseMap['account_id']);
      for (var questionMap in responseMap['questions']) {
        LoginManager.addQuestion(questionMap);
      }
      return Future.value(true);
    } else {
      //throw Exception('Invalid Email');
      return Future.value(false);
    }
  }

  static Future<bool> postNewPassword(
      int accountID, String newPassword, List<Map> answers) async {
    var data = {
      'account_id': accountID,
      'new_password': newPassword,
      'questions': answers
    };
    final response = await http.post(
      Uri.parse('http://$serverAddress:$serverPort/account/reset_password'),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      //throw Exception('Password unable to be reset');
      return Future.value(false);
    }
  }

  static Future<List<Events>> getAllEventsData(int accountID) async {
    final List<Events> eventsList = [];
    //might need to fix up
    var events = await http
        .get(Uri.parse('http://$serverAddress:$serverPort/events/$accountID'));
    var rotations = await http.get(
        Uri.parse('http://$serverAddress:$serverPort/rotations/$accountID'));
    if (events.statusCode == 200) {
      var jsonData = json.decode(events.body);

      for (var data in jsonData) {
        Events eventData = Events(
            eventId: data['event_id'], // check this actually gets the ID
            startDate: convertDateFromString(data['start_date']),
            endDate: convertDateFromString(data['end_date']),
            eventName: data['name'],
            description: data['description'],
            background: const Color(0xFF8B1FA9));
        eventsList.add(eventData);
      }
    }

    if (rotations.statusCode == 200) {
      var jsonRotationsData = json.decode(rotations.body);

      for (var data in jsonRotationsData) {
        Rotations rotationsData = Rotations(
            eventId: data['event_id'],
            rotationId: data['rotation_id'],
            startDate: convertDateFromString(data['start_date']),
            endDate: convertDateFromString(data['end_date']),
            eventName: data['event_name'],
            description: data['description'],
            hospital: data['hospital_name'],
            discipline: data['discipline_name'],
            background: const Color.fromARGB(255, 61, 31, 169));
        eventsList.add(rotationsData);
      }
    } else {
      throw Exception("Can't retrieve user events");
    }

    return eventsList;
  }

  //http delete function to delete an event form the database
  static Future<bool> deleteEvent(int eventID) async {
    final response = await http
        .delete(Uri.parse('http://$serverAddress:$serverPort/events/$eventID'));
    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      throw Exception("Failed to delete event");
    }
  }

  // http get function to get the list of notes from database
  static Future<List<Map>> getNotes() async {
    int accountID = AccountManager.getID();
    final response = await http
        .get(Uri.parse("http://$serverAddress:$serverPort/notes/$accountID"));
    var notesList = [{}];
    debugPrint(response.reasonPhrase);
    if (response.statusCode == 200) {
      var responseVec = jsonDecode(response.body);
      debugPrint(responseVec.toString());
      for (var note in responseVec) {
        notesList.add({
          "noteID": note["note_id"],
          "noteTitle": note["note_title"],
          "noteContent": note["note_content"],
          "publicNote": note["note_public"],
        });
      }
      return notesList;
    } else {
      throw Exception("Can't retrieve notes");
    }
  }

  // http put function to put edited note in the database
  static Future<bool> putUpdatedNote(NoteContent note) async {
    debugPrint("value from in update http function");
    debugPrint(note.getIsPublicNote().toString());
    var noteData = {
      "note_id": note.getNoteID(),
      "note_title": note.getTitle(),
      "note_content": note.getBody(),
      "note_public": note.getIsPublicNote(),
    };
    final response = await http.put(
        Uri.parse("http://$serverAddress:$serverPort/notes/"),
        body: jsonEncode(noteData));

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      throw Exception("Failed to update note");
      //return Future.value(false);
    }
  }

  static Future<bool> deleteNote(NoteContent note) async {
    var noteID = note.getNoteID();
    final response = await http
        .delete(Uri.parse("http://$serverAddress:$serverPort/notes/$noteID"));
    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      throw Exception("Failed to delete note");
      //return Future.value(false);
    }
  }

  static Future<List<Map>> getProtocols() async {
    final response = await http.get(
      Uri.parse('http://$serverAddress:$serverPort/notes/protocols'),
    );
    var protocolsList = [{}];
    if (response.statusCode == 200) {
      var responseVec = jsonDecode(response.body);
      debugPrint(response.body);
      for (var protocol in responseVec) {
        protocolsList.add({
          "protocolID": protocol["protocol_id"],
          "protocolTitle": protocol["title"],
          "protocolContent": protocol["content"]
        });
      }
      return protocolsList;
    } else {
      throw Exception("Can't access data");
    }
  }

  static Future<bool> postNewNote(NoteContent note) async {
    int accountID = AccountManager.getID();
    var noteData = {
      "account_id": accountID,
      "note_title": note.getTitle(),
      "note_content": note.getBody(),
      "note_public": note.getIsPublicNote(),
    };
    final response = await http.post(
        Uri.parse("http://$serverAddress:$serverPort/notes/"),
        body: jsonEncode(noteData));

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      throw Exception("Failed to post new note");
      //return Future.value(false);
    }
  }

  static Future<void> authSessionToken(
      String sessionToken, int accountID) async {
    final response = await http.post(
        Uri.parse('http://$serverAddress:$serverPort/authentication/session'),
        body: jsonEncode(
            {'account_id': accountID, 'session_token': sessionToken}));

    if (response.statusCode != 200) {
      var code = response.statusCode;
      var message = response.body;
      throw Exception('Session Token Auth Failure $code : $message');
    } else {
      return;
    }
  }

  static Future<void> removeSessionToken(int accountID) async {
    final response = await http.delete(
      Uri.parse(
          'http://$serverAddress:$serverPort/authentication/session/$accountID'),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      var code = response.statusCode;
      var message = response.body;
      throw Exception('Session Token failed to be removed $code : $message');
    }
  }

  static Future<bool> postNewEvent(Events event) async {
    int accountID = AccountManager.getID();
    var eventData = {
      "account_id": accountID,
      "start_date": event.startDate.toString(),
      "end_date": event.endDate.toString(),
      "event_name": event.eventName.toString(),
      "description": event.description.toString()
    };
    final response = await http.post(
        Uri.parse("http://$serverAddress:$serverPort/events/"),
        body: jsonEncode(eventData));

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      throw Exception("Failed to post new event");
      //return Future.value(false);
    }
  }

  static Future<List> getAccountSettings() async {
    int accountID = AccountManager.getID();
    final response = await http
        .get(Uri.parse("http://$serverAddress:$serverPort/account/$accountID"));
    if (response.statusCode == 200) {
      var details = [];
      var accountData = jsonDecode(response.body);
      debugPrint(response.body);
      details.addAll({
        accountData["username"],
        accountData["cell_number"],
        //accountData["profile_photo"],
      });
      debugPrint(details.toString());
      return details;
    } else {
      throw Exception("Can't access data");
    }
  }

  static Future<bool> putUpdatedAccountSettings() async {
    var accountData = {
      "account_id": AccountManager.getID(),
      "username": AccountManager.getUsername(),
      "cell_number": AccountManager.getCellNumber(),
      "profile_photo": [0]
    };
    final response = await http.put(
        Uri.parse("http://$serverAddress:$serverPort/account/"),
        body: jsonEncode(accountData));
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      throw Exception("Failed to update account settings");
    }
  }

  static Future<bool> putEditedEvent(Events event) async {
    var eventData = {
      "start_date": event.startDate.toString(),
      "end_date": event.endDate.toString(),
      "event_name": event.eventName.toString(),
      "description": event.description.toString(),
      "event_id": event.eventId,
    };
    final response = await http.put(
        Uri.parse("http://$serverAddress:$serverPort/events/"),
        body: jsonEncode(eventData));
    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      throw Exception("Failed to edit event");
      //return Future.value(false);
    }
  }

  //gets all the details off the staff/professors for students to contact from the backend
  static Future<List<Map>> getProfessors() async {
    final response = await http.get(
      Uri.parse('http://$serverAddress:$serverPort/staff'),
    );
    var professorsList = [{}];
    if (response.statusCode == 200) {
      var responseVec = jsonDecode(response.body);
      debugPrint(response.body);
      for (var professor in responseVec) {
        professorsList.add({
          "staffID": professor["staff_id"],
          "firstName": professor["first_name"],
          "lastName": professor["last_name"],
          "email": professor["email"],
          "cellNumber": professor["cell_number"]
        });
      }
      return professorsList;
    } else {
      throw Exception("Can't access data");
    }
  }
}
