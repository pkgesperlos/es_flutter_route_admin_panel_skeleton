
import 'package:es_flutter_component/es_table/es_editable_table.dart';
import 'package:es_flutter_component/es_table/es_responsive_table.dart';
import 'package:es_flutter_component/es_table/es_simple_table.dart';
import 'package:es_flutter_component/es_text/es_dotted_text.dart';
import 'package:es_route_admin_panel_skeleton/images/panelConstants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../images/panelConstants.dart';

class PanelResponsiveTable extends StatelessWidget {
  const PanelResponsiveTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String _data = AppLocalizations.of(context)!.samplButton;

    return Material(
        color: PanelConstants.backGround,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(PanelConstants.paddingDimension)),
                color: PanelConstants.backGround
          ),
          child: EsResponsiveTable(),)
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
