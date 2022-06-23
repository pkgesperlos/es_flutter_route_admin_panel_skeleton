import 'package:es_route_admin_panel_skeleton/drawer/panelItems/container_items.dart';
import 'package:es_flutter_component/constants.dart';
import 'package:es_flutter_component/es_button/es_information_button.dart';

import 'package:es_flutter_component/es_slider/es_carousel_slider.dart';
import 'package:es_flutter_component/es_slider/es_perspective_slider.dart';
import 'package:es_flutter_component/es_text/es_dotted_text.dart';
import 'package:es_flutter_component/es_text/es_label_text.dart';
import 'package:es_flutter_component/es_text/es_ordinary_text.dart';
import 'package:es_flutter_component/es_text/es_title.dart';
import 'package:es_route_admin_panel_skeleton/images/panelConstants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../images/panelConstants.dart';

class PanelSlider extends StatelessWidget {
  Widget titleBox(int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      decoration: BoxDecoration(
          color: PanelConstants.itemColor,
          borderRadius: BorderRadius.all(
              Radius.circular(PanelConstants.paddingDimension))),
      child: Center(
        child: EsTitle(
          data: index.toString(),
          color: PanelConstants.itemcoupleColor,
        ),
      ),
    );
  }

  const PanelSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String _data = AppLocalizations.of(context)!.samplButton;
    List<Widget> widgetList = List.generate(
      20,
      (index) => titleBox(index),
    );
    List list = [
      ContainerItems(
          widget:Container(
            child: EsCarouselSlider(
              itemList: widgetList,
            ),
            width: 300,
            height: 240,
          ),
          title:AppLocalizations.of(context)!.carouselSlider,
          information:"It is a carousel slider located in: \n es_flutter_component>lib>es_slider>es_carousel_slider.dart \n and is used as: \n "
              """EsCarouselSlider(
              itemList: widgetList,)"""
      ),
      ContainerItems(
          widget:Container(
            child: EsPerspectiveSlider(
              itemList: widgetList,
            ),
            width: 300,
            height: 240,
          ),
          title:AppLocalizations.of(context)!.perspectiveSlider,
          information:"It is a perspective slider located in: \n es_flutter_component>lib>es_slider>es_perspective_slider.dart \n and is used as: \n "
              """EsPerspectiveSlider(
              itemList: widgetList,)"""
      ),
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
                child: EsOrdinaryText(
                  data: AppLocalizations.of(context)!.sliderDescription,
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

}
