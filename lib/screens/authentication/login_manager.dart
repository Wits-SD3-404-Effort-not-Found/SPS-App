import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:sps_app/http_handler.dart';

// class to manage the user account's details and processes, and access to the app.
class LoginManager {
  LoginManager();

  static String username = "";
  static String password = "";

  static void setUsername(String inputUsername) {
    username = inputUsername;
  }

  static void setPassword(String inputPassword) {
    password = inputPassword;
  }

  static String getUsername() {
    return username;
  }

  static String getPassword() {
    return _hashPassword().toString();
  }

  // to control access into the app by validating credentials with backend
  static Future<bool> validateLogin() async {
    bool status =
        await HTTPManager.postLoginCredentials(getUsername(), getPassword());
    return status;
  }

  //hash password for secure data transfer over the internet.
  static Digest _hashPassword() {
    var bytes = utf8.encode(password);
    return sha256.convert(bytes);
  }
}
