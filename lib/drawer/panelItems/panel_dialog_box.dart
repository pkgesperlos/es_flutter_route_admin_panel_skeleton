import 'package:es_route_admin_panel_skeleton/drawer/panelItems/container_items.dart';
import 'package:es_flutter_component/constants.dart';
import 'package:es_flutter_component/es_dialog/es_awesome_dialog/es_autohide_dialog.dart';
import 'package:es_flutter_component/es_dialog/es_awesome_dialog/es_body_dialog.dart';
import 'package:es_flutter_component/es_dialog/es_awesome_dialog/es_error_dialog.dart';
import 'package:es_flutter_component/es_dialog/es_awesome_dialog/es_info_dialog.dart';
import 'package:es_flutter_component/es_dialog/es_awesome_dialog/es_input_dialog.dart';
import 'package:es_flutter_component/es_dialog/es_awesome_dialog/es_success_dialog.dart';
import 'package:es_flutter_component/es_dialog/es_awesome_dialog/es_warning_dialog.dart';
import 'package:es_flutter_component/es_form/es_text_field.dart';
import 'package:es_flutter_component/es_text/es_ordinary_text.dart';
import 'package:es_route_admin_panel_skeleton/images/panelConstants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../images/panelConstants.dart';

class PanelDialogBox extends StatelessWidget {
  const PanelDialogBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List list = [
      ContainerItems(
          widget:EsSuccessDialog(
            title: AppLocalizations.of(context)!.successDialogTitle,
            text: AppLocalizations.of(context)!.successDialogText,
            desc: AppLocalizations.of(context)!.successDialogDesc,
          ),
         title: AppLocalizations.of(context)!.successDialogText,
          information: "It is a success dialog sample located in: \n es_flutter_component>lib>es_dialog>es_success_dialog.dart \n and is used as: \n "
              """ EsSuccessDialog(
            title: AppLocalizations.of(context)!.successDialogTitle,
            text: AppLocalizations.of(context)!.successDialogText,
            desc: AppLocalizations.of(context)!.successDialogDesc,),"""),
      ContainerItems(
          widget:EsErrorDialog(
            title: AppLocalizations.of(context)!.errorDialogTitle,
            text: AppLocalizations.of(context)!.errorDialogText,
            desc: AppLocalizations.of(context)!.errorDialogDesc,
          ),
          title:AppLocalizations.of(context)!.errorDialogText,
          information:"It is a error dialog sample located in: \n es_flutter_component>lib>es_dialog>es_error_dialog.dart \n and is used as: \n "
              """ EsErrorDialog(
            title: AppLocalizations.of(context)!.errorDialogTitle,
            text: AppLocalizations.of(context)!.errorDialogText,
            desc: AppLocalizations.of(context)!.errorDialogDesc,),"""),
      ContainerItems(
          widget:EsWarningDialog(
            title: AppLocalizations.of(context)!.warningDialogTitle,
            text: AppLocalizations.of(context)!.warningDialogText,
            desc: AppLocalizations.of(context)!.warningDialogDesc,
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ),
          title:AppLocalizations.of(context)!.warningDialogText,
          information:"It is a warning dialog sample located in: \n es_flutter_component>lib>es_dialog>es_warning_dialog.dart \n and is used as: \n "
              """EsWarningDialog(
            title: AppLocalizations.of(context)!.warningDialogTitle,
            text: AppLocalizations.of(context)!.warningDialogText,
            desc: AppLocalizations.of(context)!.warningDialogDesc,
            btnCancelOnPress: () {},
            btnOkOnPress: () {},),"""),
      ContainerItems(
          widget:EsInfoDialog(
            title: AppLocalizations.of(context)!.infoDialogTitle,
            text: AppLocalizations.of(context)!.infoDialogText,
            desc: AppLocalizations.of(context)!.infoDialogDesc,
          ),
          title:AppLocalizations.of(context)!.infoDialogText,
          information:"It is a information dialog sample located in: \n es_flutter_component>lib>es_dialog>es_information_dialog.dart \n and is used as: \n "
              """EsInfoDialog(
            title: AppLocalizations.of(context)!.infoDialogTitle,
            text: AppLocalizations.of(context)!.infoDialogText,
            desc: AppLocalizations.of(context)!.infoDialogDesc,),"""),
      ContainerItems(
          widget:EsAutoHideDialog(
            title: AppLocalizations.of(context)!.autoHideDialogTitle,
            text: AppLocalizations.of(context)!.autoHideDialogText,
            desc: AppLocalizations.of(context)!.autoHideDialogDesc,
            time: 2,
          ),
          title:AppLocalizations.of(context)!.autoHideDialogText,
          information:"It is a auto hide dialog sample located in: \n es_flutter_component>lib>es_dialog>es_autohide_dialog.dart \n and is used as: \n "
              """EsAutoHideDialog(
            title: AppLocalizations.of(context)!.autoHideDialogTitle,
            text: AppLocalizations.of(context)!.autoHideDialogText,
            desc: AppLocalizations.of(context)!.autoHideDialogDesc,
            time: 2,)"""),
      ContainerItems(
          widget:EsInputDialog(
            title: AppLocalizations.of(context)!.inputDialogTitle,
            text: AppLocalizations.of(context)!.inputDialogText,
            desc: AppLocalizations.of(context)!.inputDialogDesc,
            esTextField1: EsTextField(
              type: AppLocalizations.of(context)!.input1,
              hint: AppLocalizations.of(context)!.input1,
            ),
            esTextField2: EsTextField(
              type: AppLocalizations.of(context)!.input1,
              hint: AppLocalizations.of(context)!.input2,
            ),
          ),
          title:AppLocalizations.of(context)!.inputDialogText,
          information:"It is a  dialog sample with input field located in: \n es_flutter_component>lib>es_dialog>es_input_dialog.dart \n and is used as: \n "
              """EsInputDialog(
            title: AppLocalizations.of(context)!.inputDialogTitle,
            text: AppLocalizations.of(context)!.inputDialogText,
            desc: AppLocalizations.of(context)!.inputDialogDesc,
            esTextField1: EsTextField(
              type: AppLocalizations.of(context)!.input1,
              hint: AppLocalizations.of(context)!.input1,
            ),
            esTextField2: EsTextField(
              type: AppLocalizations.of(context)!.input1,
              hint: AppLocalizations.of(context)!.input2,
            ),)"""),
      ContainerItems(
          widget:EsBodyDialog(
            title: AppLocalizations.of(context)!.bodyDialogTitle,
            text: AppLocalizations.of(context)!.bodyDialogText,
            desc: AppLocalizations.of(context)!.bodyDialogDesc,
          ),
          title:AppLocalizations.of(context)!.bodyDialogText,
          information:"It is a  dialog sample with simple body field located in: \n es_flutter_component>lib>es_dialog>es_body_dialog.dart \n and is used as: \n "
              """EsBodyDialog(
            title: AppLocalizations.of(context)!.bodyDialogTitle,
            text: AppLocalizations.of(context)!.bodyDialogText,
            desc: AppLocalizations.of(context)!.bodyDialogDesc,)"""),
    ];
    return Material(
        color: PanelConstants.backGround,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: PanelConstants.paddingDimension),
                margin: EdgeInsets.all(PanelConstants.paddingDimension * 2),

                width: double.maxFinite,
                ////////////////////////
                child: EsOrdinaryText(
                  data: AppLocalizations.of(context)!.dialogeBoxDescription,
                ),
                decoration: BoxDecoration(
                    color: PanelConstants.forGround,
                    borderRadius: BorderRadius.all(
                        Radius.circular(Constants.paddingDimension))),
              ),
              BootstrapContainer(
                  fluid: true,
                  padding: EdgeInsets.all(PanelConstants.paddingDimension),
                  decoration: BoxDecoration(
                    color: PanelConstants.backGround,
                  ),
                  children: List.generate(
                      list.length, (index) => boxShow(list[index])))
            ],
          ),
        ));
  }

  Widget boxShow(Widget widget) {
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
