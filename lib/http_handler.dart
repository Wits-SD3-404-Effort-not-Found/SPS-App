import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sps_app/screens/authentication/login_manager.dart';
import 'package:sps_app/screens/notes/note_content.dart';

// handles all the http requests for the data transfer with the backend
class HTTPManager {
  HTTPManager();

  static const String serverAddress = '164.92.183.156';
  static const String serverPort = '80';

  // posts user credentials to validate them
  static Future<bool> postLoginCredentials(
      String username, String password) async {
    var data = {'email': username, 'hashed_password': password};
    final response = await http.post(
      Uri.parse('http://$serverAddress:$serverPort/authentication/credentials'),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      LoginManager.setAccountID(responseMap['account_id']);
      return Future.value(true);
    } else {
      //throw Exception('Login Credentials incorrect');
      return Future.value(false);
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

  // http get function to get the list of notes from database
  static Future<List<Map>> getNotes() async {
    int accountID = LoginManager.getAccountID();
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
        });
      }
      return notesList;
    } else {
      throw Exception("Can't retrieve notes");
    }
  }

  // http put function to put edited note in the database
  static Future<bool> putUpdatedNote(NoteContent note) async {
    var noteData = {
      "note_id": note.getNoteID(),
      "note_title": note.getTitle(),
      "note_content": note.getBody()
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
    int accountID = LoginManager.getAccountID();
    var noteData = {
      "account_id": accountID,
      "note_title": note.getTitle(),
      "note_content": note.getBody()
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
}
