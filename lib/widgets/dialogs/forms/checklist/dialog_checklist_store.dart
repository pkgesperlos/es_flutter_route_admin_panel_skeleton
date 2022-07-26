import 'package:checklist_admin_panel/blocs/media_bloc.dart';
import 'package:checklist_admin_panel/constants/styles.dart';
import 'package:checklist_admin_panel/models/checklist_model.dart';
import 'package:checklist_admin_panel/resources/save.dart';
import 'package:checklist_admin_panel/widgets/es_button_streamer.dart';
import 'package:es_flutter_component/es_alert/es_alerts.dart';
import 'package:es_flutter_component/es_button/es_button.dart';
import 'package:es_flutter_component/es_form/es_drop_down_button/es_simple_model_drop_down_form.dart';
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
import '../../../simple_model_drop_down.dart';

class DialogChecklistStore extends StatefulWidget {
  final FormType type;
  final GestureTapCallback? onDonePress;
  ChecklistModel? model;

  DialogChecklistStore(
      {this.onDonePress, this.model, this.type = FormType.add});

  @override
  State<StatefulWidget> createState() => DialogChecklistStoreState();
}

class DialogChecklistStoreState extends State<DialogChecklistStore>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  final TextEditingController _ctrlTitle = TextEditingController();

  String _id = "";
  String _categoryId = "";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 550));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    controller.forward();

    if (widget.type == FormType.update) setData();
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
              title("ثبت چک لیست"),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          EsVSpacer(
            big: true,
          ),
          EsTextFieldForm(
            hint: "عنوان",
            textInput: TextInputType.text,
            controller: _ctrlTitle,
            validator: (String? value) {
              if (value!.isEmpty)
                return Validations.emptyTextField;

              return null;
            },
          ),
          EsVSpacer(),
          FutureBuilder<CategoryModelList>(
            future: getCategory(),
            builder: (context, AsyncSnapshot<CategoryModelList> snapshot) {
              if (snapshot.hasData) {
                return EsSimpleModelDropDownForm(
                  value: _categoryId,
                  initialTitle: "دسته بندی را انتخاب کنید",
                  list: snapshot.data!.listMap,
                  onChange: (id) {
                    _categoryId = id;
                  }, validator: (value) {

                  if (value.isEmpty)
                    return Validations.notSelectedDropDown;

                  return null;
                },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        ],
      ),
    );
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
          EsButtonStreamer(formKey:_formKey,stream: mediaBlocStore.actions, onPressed: (){
            Map<String, String> body = {
              "title": _ctrlTitle.text,
              "category_id": _categoryId
            };

            if (widget.type == FormType.update) {
              body['id'] = _id;
            }

            mediaBlocStore.fetchStore(
                apiAddress: "checklist/store",
                body: body,
                fullResponse: (Response res) {
                  if (res.statusCode == 200) {
                    SaveNeedApi.category();
                    Navigator.pop(context);
                    EsAlerts.success(context, Strings.successMessage);
                    widget.onDonePress!();
                  }
                });
          }, child: EsButton(
            text: "ثبت",
            clickable: false,
          ), preload: EsButton(
            text: "ثبت",
            clickable: false,
            isLoading: true,
          )),
        ],
      ),
    );
  }

  void setData() {
    _ctrlTitle.text = widget.model?.title;
    _id = widget.model?.id;
    _categoryId = widget.model?.category_id;
  }

  Future<CategoryModelList> getCategory() async {
    CategoryModelList model = await Save().getChecklistCategory();

    return model;
  }
}
