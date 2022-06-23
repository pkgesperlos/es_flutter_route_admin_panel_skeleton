import 'package:es_route_admin_panel_skeleton/drawer/panelItems/container_items.dart';
import 'package:es_flutter_component/constants.dart';
import 'package:es_flutter_component/es_button/es_information_button.dart';
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

class PanelTextSample extends StatelessWidget {
  const PanelTextSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _data = AppLocalizations.of(context)!.sampleText;
    List list = [
      ContainerItems(
          widget:Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
                5,
                (index) => Column(
                      children: [
                        EsTitle(
                          data: _data,
                          size: Constants.ordinaryFontSize - index * 2,
                        ),
                        SizedBox(
                          height: PanelConstants.paddingDimension *
                              (Constants.titleFontSize *
                                  2.5 /
                                  Constants.ordinaryFontSize),
                        )
                      ],
                    )),
          ),
          title:AppLocalizations.of(context)!.titleText,
          information:"It is a title located in: \n es_flutter_component>lib>es_text>es_title.dart \n and is used as: \n "
              """EsTitle(data: _data,size: Constants.ordinaryFontSize, ),"""
    ),
      ContainerItems(
          widget:Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
                5,
                (index) => Column(
                      children: [
                        EsOrdinaryText(
                          data: _data,
                          size: Constants.ordinaryFontSize - index * 2,
                        ),
                        SizedBox(
                          height: PanelConstants.paddingDimension *
                              (Constants.titleFontSize *
                                  2.5 /
                                  Constants.ordinaryFontSize),
                        )
                      ],
                    )),
          ),
          title:AppLocalizations.of(context)!.ordinaryText,
          information:"It is ordinary text located in: \n es_flutter_component>lib>es_text>es_ordinary_text.dart \n and is used as: \n "
              """EsOrdinaryText(data: _data,size: Constants.ordinaryFontSize, ),"""
      ),
      ContainerItems(
          widget:Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
                3,
                (index) => Column(
                      children: [
                        EsDottedText(
                          data: _data,
                          size: Constants.markedFontSize - index * 3,
                        ),
                        SizedBox(height: PanelConstants.paddingDimension)
                      ],
                    )),
          ),
          title:AppLocalizations.of(context)!.dottedText,
          information:"It is a dotted text located in: \n es_flutter_component>lib>es_text>es_dotted_text.dart \n and is used as: \n "
              """EsDottedText(data: _data,size: Constants.ordinaryFontSize, ),"""
      ),
      ContainerItems(
          widget:Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
                3,
                (index) => Column(
                      children: [
                        EsMarkedText(
                          data: _data,
                          size: Constants.markedFontSize - index * 3,
                        ),
                        SizedBox(height: PanelConstants.paddingDimension)
                      ],
                    )),
          ),
          title:AppLocalizations.of(context)!.markedText,
          information:"It is a marked text located in: \n es_flutter_component>lib>es_text>es_marked_text.dart \n and is used as: \n "
              """EsMarkedText(data: _data,size: Constants.ordinaryFontSize, ),"""
      ),
      ContainerItems(
          widget:Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
                3,
                (index) => Column(
                      children: [
                        EsLableText(
                          data: _data,
                          size: Constants.lableFontSize - index * 3,
                        ),
                        SizedBox(
                          height: PanelConstants.paddingDimension * .5,
                        )
                      ],
                    )),
          ),
          title:AppLocalizations.of(context)!.labledText,
          information:"It is a labeled text located in: \n es_flutter_component>lib>es_text>es_labeled_text.dart \n and is used as: \n "
              """EsLabeledText(data: _data,size: Constants.ordinaryFontSize, ),"""
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
                  data: AppLocalizations.of(context)!.textSampleDescription,
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
          padding: EdgeInsets.all(PanelConstants.paddingDimension),
          margin: EdgeInsets.all(PanelConstants.paddingDimension),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(PanelConstants.paddingDimension * 2)),
              color: PanelConstants.forGround),
          child: widget,
        ));
  }

  Widget _listItem(Widget widget, String title, String information) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(bottom: PanelConstants.paddingDimension),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EsDottedText(
                data: title,
                size: 15,
                color: PanelConstants.itemColor,
              ),
              EsInformationButton(
                dialogeText: information,
              ),
            ],
          ),
        ),
        widget
      ],
    );
  }
}
