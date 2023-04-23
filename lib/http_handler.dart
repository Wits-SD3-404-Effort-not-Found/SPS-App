import 'dart:ui';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sps_app/screens/authentication/login_manager.dart';
import 'package:sps_app/screens/calendar/calendar_manager.dart';

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

  static Future<List<Events>> getAllEventsData() async {
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
            event_id: data['event_id'], // check this actually gets the ID
            startDate: convertDateFromString(data['start_date']),
            endDate: convertDateFromString(data['end_date']),
            eventName: data['name'],
            description: data['description'],
            background: const Color(0xFF8B1FA9));
        eventsList.add(eventData);
      }
      return eventsList;
    }

    if (rotations.statusCode == 200) {
      var jsonRotationsData = json.decode(rotations.body);

      for (var data in jsonRotationsData) {
        Rotations eventData = Rotations(
            eventId: data['event_id'],
            rotation_id: data['rotation_id'],
            startDate: convertDateFromString(data['start_date']),
            endDate: convertDateFromString(data['end_date']),
            eventName: data['event_name'],
            description: data['description'],
            hospital: data['hospital_name'],
            discipline: data['discipline_name'],
            background: const Color(0xFF8B1FA9));
        eventsList.add(eventData);
      }
      return eventsList;
    } else {
      throw Exception("Can't retrieve user events");
    }
  }
}
