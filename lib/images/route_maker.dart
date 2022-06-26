import 'package:checklist_admin_panel/app_bar/app_bar_widget.dart';
import 'package:checklist_admin_panel/images/responsive_layout.dart';
import 'package:flutter/material.dart';

import '../drawer/drawer_page.dart';

class RoutMaker extends StatelessWidget {
  List<Map>? routes;
  Widget? child;

  RoutMaker({this.routes, this.child});

  @override
  Widget build(BuildContext context) {
    // routes ??= Data.routes();

    return Material(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 100),
            child: (ResponsiveLayot.isTinyLimit(context) ||
                    ResponsiveLayot.isTinyHightLimit(context)
                ? Container()
                : AppBarWidget()),
          ),

          body: ResponsiveLayot(
            tiny: Container(),
            phone: child as Widget,
            tablet: Row(
              children: [
                // Expanded(child: PanelLeftPage()),
                // Expanded(child: PanelCenterPage()),
                Expanded(child: child as Widget),
              ],
            ),
            largTablet: child as Widget,
            computer: Row(
              children: [

                Expanded(flex: 1, child: DrawerPage()),
                Expanded(flex: 5, child: child as Widget),

              ],
            ),
          ),
          drawer: ResponsiveLayot(
            tiny: DrawerPage(),
            phone: DrawerPage(),
            tablet: DrawerPage(),
            largTablet: DrawerPage(),
            computer: Container(),
          )
      ),


    );
  }
}


