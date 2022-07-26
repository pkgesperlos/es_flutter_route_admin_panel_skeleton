import 'package:flutter/material.dart';

import 'dims.dart';

class Styles {


  static const BoxShadow centerBoxShadow = BoxShadow(
      color: Colors.black12,
      blurRadius: 10,
      spreadRadius: 0
  );


  static const BoxShadow lowBoxShadow = BoxShadow(
      color: Colors.black12,
      blurRadius: 10,
      spreadRadius: -2,
      offset: Offset(0, 4)
  );


  static const BoxShadow centerBoxShadowHighElevation = BoxShadow(
      color: Colors.black12,
      blurRadius: 6,
      spreadRadius: 3,
      offset: Offset(0, 4)
  );

  static const BoxShadow topShadow = BoxShadow(
      color: Colors.black12,
      blurRadius: 2,
      spreadRadius: 2,
      offset: Offset(0, -1)
  );

  static EdgeInsets dialogMargin(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/5);


  static const BoxShadow slidingUpBoxShadow = BoxShadow(
      color: Colors.black12,
      blurRadius: 10,
      spreadRadius: 10,
      offset: Offset(0, 5)
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


}