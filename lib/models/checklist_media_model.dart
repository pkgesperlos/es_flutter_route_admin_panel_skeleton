import 'package:checklist_admin_panel/global/convertor/date_time_converter.dart';
import 'package:checklist_admin_panel/models/Checklist_model.dart';
import 'package:checklist_admin_panel/resources/converter.dart';

import 'media_model.dart';

class ChecklistMediaModel {
  var id, created_at, updated_at, media_id, checklist_id, title, description;
  MediaModel? media;
  ChecklistModel? checklist;

  ChecklistMediaModel.fromJson(dynamic json) {
    id = json['_id'].toString();
    description = json['description'].toString();
    title = json['title'].toString();
    checklist_id = json['checklist_id'].toString();
    media_id = json['media_id'].toString();
    media = json['media'] == null ? null : MediaModel.fromJson(json['media']);
    checklist = json['checklist'] == null
        ? null
        : ChecklistModel.fromJson(json['checklist']);
    created_at = DateTimeConverter.greToJalali(json['created_at'].toString(),
        hasTime: true, showTime: true);
    updated_at = json['updated_at'].toString();
  }
}

class ChecklistMediaModelList {
  List<ChecklistMediaModel> list = [];

  ChecklistMediaModelList.fromJson(res) {
    List data = res;

    for (int i = 0; i < data.length; i++) {
      list.add(ChecklistMediaModel.fromJson(data[i]));
    }
  }
}
