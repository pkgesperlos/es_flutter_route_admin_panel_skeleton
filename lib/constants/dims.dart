import 'package:es_flutter_component/resources/responsive_layout.dart';
import 'package:flutter/material.dart';

class Dims {
    static const double indicatorImageAspectRatio = 2 / 1;
    static const double cardAspectRatio = 2 / 1;
    static const double boxBorderRadios = 15;

    static double tableContainerMinHeight = 800;


    static double drawerWidth(BuildContext context) {
        return responsiveDeviceConstructor(context, 0.6);
    }

    static double h0Padding(BuildContext context) {
        return responsiveDeviceConstructor(context, 0.10);
    }

    static double h1Padding(BuildContext context) {
        return responsiveDeviceConstructor(context, 0.04);
    }

    static double h2Padding(BuildContext context) {
        return responsiveDeviceConstructor(context, 0.02);
    }

    static double h3Padding(BuildContext context) {
        return responsiveDeviceConstructor(context, 0.01);
    }



    static double bordertickness(BuildContext context) {
        return responsiveDeviceConstructor(context, 0.015);
    }

    static double h1BorderRadius(BuildContext context) {
        return responsiveDeviceConstructor(context, 0.04);
    }

    static double h2BorderRadius(BuildContext context) {
        return responsiveDeviceConstructor(context, 0.02);
    }

    static double h3BorderRadius(BuildContext context) {
        return responsiveDeviceConstructor(context, 0.01);
    }

/*
  static double h1IconSize(BuildContext context) {
    return responsiveDeviceConstructor(context, 0.4);
  }

  static double h2IconSize(BuildContext context) {
    return responsiveDeviceConstructor(context, 0.2);
  }

  static double h3IconSize(BuildContext context) {
    return responsiveDeviceConstructor(context, 0.06);
  }

  static double h4IconSize(BuildContext context) {
    return responsiveDeviceConstructor(context, 0.02);
  }*/

    static double h1FontSize(BuildContext context) {
        return responsiveDeviceConstructor(context, 0.075);
    }

    static double h2FontSize(BuildContext context) {
        return responsiveDeviceConstructor(context, 0.065);
    }

    static double h3FontSize(BuildContext context) {
        return responsiveDeviceConstructor(context, 0.05);
    }

    static double h4FontSize(BuildContext context) {
        return responsiveDeviceConstructor(context, 0.04);
    }

    static double h5FontSize(BuildContext context) {
        return responsiveDeviceConstructor(context, 0.025);
    }

    static double h6FontSize(BuildContext context) {
        return responsiveDeviceConstructor(context, 0.02);
    }

    static Size displaySize(BuildContext context) {
        //debugPrint('Size = ' + MediaQuery.of(context).size.toString());
        return MediaQuery.of(context).size;
    }

    static double displayHeight(BuildContext context) {
        //debugPrint('Height = ' + displaySize(context).height.toString());
        return displaySize(context).height;
    }

    static double responsiveDeviceConstructor(
        BuildContext context, double sizeFactor) {
        if (ResponsiveLayot.isTinyLimit(context) ) {
            // print("-2");
            return displaySize(context).width * sizeFactor * 0.62;
        } else if (ResponsiveLayot.isTinyHightLimit(context)) {
            // print("-1");
            return displaySize(context).width * sizeFactor * 0.6;
        } else if (ResponsiveLayot.isPhone(context)) {
            // print("1");
            return displaySize(context).width * sizeFactor * 0.58;
        } else if (ResponsiveLayot.isLargePhone(context)) {
            // print("2");
            return displaySize(context).width * sizeFactor * 0.58;
        } else if (ResponsiveLayot.isTablet(context)) {
            // print("3");
            return displaySize(context).width * sizeFactor * 0.3;
        } else if (ResponsiveLayot.isLargeTablet(context)) {
            // print("4");
            return displaySize(context).width * sizeFactor * 0.3;
        } else if (ResponsiveLayot.isComputer(context)) {
            // print("5");
            return displaySize(context).width * sizeFactor * 0.28;
        }else if (ResponsiveLayot.isLargeComputer(context)) {
            // print("6");
            return displaySize(context).width * sizeFactor * 0.16;
        } else {
            // print("7");
            return displaySize(context).width * sizeFactor * 0.1;
        }
    }

// static double responsivePlathformConstructor(
//     BuildContext context, double sizeFactor) {
//   if (Platform.isAndroid || Platform.isIOS) {
//     return displaySize(context).width * sizeFactor;
//   } else if (kIsWeb ||
//       Platform.isLinux ||
//       Platform.isWindows ||
//       Platform.isMacOS) {
//     return displaySize(context).width * sizeFactor * 0.7;
//   } else {
//     return displaySize(context).width * sizeFactor * 0.7;
//   }
// }
}