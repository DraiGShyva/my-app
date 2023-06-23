import 'dart:convert';
import 'package:http/http.dart' as http;

class Authen {
  static var account = {};

  //TODO
  //  account will be the following form:
  //  Map<String, Map<String, dynamic>> account={
  //  'key1':{
  //    'username':'user1',
  //    'email':'email1',
  //    'password':'password1'
  //  },
  //  'key2':{
  //    'username':'user2',
  //    'email':'email2',
  //    'password':'password2'
  //  },
  //  ...
  // }

  static final url = Uri.https(
      'flutter-304c5-default-rtdb.firebaseio.com', 'account_data.json');

  static Future<void> createAccount(account) async {
    await http.post(
      url,
      body: json.encode(account),
    );
  }

  static Future<void> getAccount() async {
    account = json.decode((await http.get(url)).body);
  }

  static Future<void> updateAccount() async {
    await http.patch(
      url,
      body: json.encode(account),
    );
  }
}
