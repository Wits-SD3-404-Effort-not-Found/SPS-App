import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sps_app/screens/authentication/login_manager.dart';

void main() {
  test("test for getter and setter for accountID", () {
    LoginManager.setAccountID(5);
    expect(LoginManager.getAccountID(), 5);
  });

  test("test for getter and setter for username", () {
    LoginManager.setUsername("test username");
    expect(LoginManager.getUsername(), "test username");
  });

  test("test empty string for getter and setter for username", () {
    LoginManager.setUsername("");
    expect(LoginManager.getUsername(), "");
  });

  test("test getter and setter for password", () {
    LoginManager.setPassword("test password");
    String hashedPassword =
        sha256.convert(utf8.encode("test password")).toString();
    expect(LoginManager.getPassword(), hashedPassword);
  });

  test("test add and get trueQAs", () {
    LoginManager.addQuestion(
        {"question": "What was the name of your first pet?"});
    LoginManager.addQuestion({"question": "question 2"});
    List<String> testQuestions = [
      "What was the name of your first pet?",
      "question 2"
    ];
    expect(LoginManager.getQuestion(0),
        {"question": "What was the name of your first pet?"});
    expect(LoginManager.getQuestions(), testQuestions);
  });

  test("test clear questions", () {
    LoginManager.addQuestion(
        {"question": "What was the name of your first pet?"});
    LoginManager.addQuestion({"question": "question 2"});
    LoginManager.clearQuestions();
    expect(LoginManager.getQuestions(), []);
  });
}
