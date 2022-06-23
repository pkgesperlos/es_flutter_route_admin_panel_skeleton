import 'package:flutter/cupertino.dart';

class ResponsiveLayot extends StatelessWidget {
  final Widget tiny;
  final Widget phone;
  final Widget tablet;
  final Widget largTablet;
  final Widget computer;

  ResponsiveLayot(
      {required this.tiny, required this.phone, required this.tablet, required this.largTablet, required this.computer,});

  static final int tinyHightLimit = 100;
  static final int tinyLimit = 270;
  static final int phoneLimit = 550;
  static final int tabletLimit = 800;
  static final int largTabletLimit = 1100;
  static bool isTinyHightLimit(BuildContext context)=>
      MediaQuery.of(context).size.height<tinyHightLimit;
  static bool isTinyLimit(BuildContext context)=>
      MediaQuery.of(context).size.width<tinyLimit;
  static bool isPhone(BuildContext context)=>
      MediaQuery.of(context).size.width<phoneLimit &&
          MediaQuery.of(context).size.width>=tinyLimit;
  static bool isTablet(BuildContext context)=>
      MediaQuery.of(context).size.width<tabletLimit &&
          MediaQuery.of(context).size.width>=phoneLimit;
  static bool isLargeTablet(BuildContext context)=>
      MediaQuery.of(context).size.width<largTabletLimit &&
          MediaQuery.of(context).size.width>=tabletLimit;
  static bool isComputer(BuildContext context)=>
      MediaQuery.of(context).size.width>=largTabletLimit;


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if(constraints.maxWidth < tinyLimit||constraints.maxHeight<tinyHightLimit){
            return tiny;
          }
          if(constraints.maxWidth < phoneLimit){
            return phone;
          }
          if(constraints.maxWidth < tabletLimit){
            return tablet;
          }
          if(constraints.maxWidth < largTabletLimit){
            return largTablet;
          }else{
            return computer;
          }

        });
  }

}