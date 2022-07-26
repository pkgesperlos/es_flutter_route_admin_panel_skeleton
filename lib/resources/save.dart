
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

import 'dart:convert';

import '../models/category_model.dart';
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

    Map map = jsonDecode(sharedPreferences.getString('userData'));

    return UserModel.fromJson(map);
  }


  Future<Null> setAuth(String value) async {
    var sharedPreferences = await setter();

    sharedPreferences.setString("auth", value);
  }

  Future<String> getAuth() async {
    var sharedPreferences = await getter();
    return sharedPreferences.getString("auth");
  }




  setChecklistCategory(String value) async {
    var sharedPreferences = await setter();

    sharedPreferences.setString("checklistCategory", value);
  }

  Future<CategoryModelList> getChecklistCategory() async {
    var sharedPreferences = await getter();
    List map = jsonDecode(sharedPreferences.getString('checklistCategory'));

    return CategoryModelList.fromJson(map);
  }


}
