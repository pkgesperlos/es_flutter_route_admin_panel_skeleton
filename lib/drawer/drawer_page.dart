
import 'dart:io' show Platform;

import 'package:es_flutter_component/es_text/es_ordinary_text.dart';
import 'package:es_route_admin_panel_skeleton/drawer/panelItems/panel_chart.dart';
import 'package:es_route_admin_panel_skeleton/drawer/panelItems/Panel_tabel/panel_editable_table.dart';
import 'package:es_route_admin_panel_skeleton/drawer/panelItems/panel_button_sample.dart';
import 'package:es_route_admin_panel_skeleton/drawer/panelItems/panel_dialog_box.dart';
import 'package:es_route_admin_panel_skeleton/drawer/panelItems/panel_form.dart';
import 'package:es_route_admin_panel_skeleton/drawer/panelItems/panel_image.dart';
import 'package:es_route_admin_panel_skeleton/drawer/panelItems/panel_notification.dart';
import 'package:es_route_admin_panel_skeleton/drawer/panelItems/panel_progressbar.dart';
import 'package:es_route_admin_panel_skeleton/drawer/panelItems/Panel_tabel/panel_responsive_table.dart';
import 'package:es_route_admin_panel_skeleton/drawer/panelItems/panel_slider.dart';
import 'package:es_route_admin_panel_skeleton/drawer/panelItems/Panel_tabel/panel_simple_table.dart';
import 'package:es_route_admin_panel_skeleton/drawer/panelItems/panel_text_sample.dart';
import 'package:flutter/material.dart';
import '../images/panelConstants.dart';
import '../center_sceen/center_screen.dart';
import '../images/responsive_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            title: AppLocalizations.of(context)!.charts,
            icon: Icons.bar_chart,
            page: PanelChart(),
            pageRout: '/chart'),
      ],
      [
        buttonsInfo(
            title: AppLocalizations.of(context)!.text,
            icon: Icons.edit,
            page: PanelTextSample(),
            pageRout: '/textSample'),
      ],
      [
        buttonsInfo(
            title: AppLocalizations.of(context)!.dialogBox,
            icon: Icons.messenger_outline,
            page: PanelDialogBox(),
            pageRout: '/dialog'),
      ],
      [
        buttonsInfo(
            title: AppLocalizations.of(context)!.button,
            icon: Icons.radio_button_checked_sharp,
            page: PanelButtonSample(),
            pageRout: '/buttonSample'),
      ],
      [
        buttonsInfo(
            title: AppLocalizations.of(context)!.form,
            icon: Icons.list_alt,
            page: PanelForm(),
            pageRout: '/form')
      ],
      [
        buttonsInfo(
            title: AppLocalizations.of(context)!.images,
            icon: Icons.image_outlined,
            page: PanelImage(),
            pageRout: '/image')
      ],
      [
        buttonsInfo(
            title: AppLocalizations.of(context)!.progressBar,
            icon: Icons.timelapse_rounded,
            page: PanelProgressBar(),
            pageRout: '/progressbar')
      ],
      [
        AppLocalizations.of(context)!.tables,
        buttonsInfo(
            title: AppLocalizations.of(context)!.simpleTable,
            icon: Icons.table_chart_outlined,
            page: PanelSimpleTable(),
            pageRout: '/simpleTable'),
        buttonsInfo(
            title: AppLocalizations.of(context)!.editableTable,
            icon: Icons.table_rows,
            page: PanelEditableTable(),
            pageRout: '/editableTable'),
        buttonsInfo(
            title: AppLocalizations.of(context)!.responsiveTable,
            icon: Icons.table_chart,
            page: PanelResponsiveTable(),
            pageRout: '/responsiveTable')
      ],
      [
        buttonsInfo(
            title: AppLocalizations.of(context)!.slider,
            icon: Icons.slideshow_rounded,
            page: PanelSlider(),
            pageRout: '/slider')
      ],
      [
        buttonsInfo(
            title: AppLocalizations.of(context)!.notifications,
            icon: Icons.notification_important_outlined,
            page: PanelNotification(),
            pageRout: '/notification')
      ],
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
              // data: _buttonNames2[index][0].title,
              data: item.title,
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
                    data: AppLocalizations.of(context)!.adminMenu,
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

                                      // Platform.isWindows ||
                                      // Platform.isAndroid ||
                                      // Platform.isIOS ||
                                      // Platform.isLinux ||
                                      // Platform.isFuchsia
                                      //     ? Navigator.pushReplacementNamed(context, _buttonNames[index][0].pageRout)
                                      //     :
                                      Navigator.pushNamed(context, _buttonNames[index][0].pageRout);

                                    }
                                    );
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
                                  initiallyExpanded:_acardionList[
                                  _currentIndex] != 0? true:false,
                                  title: Row(
                                    children: [
                                      EsOrdinaryText(
                                        data: _buttonNames[index][0],
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
                                                    // leading: Padding(
                                                    //   padding: EdgeInsets.all(
                                                    //       PanelConstants
                                                    //           .paddingDimension),
                                                    //   child: Icon(
                                                    //     _buttonNames[index]
                                                    //             [index2 + 1]
                                                    //         .icon,
                                                    //     color: (index2 ==
                                                    //                 _currentIndex2 &&
                                                    //             _acardionList[
                                                    //                     _currentIndex] !=
                                                    //                 0)
                                                    //         ? PanelConstants
                                                    //             .drawerSelectColor1
                                                    //         : PanelConstants
                                                    //             .drawerFontColor,
                                                    //   ),
                                                    // ),
                                                    onTap: () {
                                                      setState(() {
                                                        _currentIndex2 = index2;
                                                        _currentIndex = index;

                                                        // Platform.isWindows ||
                                                        //     Platform.isAndroid ||
                                                        //     Platform.isIOS ||
                                                        //     Platform.isLinux ||
                                                        //     Platform.isFuchsia
                                                        //     ? Navigator.pushReplacementNamed(context, _buttonNames[index][index2+1].pageRout)
                                                        //     :
                                                        Navigator.pushNamed(context, _buttonNames[index][index2+1].pageRout);

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
