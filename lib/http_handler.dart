import 'package:http/http.dart' as http;
import 'dart:convert';

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
      throw Exception('Login Credentials incorrect');
    }
  }
}
