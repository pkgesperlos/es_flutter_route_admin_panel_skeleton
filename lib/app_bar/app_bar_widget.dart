import 'package:es_flutter_component/es_form/es_drop_down_button.dart';
import 'package:es_flutter_component/es_image/es_avatar_image.dart';
import 'package:es_route_admin_panel_skeleton/language_change_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../images/panelConstants.dart';
import '../images/responsive_layout.dart';

// List<String> _buttonNames = ["Overview", "Revenue", "Sales", "Control"];
int _currentSelectedButton = 0;

class AppBarWidget extends StatefulWidget {
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //set the color of app bar.
        color: PanelConstants.appbarBackgroundColor,
        boxShadow: [BoxShadow(color: PanelConstants.appbarShadowColor,blurRadius: 5,spreadRadius:5)],
        border:Border(bottom: BorderSide(color: PanelConstants.itemColor,width: 3))
      ),
      child: Row(
        children: [
          //check for drawer icon in non computer devices by ResponsiveLayot
          if (ResponsiveLayot.isComputer(context))
            Container(
              // margin: EdgeInsets.all(PanelConstants.paddingDimension),
              // height: double.infinity,
              // decoration: BoxDecoration(boxShadow: [
              //   BoxShadow(
              //       color: Colors.black45,
              //       offset: Offset(0, 0),
              //       spreadRadius: 1,
              //       blurRadius: 10)
              // ], shape: BoxShape.circle),
              // child: CircleAvatar(
              //   backgroundColor: Colors.pink,
              //   radius: 30,
              //   // child: Image.asset(
              //   //   "assets/images/imgbaby.JPG",
              //   //   fit: BoxFit.fitWidth,
              //   // ),
              //   child: FlutterLogo(),
              // ),
            )
          else
            IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                iconSize: 30,
                color: PanelConstants.appbarIconColor,
                icon: Icon(Icons.menu)),
          SizedBox(
            width: PanelConstants.paddingDimension,
          ),
          Spacer(),
          // if (ResponsiveLayot.isComputer(context))
          //   ...List.generate(
          //       _buttonNames.length,
          //       (index) => TextButton(
          //           onPressed: () {
          //             setState(() {
          //               _currentSelectedButton = index;
          //             });
          //           },
          //           child: Padding(
          //             padding: EdgeInsets.all(PanelConstants.paddingDimension),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Text(
          //                   _buttonNames[index],
          //                   style: TextStyle(
          //                       color: _currentSelectedButton == index
          //                           ? Colors.white
          //                           : Colors.white70),
          //                 ),
          //                 Container(
          //                   margin: EdgeInsets.all(PanelConstants.paddingDimension / 2),
          //                   width: 60,
          //                   height: 2,
          //                   decoration: BoxDecoration(
          //                     gradient: _currentSelectedButton == index
          //                         ? LinearGradient(colors: [
          //                             PanelConstants.redDark,
          //                             PanelConstants.orangeDark
          //                           ])
          //                         : null,
          //                   ),
          //                 )
          //               ],
          //             ),
          //           )))
          // else
          //   Padding(
          //     padding: EdgeInsets.all(PanelConstants.paddingDimension * 2),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Text(
          //           _buttonNames[_currentSelectedButton],
          //           style: TextStyle(color: Colors.white),
          //         ),
          //         Container(
          //           margin: EdgeInsets.all(PanelConstants.paddingDimension / 2),
          //           width: 60,
          //           height: 2,
          //           decoration: BoxDecoration(
          //               gradient: LinearGradient(
          //                   colors: [PanelConstants.redDark, PanelConstants.orangeDark])),
          //         )
          //       ],
          //     ),
          //   ),
          Spacer(),
          //Drop down button for selecting languages
          EsDropDownButton(
            items: ["English", "Persian"],
            onTapItems: [
              () {
                context.read<LanguageChangeProvider>().changLocale("en");
              },
              () {
                context.read<LanguageChangeProvider>().changLocale("fa");
              }
            ],
          ),
          // ElevatedButton(onPressed: (){
          //   context.read<LanguageChangeProvider>().changLocale("en");
          // }, child: Text('English')),
          // ElevatedButton(onPressed: (){
          //   context.read<LanguageChangeProvider>().changLocale("fa");
          // }, child: Text('فارسی')),
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30,
            color: PanelConstants.appbarIconColor,
            onPressed: () {},
          ),
          // Spacer(),
          // notification,
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_none_outlined),
                iconSize: 30,
                color: PanelConstants.appbarIconColor,
                onPressed: () {},
              ),
              Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    backgroundColor: Colors.pink,
                    radius: 8,
                    // child: Image.asset(
                    //   "assets/images/imgbaby.JPG",
                    //   fit: BoxFit.fitWidth,
                    // ),
                    child: Text(
                      "3",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ))
            ],
          ),
          //set profile image for non phone devices
          if (!ResponsiveLayot.isPhone(context))
            Container(
              margin: EdgeInsets.all(PanelConstants.paddingDimension),
              height: double.infinity,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0, 0),
                  spreadRadius: 1,
                  blurRadius: 10,
                )
              ], shape: BoxShape.circle),
              child: AspectRatio(aspectRatio: 1,child: EsAvatarImage(path: "assets/images/img1.jpg"),)

            )
        ],
      ),
    );
  }
}
