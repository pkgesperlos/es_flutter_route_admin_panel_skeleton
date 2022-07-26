import 'package:checklist_admin_panel/blocs/media_bloc.dart';
import 'package:checklist_admin_panel/constants/styles.dart';
import 'package:checklist_admin_panel/widgets/es_button_streamer.dart';
import 'package:es_flutter_component/es_alert/es_alerts.dart';
import 'package:es_flutter_component/es_button/es_button.dart';
import 'package:es_flutter_component/es_form/es_file_picker/es_file_picker.dart';
import 'package:es_flutter_component/es_form/es_text_field/es_text_field.dart';
import 'package:es_flutter_component/es_form/es_text_field/es_text_field_form.dart';
import 'package:es_flutter_component/es_spacer/es_h_divider.dart';
import 'package:es_flutter_component/es_spacer/es_h_spacer.dart';
import 'package:es_flutter_component/es_spacer/es_v_spacer.dart';
import 'package:es_flutter_component/es_text/es_ordinary_text.dart';
import 'package:es_flutter_component/es_text/es_title.dart';
import 'package:es_flutter_component/resources/constants/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:checklist_admin_panel/constants/dims.dart';
import 'package:http/http.dart';

import '../../../../constants/enums.dart';
import '../../../../constants/strings.dart';
import '../../../../models/category_model.dart';
import '../../../../resources/save_need_api.dart';


class DialogCategoryStore extends StatefulWidget {
  final FormType? type;
  final GestureTapCallback? onDonePress;
  CategoryModel? model;

  DialogCategoryStore({this.onDonePress, this.model, this.type});

  @override
  State<StatefulWidget> createState() => DialogCategoryStoreState();
}

class DialogCategoryStoreState extends State<DialogCategoryStore>
    with SingleTickerProviderStateMixin {


  late AnimationController controller;
  late Animation<double> scaleAnimation;

  final TextEditingController _ctrlTitle = TextEditingController();

  String _id = "";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();


    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 550));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    controller.forward();



    if(widget.type == FormType.update)
      setData();

  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Dialog(
        insetPadding: Styles.dialogMargin(context),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dims.h1BorderRadius(context)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              title("ثبت دسته"),
              EsHDivider(),
              Padding(
                padding: EdgeInsets.all(Dims.h1Padding(context)),
                child: dialogContent(),
              ),
              EsHDivider(),
              buttons()
            ],
          ),
        ),
      ),
    );
  }

  Widget dialogContent() {


    return Form(
      key: _formKey,
      child: Column(
      children: <Widget>[
        EsVSpacer(
          big: true,
        ),

        EsTextFieldForm(
          hint: "عنوان",
          controller: _ctrlTitle,
          textInput: TextInputType.text,
          validator: (String? value){

            if(value!.isEmpty)
              return Validations.emptyTextField;

            return null;
          },
        )
      ],
    ),);
  }

  Widget title(String title) {
    return Padding(
      padding: EdgeInsets.all(Dims.h1Padding(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          EsTitle(title, align: TextAlign.start),
        ],
      ),
    );
  }

  Widget buttons() {
    return Padding(
      padding: EdgeInsets.all(Dims.h1Padding(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          EsButton(
            text: "بستن",
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          EsHSpacer(),

          EsButtonStreamer(
            formKey: _formKey,
              stream: mediaBlocStore.actions,
              onPressed: (){
                Map<String,String> body = {"title": _ctrlTitle.text,"type":"0"};

                if(widget.type == FormType.update){
                  body['id'] = _id;
                }

                mediaBlocStore.fetchStore(
                    apiAddress: "category/store",
                    body: body,
                    fullResponse: (Response res) {
                      if (res.statusCode == 200) {
                        SaveNeedApi.category();
                        Navigator.pop(context);
                        EsAlerts.success(context, Strings.successMessage);
                        widget.onDonePress!();
                      }
                    });
              },
              child: EsButton(
                text: "ثبت",
                clickable: false,
              ),
              preload: EsButton(
                text: "ثبت",
                clickable: false,
                isLoading: true,
              ))

          ,
        ],
      ),
    );
  }

  void setData() {

    _ctrlTitle.text = widget.model?.title;
    _id = widget.model?.id;
  }
}
