import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyA1b2GHPllPLBSTNwoKscZ1xH2BSU47iyg';

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(
        _baseUrl,
        '/v1/accounts:signUp', //Puede ser que no sea signUp
        {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      //Token hay que guardarlo en un lugar seguro
      // decodedResp['idToken'];
      return null;
    } else {
      return decodeResp['error']['message'];
    }
  }
}
