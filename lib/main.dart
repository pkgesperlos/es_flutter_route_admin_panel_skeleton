import 'package:checklist_admin_panel/screens/dashboard.dart';
import 'package:checklist_admin_panel/screens/login.dart';
import 'package:checklist_admin_panel/language_change_provider.dart';
import 'package:checklist_admin_panel/images/route_maker.dart';
import 'package:checklist_admin_panel/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'drawer/panelItems/Panel_tabel/panel_editable_table.dart';
import 'drawer/panelItems/panel_form.dart';
import 'drawer/panelItems/Panel_tabel/panel_simple_table.dart';

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
          builder: (context) => MaterialApp(


            theme: ThemeData(
              fontFamily: 'yekan'
            ),
            locale: Locale("fa"),
                // locale:
                // Provider
                //     .of<LanguageChangeProvider>(context, listen: true)
                //     .currentLocale,
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
                  '/': (context) => Splash(),
                  '/login': (context) => Login(),
                  '/dashboard': (context) => RoutMaker(
                        child: Dashboard(),
                      ),
                  '/form': (context) => RoutMaker(
                        child: PanelForm(),
                      ),
                  '/responsiveTable': (context) =>
                      RoutMaker(child: PanelEditableTable()),
                  '/editableTable': (context) =>
                      RoutMaker(child: PanelEditableTable()),
                  '/simpleTable': (context) =>
                      RoutMaker(child: PanelSimpleTable()),
                },
              )),
    );
  }
}
