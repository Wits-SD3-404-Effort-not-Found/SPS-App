import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:sps_app/http_handler.dart';

// class to manage the user account's details and processes, and access to the app.
class LoginManager {
  LoginManager();

  static String username = "";
  static String password = "";
  static String _accountId = "";
  static String _otp = "";


  static void setUsername(String inputUsername) {
    username = inputUsername;
  }

  static void setPassword(String inputPassword) {
    password = inputPassword;
  }

  static void setAccountID(String givenAccountId){
    _accountId = givenAccountId;
  }

  static String getAccountID(){
    return _accountId;
  }

  static String getUsername() {
    return username;
  }

  static String getPassword() {
    return _hashPassword().toString();
  }

  static void setOTP(String otp){
    _otp = otp;
  }

  static bool changePassword(String newPassword){
    bool status = true;
    password = newPassword;
    HTTPManager.postNewPassword(_accountId, getUsername(), _otp, getPassword()).then((value)=>{
      if (value == true){
        status = true
      }else{
        status =  false
    }
    });
    return status;
  }


  // to control access into the app by validating credentials with backend
  static Future<bool> validateLogin() async {
    bool valid =
        await HTTPManager.postLoginCredentials(getUsername(), getPassword());
    return valid;
  }

  // to validate the email, to control weather OTP will be sent
  static bool validateEmail(){
    bool valid = true;
    HTTPManager.postEmail(getUsername()).then((value)=>{
      if (value == true){
        valid = true
      }else{
        valid =  false
      }
    });
    return valid;
  }

  static Future<bool> validateOTP() async{
    bool valid =
      await HTTPManager.postOTP(getAccountID(), _otp);
    return valid;
  }

  //hash password for secure data transfer over the internet.
  static Digest _hashPassword() {
    var bytes = utf8.encode(password);
    return sha256.convert(bytes);
  }
}
