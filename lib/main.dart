
import 'package:es_route_admin_panel_skeleton/drawer/panelItems/panel_chart.dart';
import 'package:es_route_admin_panel_skeleton/drawer/panelItems/panel_dialog_box.dart';
import 'package:es_route_admin_panel_skeleton/drawer/panelItems/panel_progressbar.dart';
import 'package:es_route_admin_panel_skeleton/es_login.dart';
import 'package:es_route_admin_panel_skeleton/language_change_provider.dart';
import 'package:es_route_admin_panel_skeleton/images/route_maker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'drawer/panelItems/Panel_tabel/panel_editable_table.dart';
import 'drawer/panelItems/panel_form.dart';
import 'drawer/panelItems/panel_image.dart';
import 'drawer/panelItems/panel_notification.dart';
import 'drawer/panelItems/panel_slider.dart';
import 'drawer/panelItems/Panel_tabel/panel_simple_table.dart';
import 'drawer/panelItems/panel_text_sample.dart';

void main() {



  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  // const _MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageChangeProvider>(
      create: (context) => LanguageChangeProvider(),
      child: Builder(
          builder: (context) =>
              MaterialApp(
                // locale: Locale("fa"),
                locale:
                Provider
                    .of<LanguageChangeProvider>(context, listen: true)
                    .currentLocale,
                debugShowCheckedModeBanner: false,
                title: 'Localizations Sample App',
                localizationsDelegates: [
                  AppLocalizations.delegate, // Add this line
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                supportedLocales: [
                  Locale('en', ''), // English, no country code
                  Locale('fa', ''), // Persian, no country code
                ],

                initialRoute: '/',
                routes: {
                  '/': (context) => EsLogin(),
                  // '/login': (context) => EsLogin(),
                  // '/': (context) => RoutMaker(child: PanelChart(),),
                  '/chart': (context) => RoutMaker(child: PanelChart(),),
                  '/form': (context) => RoutMaker(child: PanelForm(),),
                  '/progressbar': (context) => RoutMaker(child: PanelProgressBar(),),
                  '/notification': (context) => RoutMaker(child: PanelNotification()),
                  '/chart': (context) => RoutMaker(child: PanelChart()),
                  '/responsiveTable': (context) => RoutMaker(child: PanelEditableTable()),
                  '/editableTable': (context) => RoutMaker(child: PanelEditableTable()),
                  '/simpleTable': (context) => RoutMaker(child: PanelSimpleTable()),
                  '/slider': (context) => RoutMaker(child: PanelSlider()),
                  '/image': (context) => RoutMaker(child: PanelImage()),
                  '/dialog': (context) => RoutMaker(child: PanelDialogBox()),
                  '/textSample': (context) => RoutMaker(child: PanelTextSample()),
                  '/buttonSample': (context) => RoutMaker(child: PanelTextSample()),

                },
              )),
    );
  }
}


