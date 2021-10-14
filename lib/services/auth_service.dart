import 'dart:convert';

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response_model.dart';
import 'package:chat_app/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


class AuthService with ChangeNotifier{

  late Usuario usuario;
  bool _autenticando = false;

  final _storage = FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando (bool valor){
    this._autenticando = valor;
    notifyListeners();
  }

  //Getters del token
  static Future<String> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token!;
  }

  static Future<void> deleteToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login (String email, String password)async{

    this.autenticando = true;

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

      await this._guardarToken(loginResponse.token);

      print(resp.body);

      this.autenticando = false;
      return true;
    }else{
      this.autenticando = false;
      return false;
    }
    
  }

  Future register (String name, String email, String password)async{

    this.autenticando = true;

    final data = {
      'nombre': name,
      'email' : email,
      'password' : password
    };

    final resp = await http.post(Uri.parse('${Environment.apiUrl}/login/new'),
      body: jsonEncode(data),
      headers: {
        'Content-Type' : 'application/json'
      }
    );

    print(resp.body);

    if(resp.statusCode == 200){
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);

      print(resp.body);

      this.autenticando = false;
      return true;
    }else{
      final respBody = jsonDecode(resp.body);
      this.autenticando = false;
      return respBody['msg'];
    }

  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout ()async{
    await _storage.delete(key: 'token');
  }

}