import 'package:checklist_admin_panel/drawer/panelItems/container_items.dart';
import 'package:es_flutter_component/constants.dart';
import 'package:es_flutter_component/es-chart/es-circular_chart.dart';
import 'package:es_flutter_component/es-chart/es-linear-chart.dart';
import 'package:es_flutter_component/es-chart/es_bar_chart.dart';
import 'package:es_flutter_component/es_text/es_ordinary_text.dart';
import 'package:checklist_admin_panel/images/panelConstants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../images/panelConstants.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List list = [
      ContainerItems(widget:EsBarChart(),title:AppLocalizations.of(context)!.barCharts,
          information: "It is a bar chart located in: \n es_flutter_component>lib>es_chart>es_bar_chart.dart \n and is used as EsBarChart()"),
      ContainerItems(widget:EsLinearChart(),title:AppLocalizations.of(context)!.linearChart,
          information:"It is a linear chart located in: \n es_flutter_component>lib>es_chart>es_linear_chart.dart \n and is used as EsLinearChart()"),
      ContainerItems(widget:EsCircularChart(),title:AppLocalizations.of(context)!.circularCharts,
          information:"It is a circular chart located in: \n es_flutter_component>lib>es_chart>es_circular_chart.dart \n and is used as EsCircularChart()"),

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
                  data:AppLocalizations.of(context)!.chartDescription ,
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
            vertical: PanelConstants.paddingDimension ,
          ),
          margin: EdgeInsets.all(PanelConstants.paddingDimension),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(PanelConstants.paddingDimension*2)),
              color: PanelConstants.forGround),
          child: widget,
        ));
  }
}
