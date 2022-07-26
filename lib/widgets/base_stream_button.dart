import 'package:checklist_admin_panel/constants/enums.dart';
import 'package:checklist_admin_panel/resources/status_checker.dart';
import 'package:es_flutter_component/es_alert/es_alerts.dart';
import 'package:es_flutter_component/es_button/es_button.dart';
import 'package:es_flutter_component/es_text/es_ordinary_text.dart';
import 'package:es_flutter_component/es_text/es_title.dart';
import 'package:es_flutter_component/resources/Constants/dims.dart';
import 'package:flutter/material.dart';

class BaseStreamButton extends StatefulWidget {

  bool shouldPop;
  Function onPressed;
  GlobalKey<FormState>? formKey;
  Function(AsyncSnapshot snapshot)? afterFinish;
  Stream stream;
  Widget child;
  Widget preload;
  bool useConfidence;

  BaseStreamButton(
      {required this.stream,
        this.formKey,
        this.shouldPop = false,
        required this.onPressed,
        required this.child,
        required this.preload,
        this.useConfidence = false,
        this.afterFinish});

  @override
  State<StatefulWidget> createState() {
    return BaseStreamButtonState();
  }
}

class BaseStreamButtonState extends State<BaseStreamButton> {
  bool isLoading = false;



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return StreamBuilder(
      stream: widget.stream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          isLoading = false;

          if (widget.shouldPop) Navigator.pop(context);

          if (widget.afterFinish != null) {
            widget.afterFinish!(snapshot);
          }

          return mainWidget();
        } else if (snapshot.hasError) {
          isLoading = false;
          WidgetsBinding.instance.addPostFrameCallback((dur) {
            errorManagement(snapshot.error);

          });

          return mainWidget();
        }
        return mainWidget();
      },
    );
  }

  Widget mainWidget() {
    return Container();
  }

  void errorManagement(Object? error){


    String title = "";
    String content = "";
    if(error == getError(RequestError.noNet)){

      title = "عدم دسترسی به اینترنت";
      content = "لطفا از اتصال به اینترنت مطمئن شوید و مجددا تلاش نمایید";

    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: EsTitle(title),
          content: EsOrdinaryText(content),
          actions: [
            EsButton(
              size: ButtonSize.ordinary(context),
                onTap: () {
                  Navigator.pop(context);
                  widget.onPressed();
                },
                text: "تلاش مجدد",)
          ],
        ));

  }

  onPress() {


    if(widget.formKey == null){
      checkConfidence();
    }else{

      if (widget.formKey!.currentState!.validate()) {

        checkConfidence();
      }
    }


  }



  void checkConfidence(){
    if (widget.useConfidence) {
      EsAlerts.confidence(context,
          title: "اخطار",
          content: "آیا از انجام این عملیات مطمئنید؟", onConfirmPress: () {

            setState(() {
              isLoading = true;
            });

            widget.onPressed();

          });
    } else {

      setState(() {
        isLoading = true;
      });

      widget.onPressed();
    }

  }
}