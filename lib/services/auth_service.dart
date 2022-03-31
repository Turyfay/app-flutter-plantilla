import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String firebaseToken = 'AIzaSyBSHHVNK5V7xmFVEEkE83qaMQFK9wG2_js';

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': firebaseToken,
    });

    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResponse = json.decode(response.body);
    if (decodedResponse.containsKey('idToken')) {
      return null;
    } else {
      return decodedResponse['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key': firebaseToken,
    });

    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResponse = json.decode(response.body);
    if (decodedResponse.containsKey('idToken')) {
      return null;
    } else {
      return decodedResponse['error']['message'];
    }
  }
}