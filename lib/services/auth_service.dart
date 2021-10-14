import 'dart:convert';

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response_model.dart';
import 'package:chat_app/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AuthService with ChangeNotifier{

  late Usuario usuario;

  Future login (String email, String password)async{

    final data = {
      'email' : email,
      'password' : password
    };

    final resp = await http.post(Uri.parse('${Environment.apiUrl}/login'),
      body: jsonEncode(data),
      headers: {
        'Content-Type' : 'application/json'
      }
    );
    print(resp.statusCode);
    if(resp.statusCode == 200){
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      print(resp.body);
    }
  }

}