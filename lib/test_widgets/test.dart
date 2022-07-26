
import 'package:es_flutter_component/es_button/es_button.dart';
import 'package:flutter/material.dart';

import '../blocs/logIn_bloc.dart';
import '../widgets/es_button_streamer.dart';

class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {


  GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Form(
        key: form,
        child: Column(
          children: [
            TextFormField(
              validator: (String? value){
                if(value!.isEmpty){
                  return "خالی";
                }
                return null;
              },
            ),
            EsButtonStreamer(
              child: EsButton(
                text: "as",
                clickable: false,
              ),
              preload: EsButton(
                text: "as",
                clickable: false,
                isLoading: true,
              ),
              onPressed: (){

                logInBlocLogin.fetchLogin(
                    apiAddress: "login",
                    body: {
                      "username": "es",
                      "password": "123456"
                    }
                );
              },
              formKey: form,
              stream: logInBlocLogin.actions ,
            )
          ],
        ),
      )
    );
  }

  getData(){

  }

}

