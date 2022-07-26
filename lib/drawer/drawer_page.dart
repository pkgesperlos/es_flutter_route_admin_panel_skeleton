import 'dart:io' show Platform;
import 'package:checklist_admin_panel/screens/menu_pages/category.dart';
import 'package:checklist_admin_panel/screens/menu_pages/checklist.dart';
import 'package:checklist_admin_panel/screens/menu_pages/media.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:es_flutter_component/es_text/es_ordinary_text.dart';
import 'package:checklist_admin_panel/drawer/panelItems/Panel_tabel/panel_editable_table.dart';
import 'package:checklist_admin_panel/drawer/panelItems/panel_form.dart';
import 'package:checklist_admin_panel/drawer/panelItems/Panel_tabel/panel_responsive_table.dart';
import 'package:checklist_admin_panel/drawer/panelItems/Panel_tabel/panel_simple_table.dart';
import 'package:flutter/material.dart';
import '../images/panelConstants.dart';
import '../images/responsive_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../screens/menu_pages/dashboard.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class buttonsInfo {
  String title;
  IconData icon;
  Widget page;
  String pageRout;

  buttonsInfo(
      {required this.title,
      required this.icon,
      required this.page,
      required this.pageRout});
}

//index of drawer item
int _currentIndex = 0;
//index of accardion item of drawer item
int _currentIndex2 = 0;

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    //We have an array like this List=[buttonsInfo,[string,buttonsInfo,buttonsInfo]]
    // for acardion and non acardion type
    List<List> _buttonNames = [
      [
        buttonsInfo(
            title: AppLocalizations.of(context)!.dashboard,
            icon: Icons.bar_chart,
            page: Dashboard(),
            pageRout: '/dashboard'),
      ],

      [
        buttonsInfo(
            title: AppLocalizations.of(context)!.media,
            icon: Icons.list_alt,
            page: Media(),
            pageRout: '/media')
      ],

      [
        buttonsInfo(
            title: AppLocalizations.of(context)!.category,
            icon: Icons.list_alt,
            page: Checklist(),
            pageRout: '/category')
      ],

      [
        buttonsInfo(
            title: AppLocalizations.of(context)!.checklist,
            icon: Icons.list_alt,
            page: Checklist(),
            pageRout: '/checklist')
      ],

      // [
      //   AppLocalizations.of(context)!.tables,
      //   buttonsInfo(
      //       title: AppLocalizations.of(context)!.simpleTable,
      //       icon: Icons.table_chart_outlined,
      //       page: PanelSimpleTable(),
      //       pageRout: '/simpleTable'),
      //   buttonsInfo(
      //       title: AppLocalizations.of(context)!.editableTable,
      //       icon: Icons.table_rows,
      //       page: PanelEditableTable(),
      //       pageRout: '/editableTable'),
      //   buttonsInfo(
      //       title: AppLocalizations.of(context)!.responsiveTable,
      //       icon: Icons.table_chart,
      //       page: PanelResponsiveTable(),
      //       pageRout: '/responsiveTable')
      // ],

    ];
    List _acardionList = [];
    for (int i = 0; i < _buttonNames.length; i++) {
      _acardionList.add(_buttonNames[i].length != 1 ? 1 : 0);
    }
    Widget drawerItems(item, index, currentIndex, bool con) {
      return Container(
        padding: EdgeInsets.only(
            right: PanelConstants.paddingDimension / 3,
            left: PanelConstants.paddingDimension / 10),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(PanelConstants.paddingDimension / 2),
              child: Icon(
                item.icon,
                size: 20,
                // _buttonNames2[index][0].icon,
                color: con
                    ? PanelConstants.drawerSelectColor1
                    : PanelConstants.drawerFontColor,
              ),
            ),
            EsOrdinaryText(
              // _buttonNames2[index][0].title,
              item.title,
              color: con
                  ? PanelConstants.drawerSelectColor1
                  : PanelConstants.drawerFontColor,
              // style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(PanelConstants.paddingDimension))),
      );
    }

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: PanelConstants.forGround,
          // boxShadow: [
          //   BoxShadow(
          //       color: PanelConstants.boxshadow,
          //       blurRadius: 10,
          //       spreadRadius: 10),
          // ],
          // border:Border(right: BorderSide(color: PanelConstants.itemColor,
          // width: 3))
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(PanelConstants.paddingDimension),
            child: Column(
              children: [
                //title of drawer
                ListTile(
                  title: EsOrdinaryText(
                    AppLocalizations.of(context)!.adminMenu,
                  ),
                  //place a clse item for non computer drawer mode
                  trailing: ResponsiveLayot.isComputer(context)
                      ? null
                      : IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.black54,
                          )),
                ),
                //creating list items of drawer
                ...List.generate(
                    _buttonNames.length,
                    //decide if we have accardion or not
                    (index) => _buttonNames[index].length == 1
                        ? Column(
                            children: [
                              Container(
                                //deside if the item is selected or not
                                decoration: (index == _currentIndex)
                                    ? selectedBoxDecoration()
                                    : null,
                                child: GestureDetector(
                                  child: drawerItems(
                                      _buttonNames[index][0],
                                      index,
                                      _currentIndex,
                                      (index == _currentIndex)),
                                  onTap: () {
                                    setState(() {
                                      _currentIndex = index;
                                      pushRout(_buttonNames[index][0].pageRout);
                                    });
                                  },
                                ),
                              ),
                              Divider(
                                color: PanelConstants.drawerFontColor,
                                thickness: 0.2,
                              )
                            ],
                          )
                        : Column(
                            children: [
                              Container(
                                // decoration: index == _currentIndex
                                //     ? BoxDecoration(
                                //         borderRadius: BorderRadius.circular(20),
                                //         gradient: LinearGradient(colors: [
                                //           PanelConstants.redDark.withOpacity(0.9),
                                //           PanelConstants.orangeDark.withOpacity(0.9),
                                //         ]))
                                //     : null,
                                child: ExpansionTile(
                                  // maintainState: true,
                                  initiallyExpanded:
                                      _acardionList[_currentIndex] != 0
                                          ? true
                                          : false,
                                  title: Row(
                                    children: [
                                      EsOrdinaryText(
                                        _buttonNames[index][0],
                                        // style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  children: [
                                    ...List.generate(
                                        //_buttonNames[index] is the List of accardion items
                                        _buttonNames[index].length - 1,
                                        (index2) => Column(
                                              children: [
                                                Container(
                                                  //deside if the item is selected or not
                                                  decoration: (index2 ==
                                                              _currentIndex2 &&
                                                          _acardionList[
                                                                  _currentIndex] !=
                                                              0)
                                                      ? selectedBoxDecoration()
                                                      : null,
                                                  child: GestureDetector(
                                                    child: drawerItems(
                                                        _buttonNames[index]
                                                            [index2 + 1],
                                                        index2,
                                                        _currentIndex2,
                                                        index2 ==
                                                                _currentIndex2 &&
                                                            _acardionList[
                                                                    _currentIndex] !=
                                                                0),
                                                    onTap: () {
                                                      setState(() {
                                                        _currentIndex2 = index2;
                                                        _currentIndex = index;

                                                        pushRout(
                                                            _buttonNames[index]
                                                                    [index2 + 1]
                                                                .pageRout);
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Divider(
                                                  color: PanelConstants
                                                      .drawerFontColor,
                                                  thickness: 0.2,
                                                )
                                              ],
                                            ))
                                  ],
                                ),
                              ),
                              Divider(
                                color: PanelConstants.drawerFontColor,
                                thickness: 0.2,
                              )
                            ],
                          ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pushRout(item) {
    if (kIsWeb)
      Navigator.pushNamed(context, item);
    else
      Navigator.pushReplacementNamed(context, item);
  }
  BoxDecoration selectedBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: PanelConstants.drawerSelectColor1, width: 2),
      // gradient: LinearGradient(colors: [
      //   PanelConstants.drawerSelectColor2
      //       .withOpacity(0.9),
      //   PanelConstants.drawerSelectColor1
      //       .withOpacity(0.9),
      // ])
    );
  }
}
