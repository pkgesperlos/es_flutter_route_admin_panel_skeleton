import 'dart:convert';

import '../constants/enums.dart';

/// this class use for check the response of server.
/// if status 200 and error not null then return data
/// else return String "nok"
class StatusChecker {
  String _date = "";
  String _errors = "";
  int _status = 0;

  StatusChecker(parsedJson) {

    if(parsedJson['data'] != null){
      if (parsedJson['data'] is String) {
        this._date = parsedJson['data'].toString();
      } else {
        this._date = json.encode(parsedJson['data']).toString();
      }
      this._errors = parsedJson['errors'];
      this._status = parsedJson['status'];
    }else{

    }


  }

  String getData() {
    if (_status == 200 && _errors == null) {
      return _date;
    } else {
      // OverlyAlert.show("لطفا شهر خود را انتخاب نمایید", context, duration:  OverlyAlert.LENGTH_LONG, gravity: OverlyAlert.BOTTOM,backgroundColor: Colors.red,textColor: Colors.white);

      return "";
    }
  }

  bool isOK() {
    if (_status == 200 && _errors == null) {
      return true;
    } else {
      return false;
    }
  }
}



String getError(RequestError error){

  switch(error){
    case RequestError.timeOut:
      return "timeOut";
    case RequestError.noNet:
      return "noNet";
    case RequestError.wrongApiToken:
      return "wrongApiToken";
    case RequestError.unauthorized:
      return "unauthorized";
    case RequestError.unknown:
      return "unknown";
    default:
      return "unknown";

  }

}