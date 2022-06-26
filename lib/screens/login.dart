import 'dart:convert';

import 'package:es_flutter_component/es_form/es_checkbox.dart';
import 'package:es_flutter_component/es_form/es_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart';
import 'package:validators/validators.dart';

import '../blocs/logIn_bloc.dart';
import '../images/panelConstants.dart';
import '../resources/save.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _ctrlUsername = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // print(AppLocalizations.of(context)?.localeName=='en');
    return Directionality(textDirection: TextDirection.ltr, child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.maxFinite,
          alignment: Alignment.center,
          child: BootstrapContainer(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
            children: [
              BootstrapCol(
                  sizes: 'col-sm-12 col-md-12 col-lg-6 col-xl-6',
                  offsets: "offset-sm-0 offset-md-0 offset-lg-3 offset-xl-3",
                  child: Directionality(textDirection: TextDirection.rtl,child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: PanelConstants.paddingDimension,
                      vertical: PanelConstants.paddingDimension,
                    ),
                    margin: EdgeInsets.all(PanelConstants.paddingDimension),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(PanelConstants.paddingDimension * 2)),
                        color: PanelConstants.forGround),
                    child: Container(
                        padding: EdgeInsets.only(top: 50, right: 15,left: 15),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: <Widget>[
                              EsTextField(
                                controller: _ctrlUsername,
                                type: "نام کاربری",
                                hint: "نام کاربری خود را وارد کنید",
                                validator: (text) {
                                  if (text.toString().length < 4) {
                                    return "It is too short";
                                  }
                                  else if (!isEmail(text)) {
                                    return "It is not Email";
                                  }

                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              EsTextField(
                                controller: _ctrlPassword,
                                type: "رمز عبور",
                                hint: "رمز عبور خود را وارد کنید",
                                validator: (text) {
                                  if (text.toString().length < 4) {
                                    return "It is too short";
                                  }
                                },
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              EsCheckBox(
                                title: Text("مرا به خاطر بسپار"),
                                validator: (value) {
                                  if (!value!) {
                                    return "It is neccessary!";
                                  }
                                },
                                onSaved: (bool? newValue) {},
                              ),

                              ElevatedButton(
                                child: Text(AppLocalizations.of(context)!.login),
                                // child: Text(Translations.of(context).text("login")),
                                onPressed: () {
                                  sendRequest();
                                },
                              )
                            ],
                          ),
                        )),
                  ),))
            ],
          ),
        )));
  }

  void sendRequest() {

    //#
    logInBlocLogin.fetchLogin(
        apiAddress: "login",
        body: {
          "username": _ctrlUsername.text,
          "password": _ctrlPassword.text
        },
        fullResponse: (Response res) {
          if(res.statusCode == 200){
            Save().setUserData(res.body);
            Save().setAuth(json.decode(res.body)['api_token'].toString());
            Save().setLogin(true);
            Navigator.pushReplacementNamed(context, '/dashboard');
          }
        });



  }


}
