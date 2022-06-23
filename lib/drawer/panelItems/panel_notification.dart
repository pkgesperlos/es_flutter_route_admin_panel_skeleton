import 'package:es_route_admin_panel_skeleton/drawer/panelItems/container_items.dart';
import 'package:es_flutter_component/constants.dart';
import 'package:es_flutter_component/es_button/es_icon_button.dart';
import 'package:es_flutter_component/es_button/es_information_button.dart';
import 'package:es_flutter_component/es_button/es_loading_button.dart';
import 'package:es_flutter_component/es_button/es_ordinary_button.dart';
import 'package:es_flutter_component/es_dialog/es_awesome_dialog/es_autohide_dialog.dart';
import 'package:es_flutter_component/es_dialog/es_awesome_dialog/es_body_dialog.dart';
import 'package:es_flutter_component/es_dialog/es_awesome_dialog/es_error_dialog.dart';
import 'package:es_flutter_component/es_dialog/es_awesome_dialog/es_info_dialog.dart';
import 'package:es_flutter_component/es_dialog/es_awesome_dialog/es_input_dialog.dart';
import 'package:es_flutter_component/es_dialog/es_awesome_dialog/es_success_dialog.dart';
import 'package:es_flutter_component/es_dialog/es_awesome_dialog/es_warning_dialog.dart';
import 'package:es_flutter_component/es_form/es_text_field.dart';
import 'package:es_flutter_component/es_notification/es_ordinary_notification.dart';
import 'package:es_flutter_component/es_text/es_dotted_text.dart';
import 'package:es_flutter_component/es_text/es_label_text.dart';
import 'package:es_flutter_component/es_text/es_marked_text.dart';
import 'package:es_flutter_component/es_text/es_ordinary_text.dart';
import 'package:es_flutter_component/es_text/es_title.dart';
import 'package:es_route_admin_panel_skeleton/images/panelConstants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../images/panelConstants.dart';

class PanelNotification extends StatelessWidget {
  const PanelNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _data = AppLocalizations.of(context)!.samplButton;
    List list = [
      ContainerItems(
          widget:EsOrdinaryButton(
            text: AppLocalizations.of(context)!.simpleNotifications,
            onPressed: () {
              NotificationApi.showNotification();
            },
          ),
          title:AppLocalizations.of(context)!.simpleNotifications,
          information:"It is an ordinary notification located in: \n es_flutter_component>lib>es_notification>es_ordinary_notification.dart \n and is used as: \n "
              """EsOrdinaryButton(
            text: AppLocalizations.of(context)!.simpleNotifications,
            onPressed: () {
              NotificationApi.showNotification(); },),"""
      )
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
                  data: AppLocalizations.of(context)!.notificationsDescription,
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
                      list.length, (index) => _boxShow(list[index])))
            ],
          ),
        ));
  }

  Widget _boxShow(Widget widget) {
    return BootstrapCol(
        sizes: 'col-sm-12 col-ml-12 col-lg-4 col-xl-4',
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
