import 'package:es_route_admin_panel_skeleton/drawer/panelItems/container_items.dart';
import 'package:es_flutter_component/constants.dart';
import 'package:es_flutter_component/es_button/es_information_button.dart';

import 'package:es_flutter_component/es_image/es_avatar_image.dart';
import 'package:es_flutter_component/es_image/es_lightbox_showing_image.dart';
import 'package:es_flutter_component/es_image/es_zooming_image.dart';
import 'package:es_flutter_component/es_text/es_dotted_text.dart';
import 'package:es_flutter_component/es_text/es_ordinary_text.dart';
import 'package:es_route_admin_panel_skeleton/images/panelConstants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../images/panelConstants.dart';

class PanelImage extends StatelessWidget {
  const PanelImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List list = [
      ContainerItems(
          widget:EsAvatarImage(
            path: "assets/images/img1.jpg",
            radius: 100,
          ),
          title:AppLocalizations.of(context)!.avatarImages,
          information: "It is an avatar image located in: \n es_flutter_component>lib>es_image>es_avatar_image.dart \n and is used as: \n "
              """EsAvatarImage(
            path: "assets/images/img1.jpg",)"""
      ),
      ContainerItems(
          widget:Container(
            child: EsZoomingImage(
              img: AssetImage("assets/images/img1.jpg"),
            ),
            width: 300,
            height: 240,
          ),
          title:AppLocalizations.of(context)!.zoomingImages,
          information:"It is a zooming image located in: \n es_flutter_component>lib>es_image>es_zooming_image.dart \n and is used as: \n "
              """EsZoomingImage(
              img: AssetImage("assets/images/img1.jpg"), )"""
      ),
      ContainerItems(
          widget:Container(
            child: Container(
              child: EsLightBoxShowing(
                path: "assets/images/img1.jpg",
              ),
              width: 300,
              height: 240,
            ),
            width: 300,
            height: 240,
          ),
          title:AppLocalizations.of(context)!.lightBoxShowingImage,
          information:"It is a light box showing image located in: \n es_flutter_component>lib>es_image>es_lightbox_showing_image.dart \n and is used as: \n "
              """EsLightBoxShowing(
                path: "assets/images/img1.jpg",)"""
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
                ////////////////////////
                child: EsOrdinaryText(
                  data: AppLocalizations.of(context)!.imageDescription,
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
