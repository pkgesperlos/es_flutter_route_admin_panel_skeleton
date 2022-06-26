
import 'package:es_flutter_component/es_table/es_simple_table.dart';
import 'package:checklist_admin_panel/images/panelConstants.dart';
import 'package:flutter/material.dart';
import '../../../images/panelConstants.dart';

class PanelSimpleTable extends StatelessWidget {
  const PanelSimpleTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: PanelConstants.backGround,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(PanelConstants.paddingDimension)),
                color: PanelConstants.backGround
          ),
          child:EsSimpleTable(),)
    );
  }

  Widget boxShow(Widget widget) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: PanelConstants.paddingDimension,
        vertical: PanelConstants.paddingDimension * 5,
      ),
      margin: EdgeInsets.all(PanelConstants.paddingDimension),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(PanelConstants.paddingDimension*2)),
          color: PanelConstants.forGround),
      child: widget,
    );
  }
}
