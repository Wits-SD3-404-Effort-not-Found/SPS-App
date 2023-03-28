import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:sps_app/http_handler.dart';

class LoginManager {
  LoginManager();

  static String username = "";
  static String password = "";

  static void setUsername(String inputUsername){
    username=inputUsername;
  }

  static void setPassword(String inputPassword){
    password=inputPassword;
  }

  static String getUsername(){
    return username;
  }

  static String getPassword(){
    return _hashPassword().toString();
  }

  static Future<bool> validateLogin() async{
    bool status = await HTTPManager.postLoginCredentials(getUsername(), getPassword());
    return status;
  }


  static Digest _hashPassword() {
    var bytes = utf8.encode(password);
    return sha256.convert(bytes);
  }
}
