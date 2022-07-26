import 'package:checklist_admin_panel/images/route_maker.dart';
import 'package:checklist_admin_panel/language_change_provider.dart';
import 'package:checklist_admin_panel/screens/login.dart';
import 'package:checklist_admin_panel/screens/menu_pages/category.dart';
import 'package:checklist_admin_panel/screens/menu_pages/checklist.dart';
import 'package:checklist_admin_panel/screens/menu_pages/dashboard.dart';
import 'package:checklist_admin_panel/screens/menu_pages/media.dart';
import 'package:checklist_admin_panel/screens/splash.dart';
import 'package:checklist_admin_panel/test_widgets/test.dart';
import 'package:checklist_admin_panel/test_widgets/test2.dart';
import 'package:checklist_admin_panel/widgets/dialog_media_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'drawer/panelItems/Panel_tabel/panel_editable_table.dart';
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
            scrollBehavior: MyCustomScrollBehavior(),

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
                  /*'/': (context) => Scaffold(
                    body: ElevatedButton(
                      child: Text("Sdsd"),
                      onPressed: (){
                        showDialog(context: context,builder: (context)=>DialogMediaPicker());
                      },
                    ),
                  ),*/
                  '/login': (context) => Login(),
                  '/dashboard': (context) => RoutMaker(
                        child: Dashboard(),
                      ),
                  '/media': (context) => RoutMaker(
                        child: Media(),
                      ),
                  '/category': (context) => RoutMaker(
                    child: Category(),
                  ),
                  '/checklist': (context) => RoutMaker(
                    child: Checklist(),
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






class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}


