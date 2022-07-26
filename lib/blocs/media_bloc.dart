import 'dart:async';
import 'dart:convert';

import 'package:checklist_admin_panel/models/media_model.dart';
import 'package:checklist_admin_panel/resources/api_provider.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';

import '../resources/bloc_check.dart';


class MediaBloc<T> {




  final apiProvider = ApiProvider<T>();

  PublishSubject<T?> _publishSubject = PublishSubject<T?>();

  Stream<T?> get actions => _publishSubject.stream;


  Future fetchShow({
    required String apiAddress,
    required Map<String, String> body,
    Function(String)? directResult,
    Function(Response)? fullResponse,
  }) async {

    var model = await apiProvider.fetchDataPOSTAuth(apiAddress, body, (res) {

      if (BlocCheck.hasError(res) == "null") {

        if (directResult != null) directResult(res);
        return MediaPaginateModel.fromJson(json.decode(res));
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




  Future fetchStore({
    required String apiAddress,
    required Map<String, String> body,
    Function(String)? directResult,
    Function(Response)? fullResponse,
  }) async {

    var model = await apiProvider.fetchDataPOSTAuth(apiAddress, body, (res) {

      if (BlocCheck.hasError(res) == "null") {

        if (directResult != null) directResult(res);
        return res.toString();
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


  Future fetchDelete({
    required String apiAddress,
    required Map<String, String> body,
    Function(String)? directResult,
    Function(Response)? fullResponse,
  }) async {

    var model = await apiProvider.fetchDataPOSTAuth(apiAddress, body, (res) {

      if (BlocCheck.hasError(res) == "null") {

        if (directResult != null) directResult(res);
        return res.toString();
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

final mediaBlocShow = MediaBloc<MediaPaginateModel>();
final mediaBlocStore = MediaBloc<MediaPaginateModel>();
final mediaBlocDelete = MediaBloc<dynamic>();

