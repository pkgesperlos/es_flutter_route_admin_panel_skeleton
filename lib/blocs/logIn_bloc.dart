import 'dart:async';
import 'dart:convert';



import 'package:checklist_admin_panel/resources/api_provider.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';

import '../models/user_model.dart';
import '../resources/bloc_check.dart';
import '../resources/save.dart';


class LogInBloc<T> {
  final apiProvider = ApiProvider<T>();

  PublishSubject<T> _publishSubject = PublishSubject<T>();

  Stream<T> get actions => _publishSubject.stream;

  Future fetchLogin({
    required String apiAddress,
    required Map<String, String> body,
    Function(String)? directResult,
    Function(Response)? fullResponse,
  }) async {
    var model = await apiProvider.fetchDataPOST(apiAddress, body, (res) {

      if (BlocCheck.hasError(res) == "null") {

        if (directResult != null) directResult(res);
        return UserModel.fromJson(json.decode(res));
      } else {
        _publishSubject.addError(BlocCheck.hasError(res));
        return null;
      }
    }, fullResponse);

    if (model != null) {
      _publishSubject.add(model);
    }
    return model;
  }


  Future fetchAuthenticate({
    required String apiAddress,
    required Map<String, String> body,
    Function(String)? directResult,
    Function(Response)? fullResponse,
  }) async {
    var model = await apiProvider.fetchDataPOSTAuth(apiAddress, body, (res) {

      if (BlocCheck.hasError(res) == "null") {

        if (directResult != null) directResult(res);
        return UserModel.fromJson(json.decode(res));
      } else {
        _publishSubject.addError(BlocCheck.hasError(res));
        return null;
      }
    }, fullResponse);

    if (model != null) {
      _publishSubject.add(model);
    }
    return model;
  }





}

final logInBlocLogin = LogInBloc<UserModel>();
final logInBlocAuthenticate = LogInBloc<UserModel>();

