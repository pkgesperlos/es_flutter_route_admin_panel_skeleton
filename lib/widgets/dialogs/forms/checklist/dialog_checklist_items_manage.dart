import 'dart:convert';

import 'package:checklist_admin_panel/constants/dims.dart';
import 'package:checklist_admin_panel/constants/styles.dart' as ThisStyle;
import 'package:checklist_admin_panel/models/checklist_model.dart';
import 'package:checklist_admin_panel/resources/converter.dart';
import 'package:checklist_admin_panel/resources/save.dart';
import 'package:checklist_admin_panel/widgets/es_button_streamer.dart';
import 'package:es_flutter_component/es_alert/es_alerts.dart';
import 'package:es_flutter_component/es_button/es_icon_button.dart';
import 'package:es_flutter_component/es_form/es_drop_down_button/es_simple_model_drop_down_form.dart';
import 'package:es_flutter_component/es_form/es_text_field/es_text_field.dart';
import 'package:es_flutter_component/es_form/es_text_field/es_text_field_form.dart';
import 'package:es_flutter_component/es_spacer/es_h_divider.dart';
import 'package:es_flutter_component/es_spacer/es_h_spacer.dart';
import 'package:es_flutter_component/es_spacer/es_v_spacer.dart';
import 'package:es_flutter_component/es_text/es_ordinary_text.dart';
import 'package:es_flutter_component/es_text/es_title.dart';
import 'package:es_flutter_component/resources/Constants/styles.dart';
import 'package:es_flutter_component/resources/constants/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../blocs/checklist_bloc.dart';
import '../../../../constants/strings.dart';
import '../../../../models/category_model.dart';
import '../../../simple_model_drop_down.dart';

class DialogChecklistItemsManage extends StatefulWidget {
  List<ChecklistItemsModel>? items;
  ChecklistModel? checklistModel;

  DialogChecklistItemsManage({this.checklistModel, this.items});

  @override
  State<StatefulWidget> createState() => DialogChecklistItemsManageState();
}

class DialogChecklistItemsManageState extends State<DialogChecklistItemsManage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  TextEditingController _ctrlTitle = TextEditingController();
  TextEditingController _ctrlDescription = TextEditingController();

  late List<ChecklistItemsModel> _items;

  bool _isOrderChanged = false;
  bool _isEditMode = false;

  String _updateChecklistItemOrder = "";
  String _updateChecklistItemFormType = "";

  String _checklistItemFormType = "";

  int _updateChecklistItemIndex = 0;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<SelectableTypeModel> _list = [];

  int _radioSelectedIndex = -1;

  ScrollController _scrollController = ScrollController();

  bool _showSelectable = false;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 550));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    controller.forward();

    _items = widget.items!;
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Dialog(
        insetPadding: ThisStyle.Styles.dialogMargin(context),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dims.h1BorderRadius(context)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              title("مدیریت موارد چک لیست"),
              EsHDivider(),
              Padding(
                padding: EdgeInsets.all(Dims.h1Padding(context)),
                child: dialogContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dialogContent() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          EsTextFieldForm(
            controller: _ctrlTitle,
            textInput: TextInputType.text,
            hint: "عنوان",
            validator: (String? value) {
              if (value!.isEmpty) return Validations.emptyTextField;
              return null;
            },
          ),
          EsTextField(
            controller: _ctrlDescription,
            hint: "توضیحات",
            maxLines: 3,
          ),
          EsVSpacer(),
          Row(
            children: [
              Expanded(
                child: SimpleModelDropDown(
                  value: _checklistItemFormType,
                  initialTitle: "نوع فرم را انتخاب کنید",
                  list: Converter.checklistItemsFormType,
                  onChange: (id) {
                    setState(() {
                      _checklistItemFormType = id;
                      _radioSelectedIndex = -1;
                      _list.clear();
                      if (id == "2") {
                        _showSelectable = false;
                      } else if (id == "0" || id == "1") {
                        _showSelectable = true;
                      }
                    });
                  },
                ),
              ),
              _showSelectable
                  ? EsIconButton(Icons.add, onTap: () {
                      setState(() {
                        _list.add(SelectableTypeModel.fromJson(
                            {"title": "", "selected": false}));
                      });
                    })
                  : Container(),
            ],
          ),
          EsVSpacer(),
          _showSelectable
              ? Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black38),
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: Scrollbar(
                      controller: _scrollController,
                      child: _checklistItemFormType == "0"
                          ? radioList()
                          : checkboxList()))
              : Container(),
          EsVSpacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _isOrderChanged
                  ? EsButtonStreamer(
                      stream: checklistBlocUpdateChecklistItems.actions,
                      onPressed: () {
                        updateItems();
                      },
                      child: EsIconButton(
                        Icons.upload,
                        clickable: false,
                      ),
                      preload: EsIconButton(
                        Icons.upload,
                        clickable: false,
                        isLoading: true,
                      ))
                  : Container(),
              EsHSpacer(),
              EsButtonStreamer(
                  formKey: _formKey,
                  stream: _isEditMode
                      ? checklistBlocUpdateChecklistItem.actions
                      : checklistBlocStoreChecklistItem.actions,
                  onPressed: () {
                    if (_isEditMode)
                      updateItem();
                    else
                      addItem();
                  },
                  child: EsIconButton(
                    _isEditMode ? Icons.edit : Icons.add,
                    clickable: false,
                  ),
                  preload: EsIconButton(
                    _isEditMode ? Icons.edit : Icons.add,
                    clickable: false,
                    isLoading: true,
                  )),
            ],
          ),
          EsVSpacer(),
          SingleChildScrollView(
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Dims.h1BorderRadius(context))),
                  border: Border.all(color: Colors.black38)),
              child: ReorderableListView(
                  children: <Widget>[
                    for (int index = 0; index < _items.length; index += 1)
                      ListTile(
                        dense: true,
                        key: Key('$index'),
                        title: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            EsButtonStreamer(
                                useConfidence: true,
                                stream: checklistBlocStoreChecklistItem.actions,
                                onPressed: () {
                                  deleteItem(index);
                                },
                                child: EsIconButton(
                                  Icons.delete,
                                  size: 10,
                                  clickable: false,
                                  fillColor: ColorAsset.danger,
                                ),
                                preload: EsIconButton(
                                  Icons.delete,
                                  size: 10,
                                  clickable: false,
                                  isLoading: true,
                                  fillColor: ColorAsset.danger,
                                )),
                            EsHSpacer(big: true),
                            EsIconButton(
                              Icons.remove_red_eye,
                              onTap: () {
                                showDescription(index);
                              },
                              size: 10,
                              fillColor: ColorAsset.primary,
                            ),
                            EsHSpacer(big: true),
                            EsIconButton(
                              Icons.edit,
                              onTap: () {
                                editMode(index);
                              },
                              size: 10,
                              fillColor: ColorAsset.primary,
                            ),
                            EsHSpacer(big: true),
                            EsOrdinaryText(_items[index].title +
                                " | " +
                                Converter.getChecklistItemsFormType(
                                    _items[index].form_type)),
                          ],
                        ),
                      ),
                  ],
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      _isOrderChanged = true;

                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      ChecklistItemsModel item = _items.removeAt(oldIndex);
                      _items.insert(newIndex, item);
                    });
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget title(String title) {
    return Padding(
      padding: EdgeInsets.all(Dims.h1Padding(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EsTitle(title, align: TextAlign.start),
          InkWell(
              child: Icon(Icons.close),
              onTap: () {
                Navigator.of(context).pop();
              })
        ],
      ),
    );
  }

  Widget checkboxList() {
    return ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: _list.length,
        itemBuilder: (context, index) {
          TextEditingController ctrl =
              TextEditingController(text: _list[index].title);

          return Container(
            margin: EdgeInsets.only(left: 8),
            padding: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black38),
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 70,
                  child: TextField(
                    style: TextStyle(fontSize: Dims.h4FontSize(context)),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 18),
                        hintText: "مورد ${index + 1}",
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(fontSize: Dims.h4FontSize(context))),
                    controller: ctrl,
                    onChanged: (value) {
                      _list[index].title = value;
                    },
                  ),
                ),
                Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    value: _list[index].selected,
                    onChanged: (bool? value) {
                      setState(() {
                        _list[index].selected = !_list[index].selected;
                      });
                    }),
                InkWell(
                    onTap: () {
                      setState(() {
                        _list.removeAt(index);
                      });
                      ;
                    },
                    child: Icon(
                      Icons.cancel_outlined,
                      color: ColorAsset.danger,
                    ))
              ],
            ),
          );
        });
  }

  Widget radioList() {
    return ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: _list.length,
        itemBuilder: (context, index) {
          TextEditingController ctrl =
              TextEditingController(text: _list[index].title);

          if (_radioSelectedIndex == index) {
            _list[index].selected = true;
          } else {
            _list[index].selected = false;
          }

          return Container(
            margin: EdgeInsets.only(left: 8),
            padding: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black38),
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 70,
                  child: TextField(
                    style: TextStyle(fontSize: Dims.h4FontSize(context)),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 18),
                        hintText: "مورد ${index + 1}",
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(fontSize: Dims.h4FontSize(context))),
                    controller: ctrl,
                    onChanged: (value) {
                      _list[index].title = value;
                    },
                  ),
                ),
                Radio(
                    value: index,
                    groupValue: _radioSelectedIndex,
                    onChanged: (int? value) {
                      setState(() {
                        _radioSelectedIndex = value!;
                      });
                    }),
                InkWell(
                    onTap: () {
                      setState(() {
                        _list.removeAt(index);
                      });
                      ;
                    },
                    child: Icon(
                      Icons.cancel_outlined,
                      color: ColorAsset.danger,
                    ))
              ],
            ),
          );
        });
  }

  void addItem() {
    checklistBlocStoreChecklistItem.fetchStoreChecklistItem(
        apiAddress: "checklist/store-checklist-item",
        body: {
          "id": widget.checklistModel!.id,
          "title": _ctrlTitle.text,
          "description": _ctrlDescription.text,
          "form_type_items": SelectableTypeModel.toJson(_list).toJsonItems,
          "form_type": _checklistItemFormType
        },
        fullResponse: (Response res) {
          if (res.statusCode == 200) {
            EsAlerts.success(context, Strings.successMessage);
            setState(() {
              _items.insert(_items.length,
                  ChecklistItemsModel.fromJson(json.decode(res.body)));
            });

            emptyField();
          }
        });
  }

  void updateItems() {
    checklistBlocUpdateChecklistItems.fetchUpdateChecklistItems(
        apiAddress: "checklist/update-checklist-items",
        body: {
          "id": widget.checklistModel!.id,
          "checklist_items": ChecklistItemsModelList.toJson(_items).listToJson,
        },
        fullResponse: (Response res) {
          if (res.statusCode == 200) {
            EsAlerts.success(context, Strings.successMessage);
            setState(() {
              _isOrderChanged = false;
            });
          }
        });
  }

  void updateItem() {
    checklistBlocUpdateChecklistItem.fetchUpdateChecklistItem(
        apiAddress: "checklist/update-checklist-item",
        body: {
          "id": widget.checklistModel!.id,
          "title": _ctrlTitle.text,
          "description": _ctrlDescription.text,
          "order": _updateChecklistItemOrder,
          "form_type": _checklistItemFormType,
          "form_type_items": SelectableTypeModel.toJson(_list).toJsonItems,
        },
        fullResponse: (Response res) {
          if (res.statusCode == 200) {
            EsAlerts.success(context, Strings.successMessage);
            setState(() {
              _isEditMode = false;
              _items.removeAt(_updateChecklistItemIndex);
              _items.insert(_updateChecklistItemIndex,
                  ChecklistItemsModel.fromJson(json.decode(res.body)));

              emptyField();
            });
          }
        });
  }

  void deleteItem(int index) {
    var body = ChecklistItemsModelList.toJson(_items).listToJson[index];
    body['id'] = widget.checklistModel!.id;

    checklistBlocStoreChecklistItem.fetchStoreChecklistItem(
        apiAddress: "checklist/delete-checklist-item",
        body: body,
        fullResponse: (Response res) {
          if (res.statusCode == 200) {
            EsAlerts.success(context, Strings.successMessage);
            setState(() {
              _items.removeAt(index);
            });
          }
        });
  }

  void showDescription(int index) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(Dims.h1Padding(context)),
                    child: EsOrdinaryText(_items[index].description),
                  )
                ],
              ),
            ));
  }

  void editMode(int index) {
    setState(() {
      _isEditMode = true;

      _ctrlTitle.text = _items[index].title;
      _ctrlDescription.text = _items[index].description;

      _updateChecklistItemOrder = _items[index].order;
      _checklistItemFormType = _items[index].form_type;
      _updateChecklistItemIndex = index;

      _list.clear();
      if (_items[index].form_type == "0" || _items[index].form_type == "1") {
        _showSelectable = true;

        for (int i = 0; i < _items[index].form_type_items!.list.length; i++) {
          if (_items[index].form_type_items!.list[i].selected) {
            _radioSelectedIndex = i;
          }
          _list.add(_items[index].form_type_items!.list[i]);
        }
      } else {
        _showSelectable = false;
        _radioSelectedIndex = -1;
      }
    });
  }

  void emptyField() {
    _ctrlTitle.text = "";
    _ctrlDescription.text = "";
    _checklistItemFormType = "";
    _list.clear();
    _radioSelectedIndex = -1;
    _showSelectable = false;
  }
}
