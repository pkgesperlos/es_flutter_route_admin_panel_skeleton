import 'package:es_flutter_component/es_form/es_checkbox.dart';
import 'package:es_flutter_component/es_form/es_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:validators/validators.dart';

import 'images/panelConstants.dart';

class EsLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EsLogin();
  }
}

class _EsLogin extends State<EsLogin> {
  final _formkey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    // print(AppLocalizations.of(context)?.localeName=='en');
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: EdgeInsets.only(top: 50, right: 15,left: 15),
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.black54,
                    )),
                Form(
                  key: _formkey,
                  child: _boxShow(Column(
                    children: <Widget>[
                      EsTextField(
                        type: AppLocalizations.of(context)!.username,
                        hint: AppLocalizations.of(context)!.usernamehint,
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
                        type: AppLocalizations.of(context)!.password,
                        hint: AppLocalizations.of(context)!.passwordhint,
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
                        title: Text("با قوانین و مقررات سایت موافقم."),
                        validator: (value) {
                          if (!value!) {
                            return "It is neccessary!";
                          }
                        },
                        onSaved: (bool? newValue) {},
                      ),
                    ],
                  )),
                ),
                RaisedButton(
                  textColor: Colors.white,
                  color: Colors.green,
                  child: Text(AppLocalizations.of(context)!.login),
                  // child: Text(Translations.of(context).text("login")),
                  onPressed: () {
                    // if(_formkey.currentState?.validate()==true)
                    {Navigator.pushNamed(context, '/tree');}
                  },
                )
              ],
            )));
  }
  Widget _boxShow(Widget widget) {
    return BootstrapCol(
        sizes: 'col-sm-12 col-ml-12 col-lg-6 col-xl-6',
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: PanelConstants.paddingDimension,
            vertical: PanelConstants.paddingDimension,
          ),
          margin: EdgeInsets.all(PanelConstants.paddingDimension),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(PanelConstants.paddingDimension * 2)),
              color: PanelConstants.forGround),
          child: widget,
        ));
  }

}
