import 'package:checklist_admin_panel/global/convertor/date_time_converter.dart';
import 'package:checklist_admin_panel/models/Checklist_model.dart';
import 'package:checklist_admin_panel/resources/converter.dart';
import 'dart:convert';

class ChecklistModel {
  var id, created_at, updated_at, category_id, title;
  ChecklistModel? category;
  ChecklistItemsModelList? checklist_items;

  ChecklistModel.fromJson(dynamic json) {
    id = json['_id'].toString();
    category_id = json['category_id'].toString();
    title = json['title'].toString();
    checklist_items = json['checklist_items'] == null
        ? null
        : ChecklistItemsModelList.fromJson(json['checklist_items']);
    created_at = DateTimeConverter.greToJalali(json['created_at'].toString(),
        hasTime: true, showTime: true);
    category = json['category'] == null
        ? null
        : ChecklistModel.fromJson(json['category']);

    updated_at = json['updated_at'].toString();
  }
}

class SelectableTypeModel {
  late String title;
  late bool selected;
  List toJsonItems = [];


  SelectableTypeModel.fromJson(dynamic json) {
    title = json['title'];
    selected = json['selected'];
  }

  SelectableTypeModel.toJson(List<SelectableTypeModel> data) {
    for (int i = 0; i < data.length; i++) {
      toJsonItems.add({
        "title": data[i].title,
        "selected": data[i].selected,
      });
    }
  }
}

class SelectableTypeModelList {
  List<SelectableTypeModel> list = [];

  SelectableTypeModelList.fromJson(res) {
    List data = res;

    for (int i = 0; i < data.length; i++) {
      list.add(SelectableTypeModel.fromJson(data[i]));
    }
  }
}




class ChecklistItemsModel {
  var title, description, order, form_type;
  SelectableTypeModelList? form_type_items;

  ChecklistItemsModel.fromJson(dynamic json) {
    title = json['title'].toString();
    description = json['description'].toString();
    order = json['order'].toString();
    form_type_items = json['form_type_items'] == null
        ? null
        : SelectableTypeModelList.fromJson(json['form_type_items']);
    form_type = json['form_type'].toString();
  }
}

class ChecklistPaginateModel {
  var current_page, from, last_page, per_page, to, total;
  ChecklistModelList? data;
  List<Map<String, dynamic>> source = [];

  ChecklistPaginateModel.fromJson(dynamic json) {
    current_page = json['current_page'].toString();
    from = json['from'].toString();
    last_page = json['last_page'].toString();
    per_page = json['per_page'].toString();
    to = json['to'].toString();
    total = json['total'].toString();
    data =
        json['data'] == null ? null : ChecklistModelList.fromJson(json['data']);
    source = _generateData(
        per_page, current_page, ChecklistModelList.fromJson(json['data']).list);
  }
}

List<Map<String, dynamic>> _generateData(
    String perPage, String currentPage, List<ChecklistModel> source) {
  List<Map<String, dynamic>> temps = [];
  var i = (int.parse(currentPage) - 1) * int.parse(perPage);
  for (ChecklistModel data in source) {
    i++;
    temps.add({
      "id": i,
      "data": data,
      "created_at": data.created_at.toString(),
      "title": data.title.toString(),
      "category": data.category!.title,
      "received": [i]
    });
  }
  return temps;
}

class ChecklistModelList {
  List<ChecklistModel> list = [];

  ChecklistModelList.fromJson(res) {
    List data = res;

    for (int i = 0; i < data.length; i++) {
      list.add(ChecklistModel.fromJson(data[i]));
    }
  }
}

class ChecklistItemsModelList {
  List<ChecklistItemsModel> list = [];
  List<Map<String, dynamic>> listToJson = [];

  ChecklistItemsModelList.fromJson(res) {
    List data = res;

    for (int i = 0; i < data.length; i++) {
      list.add(ChecklistItemsModel.fromJson(data[i]));
    }
  }

  ChecklistItemsModelList.toJson(List<ChecklistItemsModel> res) {
    for (int i = 0; i < res.length; i++) {
      listToJson.add({
        "title": res[i].title,
        "description": res[i].description,
        "order": res[i].order,
        "form_type": res[i].form_type
      });
    }
  }
}
