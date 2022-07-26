import 'package:checklist_admin_panel/global/convertor/date_time_converter.dart';
import 'package:checklist_admin_panel/resources/converter.dart';

class CategoryModel {
  var id, created_at, updated_at, type, title;

  CategoryModel.fromJson(dynamic json) {
    id = json['_id'].toString();
    type = json['type'].toString();
    title = json['title'].toString();
    created_at = DateTimeConverter.greToJalali(json['created_at'].toString(),hasTime: true,showTime: true);
    updated_at = json['updated_at'].toString();
  }
}

class CategoryPaginateModel {
  var current_page, from, last_page, per_page, to, total;
  CategoryModelList? data;
  List<Map<String, dynamic>> source = [];

  CategoryPaginateModel.fromJson(dynamic json) {
    current_page = json['current_page'].toString();
    from = json['from'].toString();
    last_page = json['last_page'].toString();
    per_page = json['per_page'].toString();
    to = json['to'].toString();
    total = json['total'].toString();
    data = json['data'] == null ? null : CategoryModelList.fromJson(json['data']);
    source = _generateData(per_page,current_page,CategoryModelList.fromJson(json['data']).list);

  }
}


List<Map<String, dynamic>> _generateData(String perPage,String currentPage,List<CategoryModel> source) {
  List<Map<String, dynamic>> temps = [];
  var i = (int.parse(currentPage)-1)*int.parse(perPage);
  for (CategoryModel data in source) {
    i++;
    temps.add({
      "id": i,
      "data":data,
      "created_at": data.created_at.toString(),
      "title": data.title.toString(),
      "type": Converter.getCategoryTypeTitle(data.type.toString()),
      "received": [i]
    });

  }
  return temps;
}


class CategoryModelList {
  List<CategoryModel> list = [];
  List<Map> listMap = [];
  CategoryModelList.fromJson(res) {
    List data = res;

    for (int i = 0; i < data.length; i++) {
      list.add(CategoryModel.fromJson(data[i]));
      listMap.add(data[i]);
    }

  }
}
