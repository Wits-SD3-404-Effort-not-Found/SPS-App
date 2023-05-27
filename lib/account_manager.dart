import 'dart:typed_data';
//import 'package:convert/convert.dart';
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
    box.put('email', _email);
    box.put('username', _username);
    box.put('cell_numer', _cellNumber);
    box.put('profile_photo_bytes', _profilePhotoBytes);
    box.close();
  }

  static void clearAccount() {
    _accountId = 0;
    _sessionToken = "";
    _email = "";
    _username = "";
    _cellNumber = "";
    _profilePhotoBytes = Uint8List(0);

    var box = Hive.box('account');
    box.deleteAll([
      'account_id',
      'session_token',
      'email',
      'username',
      'cell_number',
      'profile_photo_bytes'
    ]);
    box.close();
  }

  static void loadAccount() {
    var box = Hive.box('account');
    _accountId = box.get('account_id', defaultValue: 0);
    _sessionToken = box.get('session_token', defaultValue: "");
    _email = box.get('email', defaultValue: "");
    _username = box.get('username', defaultValue: "");
    _cellNumber = box.get('cell_number', defaultValue: "");
    _profilePhotoBytes =
        box.get('profile_photo_bytes', defaultValue: Uint8List(0));
    box.close();
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

  static void setPhoto(List<dynamic> bytes) {
    _profilePhotoBytes = Uint8List.fromList(bytes.cast<int>());
    //_profilePhotoBytes = Uint8List.fromList(List<int>.filled(256 * 256 * 4, 255));
  }
}
