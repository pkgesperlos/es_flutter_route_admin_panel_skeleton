import 'package:es_flutter_component/es_button/es_information_button.dart';
import 'package:es_flutter_component/es_text/es_dotted_text.dart';
import 'package:flutter/material.dart';

import '../../images/panelConstants.dart';

class ContainerItems extends StatelessWidget {
  Widget widget;
  String title;
  String information;

  ContainerItems({Key? key,required this.widget,required this.title,required this.information}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding:
            const EdgeInsets.only(bottom: PanelConstants.paddingDimension),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EsDottedText(
                    data: title, size: 15, color: PanelConstants.itemColor),
                EsInformationButton(
                  dialogeText: information,
                ),
              ],
            ),
          ),
          SizedBox(
            height: PanelConstants.paddingDimension * 3,
          ),
          widget,
          SizedBox(
            height: PanelConstants.paddingDimension,
          ),
        ],
      ),
    );
  }

}
