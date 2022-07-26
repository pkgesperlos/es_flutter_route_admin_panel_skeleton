import 'package:checklist_admin_panel/blocs/media_bloc.dart';
import 'package:checklist_admin_panel/constants/styles.dart';
import 'package:checklist_admin_panel/widgets/es_button_streamer.dart';
import 'package:es_flutter_component/es_alert/es_alerts.dart';
import 'package:es_flutter_component/es_button/es_button.dart';
import 'package:es_flutter_component/es_form/es_file_picker/es_file_picker.dart';
import 'package:es_flutter_component/es_spacer/es_h_divider.dart';
import 'package:es_flutter_component/es_spacer/es_h_spacer.dart';
import 'package:es_flutter_component/es_spacer/es_v_spacer.dart';
import 'package:es_flutter_component/es_text/es_ordinary_text.dart';
import 'package:es_flutter_component/es_text/es_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:checklist_admin_panel/constants/dims.dart';
import 'package:http/http.dart';

import '../../../../constants/enums.dart';
import '../../../../constants/strings.dart';

class DialogMediaStore extends StatefulWidget {
  final FormType? type;
  final GestureTapCallback? onDonePress;
  var model;

  DialogMediaStore({this.onDonePress, this.model, this.type});

  @override
  State<StatefulWidget> createState() => DialogMediaStoreState();
}

class DialogMediaStoreState extends State<DialogMediaStore>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  final EsFilePickerController _filePickerController = EsFilePickerController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 550));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    controller.forward();
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
              title("ثبت رسانه"),
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
    return Column(
      children: <Widget>[
        EsVSpacer(
          big: true,
        ),
        EsFilePicker(
          label: "انخاب فایل",
          controller: _filePickerController,
        )
      ],
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
          EsButtonStreamer(stream: mediaBlocStore.actions, onPressed: (){
            mediaBlocStore.fetchStore(
                apiAddress: "media/store",
                body: {"file": _filePickerController.base64File},
                fullResponse: (Response res) {
                  if (res.statusCode == 200) {
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
}
