import 'package:checklist_admin_panel/resources/save.dart';

import '../blocs/category_bloc.dart';

class SaveNeedApi {
  static category() {
    categoryBlocShow.fetchShow(
        apiAddress: 'category/show',
        body: {},
        directResult: (res) {

          Save().setChecklistCategory(res);
        });
  }
}
