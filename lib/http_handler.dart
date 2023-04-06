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
      Uri.parse('http://164.92.183.156:80/authentication/forgot'),
      body: jsonEncode(email),
    );

    if (response.statusCode == 200) {
      LoginManager.setAccountID(jsonDecode(response.body)['account_id']);
      return Future.value(true);
    } else {
      //throw Exception('Invalid Email');
      return Future.value(false);
    }
  }

  static Future<bool> postOTP(String accountID, String otp) async {
    var data = {'account_id': accountID, 'otp': otp};
    final response = await http.post(
      Uri.parse('http://164.92.183.156:80/authentication/otp'),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      //throw Exception('OTP incorrect');
      return Future.value(false);
    }
  }

  static Future<bool> postNewPassword(
      String accountID, String email, String otp, String newPassword) async {
    var data = {
      'account_id': accountID,
      'email': email,
      'otp': otp,
      'new_password': newPassword
    };
    final response = await http.post(
      Uri.parse('http://164.92.183.156:80/account/password'),
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
