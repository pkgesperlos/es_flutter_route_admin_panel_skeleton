import 'dart:convert';

import 'package:checklist_admin_panel/blocs/checklist_media_bloc.dart';
import 'package:checklist_admin_panel/blocs/media_bloc.dart';
import 'package:checklist_admin_panel/constants/dims.dart';
import 'package:checklist_admin_panel/constants/styles.dart' as ThisStyle;
import 'package:checklist_admin_panel/models/checklist_model.dart';
import 'package:checklist_admin_panel/resources/save.dart';
import 'package:checklist_admin_panel/widgets/es_button_streamer.dart';
import 'package:es_flutter_component/es_alert/es_alerts.dart';
import 'package:es_flutter_component/es_button/es_icon_button.dart';
import 'package:es_flutter_component/es_form/es_text_field/es_text_field.dart';
import 'package:es_flutter_component/es_spacer/es_h_divider.dart';
import 'package:es_flutter_component/es_spacer/es_h_spacer.dart';
import 'package:es_flutter_component/es_spacer/es_v_spacer.dart';
import 'package:es_flutter_component/es_text/es_ordinary_text.dart';
import 'package:es_flutter_component/es_text/es_title.dart';
import 'package:es_flutter_component/resources/Constants/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../blocs/checklist_bloc.dart';
import '../../../../constants/strings.dart';
import '../../../../models/category_model.dart';
import '../../../../models/checklist_media_model.dart';
import '../../../../models/media_model.dart';
import '../../../dialog_media_picker.dart';

class DialogChecklistMediaManage extends StatefulWidget {

  ChecklistModel? checklistModel;

  DialogChecklistMediaManage({this.checklistModel});

  @override
  State<StatefulWidget> createState() => DialogChecklistMediaManageState();
}

class DialogChecklistMediaManageState extends State<DialogChecklistMediaManage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  TextEditingController _ctrlTitle = TextEditingController();
  TextEditingController _ctrlDescription = TextEditingController();
  TextEditingController _ctrlMediaTextEditing = TextEditingController();

  final MediaController _ctrlMedia = MediaController();

  late List<ChecklistMediaModel> _items;


  bool _isEditMode = false;


  int _updateChecklistIndex = 0;



  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 550));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    controller.forward();

    getItems();

    //_items = widget.items!;
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
              title("مدیریت رسانه های چک لیست"),
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
    return Column(
      crossAxisAlignment:CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        EsTextField(
          controller: _ctrlTitle,
          hint: "عنوان",
        ),
        EsTextField(
          controller: _ctrlDescription,
          hint: "توضیحات",
          maxLines: 3,
        ),
        EsVSpacer(),
        TextField(
          controller: _ctrlMediaTextEditing,
          decoration: InputDecoration(
            label: EsOrdinaryText("انتخاب فایل"),
            prefix: Icon(Icons.perm_media)
          ),
          onTap: (){
            showDialog(context: context,builder: (context)=>DialogMediaPicker(
              controller: _ctrlMedia,
              onSelect: (MediaModel model){
                _ctrlMediaTextEditing.text = model.file_name;
              },
            ));
          },
        ),
        EsVSpacer(),


        EsButtonStreamer(
            stream: checklistMediaBlocStore.actions,
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



        EsVSpacer(big: true),
        SingleChildScrollView(
          child: Container(
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(Dims.h1BorderRadius(context))),
                border: Border.all(color: Colors.black38)),
            child: StreamBuilder<ChecklistMediaModelList?>(
              stream: checklistMediaBlocShow.actions,
              builder: (context,AsyncSnapshot<ChecklistMediaModelList?> snapshot){

                if(snapshot.hasData){

                  _items = snapshot.data!.list;

                  return ListView.builder(itemCount:_items.length,itemBuilder: (context,index){
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
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
                              EsOrdinaryText(_items[index].title),
                            ],
                          ),
                          EsOrdinaryText(_items[index].media == null? "":_items[index].media!.file_name)
                        ],
                      ),
                    );
                  });
                }
                return Center(child: CircularProgressIndicator(),);
              },
            ),
          ),
        )
      ],
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



  void getItems() {
    checklistMediaBlocShow.fetchShow(
        apiAddress: "checklist-media/show",
        body: {
          "search":"",
          "page":"",
          "checklist_id":widget.checklistModel!.id
        });
  }

  void addItem() {
    checklistMediaBlocStore.fetchStore(
        apiAddress: "checklist-media/store",
        body: {
          "title": _ctrlTitle.text,
          "description": _ctrlDescription.text,
          "media_id": _ctrlMedia.mediaModel!.id,
          "checklist_id": widget.checklistModel!.id,
        },
        fullResponse: (Response res) {
          if (res.statusCode == 200) {
            EsAlerts.success(context, Strings.successMessage);
            _ctrlTitle.text = "";
            _ctrlDescription.text = "";
            _ctrlMediaTextEditing.text = "";
            getItems();

          }
        });
  }

  void deleteItem(int index) {
    checklistMediaBlocDelete.fetchDelete(
        apiAddress: "checklist-media/delete",
        body: {
          "id": _items[index].id,
        },
        fullResponse: (Response res) {
          if (res.statusCode == 200) {
            EsAlerts.success(context, Strings.successMessage);
            getItems();

          }
        });
  }

  void updateItem() {
    checklistMediaBlocStore.fetchStore(
        apiAddress: "checklist-media/store",
        body: {
          "id": _items[_updateChecklistIndex].id,
          "title": _ctrlTitle.text,
          "description": _ctrlDescription.text,
          "media_id": _ctrlMedia.mediaModel!.id,
          "checklist_id": widget.checklistModel!.id,
        },
        fullResponse: (Response res) {
          if (res.statusCode == 200) {
            EsAlerts.success(context, Strings.successMessage);
            setState(() {
              _isEditMode = false;

              _ctrlTitle.text = "";
              _ctrlDescription.text = "";
              _ctrlMediaTextEditing.text = "";

              getItems();
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
      _ctrlMediaTextEditing.text = _items[index].media==null?"":_items[index].media!.file_name;
      _ctrlMedia.mediaModel = _items[index].media;

      _updateChecklistIndex = index;
    });
  }
}
