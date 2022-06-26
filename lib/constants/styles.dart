

import 'package:flutter/material.dart';

import 'dims.dart';

class Styles{


  static const BoxShadow centerBoxShadow = BoxShadow(
      color: Colors.black12,
      blurRadius: 10,
      spreadRadius: 0
  );


  static const BoxShadow lowBoxShadow = BoxShadow(
      color: Colors.black12,
      blurRadius: 10,
      spreadRadius: -2,
      offset: Offset(0,4)
  );


  static const BoxShadow centerBoxShadowHighElevation = BoxShadow(
      color: Colors.black12,
      blurRadius: 6,
      spreadRadius: 3,
      offset: Offset(0,4)
  );

  static const BoxShadow topShadow = BoxShadow(
      color: Colors.black12,
      blurRadius: 2,
      spreadRadius: 2,
      offset: Offset(0,-1)
  );

  static const BoxShadow slidingUpBoxShadow = BoxShadow(
      color: Colors.black12,
      blurRadius: 10,
      spreadRadius: 10,
    offset: Offset(0,5)
  );


  static const BoxShadow centerBoxShadowCircle = BoxShadow(
      color: Colors.pink,
      blurRadius: 5,
      spreadRadius: -1
  );

  static const BoxShadow centerBoxShadowRectangle = BoxShadow(
      color: Colors.pink,
      blurRadius: 5,
      spreadRadius: -1
  );




  static BoxDecoration buttonShadow = BoxDecoration(
      borderRadius:
      BorderRadius.all(Radius.circular(Dims.commonBorderRadius)),
      boxShadow: [Styles.lowBoxShadow]);



  static BoxDecoration borderDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(Dims.commonBorderRadius)),
      border: Border.all(color: Colors.black38));

  static BoxDecoration borderDecorationLowColor = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(Dims.commonBorderRadius)),
      border: Border.all(color: dividerColor));


  static BoxDecoration shadowDecoration = BoxDecoration(
      borderRadius:
      BorderRadius.all(Radius.circular(Dims.commonBorderRadius)),
      boxShadow: [Styles.centerBoxShadow]);



  static BoxDecoration ellipticalDecoration = BoxDecoration(
      border: Border.all(
        color: Colors.black38,
        width: 1,
      ),
      borderRadius: BorderRadius.all(
          Radius.elliptical(50, 50)));

  static BoxDecoration ellipticalDecorationWithoutBorder = BoxDecoration(
      borderRadius: BorderRadius.all(
          Radius.elliptical(50, 50)));

  static BoxDecoration highShadowElevationDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(Dims.commonBorderRadius)),
    boxShadow: [
      Styles.centerBoxShadowHighElevation
    ],
  );

  static const textFieldContentPadding = EdgeInsets.only(left: 8,right: 8,top: 0,bottom: 0);
  static const containerButtonContentPadding = EdgeInsets.only(left: 2,right: 2,top: 12,bottom: 12);
  static const buttonContentPadding = EdgeInsets.only(left: 8,right: 8,top: 0,bottom: 0);

  static const Color dividerColor =Colors.black38;

  static const Color textColorOnButton = Color(0xFF5A5858);
  static const Color starsRateColor = Color(0xFFFF9900);
  static const Color secondaryIconColor = Color(0xFFA8A8A8);
  static const Color iconButtonsColor = Color(0xFFFF96C6);

}