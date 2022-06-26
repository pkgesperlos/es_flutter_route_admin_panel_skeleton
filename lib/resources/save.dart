
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

import 'dart:convert';

import '../models/user_model.dart';


///shared preferences based class and use for save data
class Save<T> {
  setter() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  getter() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  setLogin(bool value) async {
    var sharedPreferences = await setter();
    sharedPreferences.setBool("login", value);
  }

  Future<bool> isLogin() async {
    var sharedPreferences = await getter();
    return sharedPreferences.getBool("login") ?? false;
  }


  setUserData(String value) async {
    var sharedPreferences = await setter();
    sharedPreferences.setString("userData", value);
  }

  Future<UserModel> getUserData() async {
    var sharedPreferences = await getter();

    Map userMap = jsonDecode(sharedPreferences.getString('userData'));

    return UserModel.fromJson(userMap);
  }


  Future<Null> setAuth(String value) async {
    var sharedPreferences = await setter();

    sharedPreferences.setString("auth", value);
  }

  Future<String> getAuth() async {
    var sharedPreferences = await getter();
    return sharedPreferences.getString("auth");
  }


}
