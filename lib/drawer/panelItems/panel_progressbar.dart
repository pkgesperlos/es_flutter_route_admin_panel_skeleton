import 'package:es_route_admin_panel_skeleton/drawer/panelItems/container_items.dart';
import 'package:es_flutter_component/constants.dart';
import 'package:es_flutter_component/es_button/es_information_button.dart';

import 'package:es_flutter_component/es_image/es_avatar_image.dart';
import 'package:es_flutter_component/es_image/es_responsive_image.dart';
import 'package:es_flutter_component/es_image/es_zooming_image.dart';
import 'package:es_flutter_component/es_progressbar/es_circular_progressbar.dart';
import 'package:es_flutter_component/es_progressbar/es_linear_progressbar.dart';
import 'package:es_flutter_component/es_slider/es_carousel_slider.dart';
import 'package:es_flutter_component/es_slider/es_perspective_slider.dart';
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

class PanelProgressBar extends StatelessWidget {
  Widget titleBox(int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      decoration: BoxDecoration(
          color: PanelConstants.itemColor,
          borderRadius: BorderRadius.all(
              Radius.circular(PanelConstants.paddingDimension))),
      child: Center(
        child: EsLableText(
          data: index.toString(),
          color: PanelConstants.itemcoupleColor,
        ),
      ),
    );
  }

  const PanelProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String _data = AppLocalizations.of(context)!.samplButton;
    List<Widget> widgetList = List.generate(
      20,
      (index) => titleBox(index),
    );
    List list = [
      ContainerItems(widget:EsLinearProgressbar(),
          title:AppLocalizations.of(context)!.linearProgressBar,
          information:"It is a linear progress bar located in: \n es_flutter_component>lib>es_progressbar>es_linear_progressbar.dart \n and is used as: \n "
              """EsLinearProgressbar()"""
      ),
      ContainerItems(widget:EsCircularProgressbar(),
          title:AppLocalizations.of(context)!.circularProgressBar,
          information:"It is a circular progress bar located in: \n es_flutter_component>lib>es_progressbar>es_circular_progressbar.dart \n and is used as: \n "
              """EsCircularProgressbar()"""
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
                  data: AppLocalizations.of(context)!.progressBarDescription,
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

  Widget _listItem(Widget widget, String title, String information) {
    return Center(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EsDottedText(
                data: title,
                size: 15,
                color: PanelConstants.itemColor,
              ),
              SizedBox(
                height: PanelConstants.paddingDimension * 10,
              ),
              EsInformationButton(
                dialogeText: information,
              ),
            ],
          ),
        ),
        widget,
      ],
    ));
  }
}
