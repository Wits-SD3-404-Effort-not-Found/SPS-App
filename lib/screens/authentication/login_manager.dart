import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:sps_app/http_handler.dart';

// class to manage the user account's details and processes, and access to the app.
class LoginManager {
  LoginManager();

  static String username = "";
  static String password = "";
  static int _accountId = 0;
  static final List<Map> _trueQAs = [];
  static final List<Map> userAnswers = [];

  static int getAccountID() {
    return _accountId;
  }

  static void setUsername(String inputUsername) {
    username = inputUsername;
  }

  static String getUsername() {
    return username;
  }

  static void setPassword(String inputPassword) {
    password = inputPassword;
  }

  static String getPassword() {
    return _hashData(password).toString();
  }

  static void setAccountID(int givenAccountId) {
    _accountId = givenAccountId;
  }

  static void clearQuestions() {
    _trueQAs.clear();
  }

  static void addQuestion(Map<String, dynamic> question) {
    _trueQAs.add(question);
  }

  static List<String> getQuestions() {
    List<String> questions = [];
    questions.add(_trueQAs[0]['question']!);
    questions.add(_trueQAs[1]['question']!);
    return questions;
  }

  static setAnswers(String answer1, String answer2) {
    String answer1Hashed = _hashData(answer1.toLowerCase()).toString();
    String answer2Hashed = _hashData(answer2.toLowerCase()).toString();
    userAnswers.add({
      "question_id": _trueQAs[0]['question_id'],
      "user_answer": answer1Hashed
    });
    userAnswers.add({
      "question_id": _trueQAs[1]['question_id'],
      "user_answer": answer2Hashed
    });
  }

  static getQuestion(int questionIndex) {
    return _trueQAs[questionIndex];
  }

  static Future<bool> changePassword(String newPassword) async {
    password = newPassword;
    bool status = await HTTPManager.postNewPassword(
        _accountId, getPassword(), userAnswers);
    return status;
  }

  // to control access into the app by validating credentials with backend
  static Future<bool> validateLogin() async {
    bool valid =
        await HTTPManager.postLoginCredentials(getUsername(), getPassword());
    return valid;
  }

  // to validate the email, to control weather OTP will be sent
  static Future<bool> validateEmail() async {
    bool valid = await HTTPManager.postEmail(getUsername());
    return valid;
  }

  //hash password for secure data transfer over the internet.
  static Digest _hashData(String data) {
    var bytes = utf8.encode(data);
    return sha256.convert(bytes);
  }
}
