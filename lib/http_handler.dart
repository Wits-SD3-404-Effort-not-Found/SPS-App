import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sps_app/screens/authentication/login_manager.dart';

// handles all the http requests for the data transfer with the backend
class HTTPManager {
  HTTPManager();

  // posts user credentials to validate them
  static Future<bool> postLoginCredentials(
      String username, String password) async {
    var data = {'email': username, 'hashed_password': password};
    final response = await http.post(
      Uri.parse('http://164.92.183.156:80/authentication/credentials'),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      //throw Exception('Login Credentials incorrect');
      return Future.value(false);
    }
  }

  static Future<bool> postEmail(String username) async {
    var email = {'email': username};
    final response = await http.post(
      Uri.parse('http://164.92.183.156:80/authentication/security_questions'),
      body: jsonEncode(email),
    );

    if (response.statusCode == 200) {
      LoginManager.setAccountID(jsonDecode(response.body)['account_id']);
      var variable = jsonDecode(response.body)['questions'][0];
      LoginManager.trueQAs.add({
        'questionId': jsonDecode(variable['question_id']),
        'question':
            jsonDecode(jsonDecode(response.body)['questions'][0])['question'],
        'answer':
            jsonDecode(jsonDecode(response.body)['questions'][0])['answer']
      });
      LoginManager.trueQAs.add({
        'questionId': jsonDecode(
            jsonDecode(response.body)['questions'][1])['question_id'],
        'question':
            jsonDecode(jsonDecode(response.body)['questions'][1])['question'],
        'answer':
            jsonDecode(jsonDecode(response.body)['questions'][1])['answer']
      });
      //debugPrint(LoginManager.getTrueQAs());
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
      'questions': jsonEncode(answers)
    };
    final response = await http.post(
      Uri.parse('http://164.92.183.156:80/account/reset_password'),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      //throw Exception('Password unable to be reset');
      return Future.value(false);
    }
  }
}
