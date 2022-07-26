import 'package:es_flutter_component/es_text/es_ordinary_text.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client, MultipartRequest, Response;

import '../constants/enums.dart';
import '../constants/strings.dart';
import '../models/Checklist_model.dart';
import '../resources/save.dart';
import '../resources/status_checker.dart';

class Test2 extends StatefulWidget {
  const Test2({Key? key}) : super(key: key);

  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  String data = """  {
            "_id": "62cfedf076014b33190af412",
            "user_id": "62b9647f6d426aecec040dd4",
            "title": "خرید  آپارتمان 1",
            "checklist_id": "62ccffd94241f0b1120bfc42",
            "checklist_items": [
                {
                    "title": "a",
                    "description": null,
                    "form_type": "0",
                    "order": "1"
                },
                {
                    "title": "sd",
                    "description": null,
                    "form_type_items": [
                        {
                            "title": "aaa",
                            "selected": true
                        },
                        {
                            "title": "sd",
                            "selected": true
                        }
                    ],
                    "form_type": "1",
                    "order": "2"
                },
                {
                    "title": "fd",
                    "description": "null",
                    "form_type_items": [
                        {
                            "title": "d",
                            "selected": true
                        }
                    ],
                    "form_type": "0",
                    "order": "3"
                },
                {
                    "title": "fdd",
                    "description": null,
                    "form_type_items": [],
                    "form_type": "2",
                    "order": "4"
                },
                {
                    "title": "kjkljkjk",
                    "description": "null",
                    "form_type_items": [
                        {
                            "title": "klklklkl",
                            "selected": false
                        },
                        {
                            "title": "kllkl",
                            "selected": false
                        },
                        {
                            "title": "jkjkjkjk",
                            "selected": false
                        },
                        {
                            "title": "jkjkjkjk",
                            "selected": false
                        }
                    ],
                    "form_type": "0",
                    "order": "5"
                }
            ],
            "updated_at": "2022-07-14T10:20:32.028000Z",
            "created_at": "2022-07-14T10:20:32.028000Z",
            "checklist": {
                "_id": "62ccffd94241f0b1120bfc42",
                "category_id": "62cba464997ee24d5a0bb5b2",
                "title": "خرید آپارتمان مسکونی",
                "checklist_items": [
                    {
                        "title": "a",
                        "description": null,
                        "form_type": "0",
                        "order": "1"
                    },
                    {
                        "title": "sd",
                        "description": null,
                        "form_type_items": [
                            {
                                "title": "aaa",
                                "selected": true
                            },
                            {
                                "title": "sd",
                                "selected": true
                            }
                        ],
                        "form_type": "1",
                        "order": "2"
                    },
                    {
                        "title": "fd",
                        "description": "null",
                        "form_type_items": [
                            {
                                "title": "d",
                                "selected": true
                            }
                        ],
                        "form_type": "0",
                        "order": "3"
                    },
                    {
                        "title": "fdd",
                        "description": null,
                        "form_type_items": [],
                        "form_type": "2",
                        "order": "4"
                    },
                    {
                        "title": "kjkljkjk",
                        "description": "null",
                        "form_type_items": [
                            {
                                "title": "klklklkl",
                                "selected": false
                            },
                            {
                                "title": "kllkl",
                                "selected": false
                            },
                            {
                                "title": "jkjkjkjk",
                                "selected": false
                            },
                            {
                                "title": "jkjkjkjk",
                                "selected": false
                            }
                        ],
                        "form_type": "0",
                        "order": "5"
                    }
                ],
                "updated_at": "2022-07-13T19:54:38.802000Z",
                "created_at": "2022-07-12T05:00:09.659000Z"
            }
        }""";

  List<ChecklistItemsModel> checklistItems = [];
  late ChecklistModel mainData;

  List<int> groupValue = [];
  List<List<int>> value = [];
  List<CheckBoxController> controllers = [];

  bool showAddButton = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mainData = ChecklistModel.fromJson(json.decode(data));
    checklistItems = mainData.checklist_items!.list;

    for(int i = 0; i<mainData.checklist_items!.list.length ; i++){
      controllers.add(CheckBoxController());
    }

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      floatingActionButton:showAddButton? FloatingActionButton(
        onPressed: (){

        },
      ):Container(),
      body: ListView.builder(
          itemCount: mainData.checklist_items!.list.length,
          itemBuilder: (context, index) {


            return ListItem(index,controllers[index],(){

              int trueCount = 0;
              for(int i = 0; i<controllers.length ; i++){
                print(controllers[i].data['state']);
                if(controllers[i].data['state'] == true){
                  trueCount++;
                }
              }
              setState(() {
                if(trueCount>=2){
                  showAddButton = true;
                }else{
                  showAddButton = false;
                }
              });



            });
          }),
    );
  }
}

class ListItem extends StatefulWidget {
  int index;
  CheckBoxController controller;
  Function onItemClick;
  ListItem(this.index,this.controller,this.onItemClick);

  @override
  State<StatefulWidget> createState() {
    return ListItemState();
  }
}

class ListItemState extends State<ListItem> {
  bool isChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.data = {
      'index':widget.index,
      'state': false
    };
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Row(
        children: [
          Text("item" + widget.index.toString()),
          Checkbox(value: isChecked, onChanged: (value) {
            setState(() {
              isChecked = value!;
              widget.controller.data = {
                'index':widget.index,
                'state': value
              };

              widget.onItemClick();
            });
          })
        ],
      ),
    );
  }
}


class CheckBoxController{

  Map data = {};

}