//import 'dart:typed_data';
//import 'package:convert/convert.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sps_app/account_manager.dart';

void main() {
  // test for setID() and getID()
  test("test for getter and setter for accountID", () {
    AccountManager.setID(5);
    expect(AccountManager.getID(), 5);
  });

  test("test for getter and setter for sessionToken", () {
    AccountManager.setSessionToken("test session token");
    expect(AccountManager.getSessionToken(), "test session token");
  });

  test("test empty string for getter and setter for sessionToken", () {
    AccountManager.setSessionToken("");
    expect(AccountManager.getSessionToken(), "");
  });

  test("test for getter and setter for email", () {
    AccountManager.setEmail("test email");
    expect(AccountManager.getEmail(), "test email");
  });

  test("test empty string for getter and setter for email", () {
    AccountManager.setEmail("");
    expect(AccountManager.getEmail(), "");
  });

  test("test getter and setter for username", () {
    AccountManager.setUsername("test username");
    expect(AccountManager.getUsername(), "test username");
  });

  test("test empty string getter and setter for username", () {
    AccountManager.setUsername("");
    expect(AccountManager.getUsername(), "");
  });

  test("test getter and setter for cellNumber", () {
    AccountManager.setCellNumber("test cell number");
    expect(AccountManager.getCellNumber(), "test cell number");
  });

  test("test empty string getter and setter for cellNumber", () {
    AccountManager.setCellNumber("");
    expect(AccountManager.getCellNumber(), "");
  });

  /*
  test("test getter and setter for profilePhotoBytes", () {
    String testPhoto = "0xff917248";
    Uint8List testPhotoList =
        Uint8List.fromList(hex.decode(testPhoto.substring(2)));
    AccountManager.setPhoto(testPhoto);
    expect(AccountManager.getPhoto(), testPhotoList);
  });*/

}
