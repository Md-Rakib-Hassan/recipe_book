import 'package:flutter/cupertino.dart';
import 'package:recipe_book/models/user.dart';
import 'package:recipe_book/services/http_service.dart';

class AuthService{

  final _httpService= HTTPService();

  User? user;

  static final AuthService _singleton= AuthService._internal();

  factory AuthService(){
    return _singleton;
  }
  AuthService._internal();

  Future<bool> login (String username, String password) async {
    try{
      var response= await _httpService.post("auth/login", {
        "username":username,
        "password":password,
      });
      if(response?.statusCode==200 && response?.data != null){
        user= User.fromJson(response!.data);
        HTTPService().setup(bearerToken: user!.token);
        return true;

      }

    }
    catch(e){
      print(e);
    }
    return false;
  }
}