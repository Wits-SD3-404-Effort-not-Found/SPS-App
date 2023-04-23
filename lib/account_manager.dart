import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AccountManager {
  static int _accountId = 0;
  static String _sessionToken = "";
  static String _email = "";
  static String _username = "";
  static String _cellNumber = "";
  static Uint8List _profilePhotoBytes = Uint8List(0);

  static void saveAccount() {
    var box = Hive.box('account');
    box.put('account_id', _accountId);
    box.put('session_token', _sessionToken);
  }

  static void clearAccount() {
    _accountId = 0;
    _email = "";
    _username = "";
    _cellNumber = "";
    _profilePhotoBytes = Uint8List.fromList([]);

    var box = Hive.box('account');
    box.delete('account_id');
    box.delete('session_token');
  }

  static int getID() {
    return _accountId;
  }

  static String getSessionToken() {
    return _sessionToken;
  }

  static String getEmail() {
    return _email;
  }

  static String getUsername() {
    return _username;
  }

  static String getCellNumber() {
    return _cellNumber;
  }

  static Uint8List getPhoto() {
    return _profilePhotoBytes;
  }

  static void setID(int id) {
    _accountId = id;
  }

  static void setSessionToken(String sessionToken) {
    _sessionToken = sessionToken;
  }

  static void setEmail(String email) {
    _email = email;
  }

  static void setUsername(String username) {
    _username = username;
  }

  static void setCellNumber(String cellNumber) {
    _cellNumber = cellNumber;
  }

  static void setPhoto(String byteString) {
    _profilePhotoBytes =
        Uint8List.fromList(hex.decode(byteString.substring(2)));
  }
}
