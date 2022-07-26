import 'dart:math';

import 'package:checklist_admin_panel/constants/enums.dart';
import 'package:checklist_admin_panel/widgets/es_button_streamer.dart';
import 'package:es_flutter_component/es_alert/es_alerts.dart';
import 'package:es_flutter_component/es_button/es_button.dart';
import 'package:es_flutter_component/es_button/es_icon_button.dart';
import 'package:es_flutter_component/es_form/es_text_field/es_search_text_field.dart';

import 'package:es_flutter_component/es_layer/es_card.dart';
import 'package:es_flutter_component/es_spacer/es_h_spacer.dart';
import 'package:es_flutter_component/es_spacer/es_v_spacer.dart';
import 'package:es_flutter_component/es_table/es_responsive_table.dart';
import 'package:es_flutter_component/resources/Constants/styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:http/http.dart';
import 'package:responsive_table/responsive_table.dart';

import '../../blocs/category_bloc.dart';
import '../../constants/dims.dart';
import '../../constants/strings.dart';
import '../../images/panelConstants.dart';
import '../../models/category_model.dart';
import '../../resources/save_need_api.dart';
import '../../widgets/dialogs/forms/category/dialog_category_store.dart';


class Category extends StatefulWidget {
  Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late List<DatatableHeader> _headers;

  late int _total;
  late int? _currentPerPage;
  List<bool>? _expanded;

  int _currentPage = 1;
  List<Map<String, dynamic>> _sourceOriginal = [];
  List<Map<String, dynamic>> _sourceFiltered = [];
  List<Map<String, dynamic>> _source = [];


  final TextEditingController _ctrlSearch = TextEditingController();

  bool _sortAscending = true;
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();


    getData(_currentPage);

    /// set headers
    _headers = [
      DatatableHeader(
          text: "ردیف",
          value: "id",
          show: true,
          sortable: true,
          flex: 1,
          textAlign: TextAlign.right),
      DatatableHeader(
          text: "عنوان",
          value: "title",
          show: true,
          flex: 3,
          sortable: true,
          editable: true,
          textAlign: TextAlign.right),
      DatatableHeader(
          text: "نوع دسته",
          value: "type",
          show: true,
          flex: 3,
          sortable: true,
          editable: true,
          textAlign: TextAlign.right),
      DatatableHeader(
          text: "زمان ثبت",
          value: "created_at",
          show: true,
          flex: 2,
          sortable: true,
          editable: true,
          textAlign: TextAlign.right),
      DatatableHeader(
          text: "عملیات",
          value: "received",
          flex: 2,
          show: true,
          sortable: false,
          sourceBuilder: (value, row) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    EsIconButton(
                      Icons.edit,
                      onTap: () {
                        showDialog(context: context, builder: (context) =>
                            DialogCategoryStore(
                              type: FormType.update,
                              model: row['data'],
                              onDonePress: () {
                                getData(_currentPage);
                              },
                            ));
                      },
                      fillColor: ColorAsset.primary,
                    ),
                    EsHSpacer(),


                    EsButtonStreamer(
                        useConfidence: true,
                        stream: categoryBlocDelete.actions,
                        onPressed: (){
                          deleteRecord(row['data']);
                        },
                        child: EsIconButton(
                          Icons.delete,
                          clickable: false,
                          fillColor: ColorAsset.danger,
                        ),
                        preload: EsIconButton(
                          Icons.delete,
                          clickable: false,
                          isLoading: true,
                          fillColor: ColorAsset.danger,
                        ))



                  ],
                )
              ],
            );
          },
          textAlign: TextAlign.left),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: PanelConstants.backGround,
        child: ListView(
          children: [
            EsCard(
              margin: EdgeInsets.all(Dims.h1Padding(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EsButton(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                DialogCategoryStore(
                                  onDonePress: () {
                                    setState(() {
                                      _currentPage = 1;
                                    });
                                    getData(_currentPage);
                                  },
                                ));
                      },
                      text: "افزودن",
                      icon: Icons.add),
                  EsVSpacer(),
                  EsSearchTextField(
                    hint: "جستجو در عنوان...",
                    controller: _ctrlSearch,
                    onChange: (String value) {
                      setState(() {
                        _currentPage = 1;
                      });

                      getData(_currentPage);
                    },
                  ),
                  EsVSpacer(),
                  StreamBuilder<CategoryPaginateModel?>(
                    stream: categoryBlocShow.actions,
                    builder: (context,
                        AsyncSnapshot<CategoryPaginateModel?> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.source.length <
                            int.parse(snapshot.data!.per_page)) {
                          _currentPerPage = snapshot.data!.source.length;
                        } else {
                          _currentPerPage = int.parse(snapshot.data!.per_page);
                        }

                        _expanded =
                            List.generate(
                                _currentPerPage ?? 0, (index) => false);

                        _sourceOriginal =
                        snapshot.data?.source as List<Map<String, dynamic>>;
                        _sourceFiltered = _sourceOriginal;
                        _total = int.parse(snapshot.data!.total);
                        _source = _sourceFiltered
                            .getRange(0, _currentPerPage ?? 0)
                            .toList();

                        return Container(
                          constraints: BoxConstraints(
                              minHeight: Dims.tableContainerMinHeight),
                          child: EsResponsiveTable(
                            headers: _headers,
                            source: _source,
                            lastPage: int.parse(snapshot.data?.last_page),
                            currentPage: _currentPage,
                            currentPerPage: _currentPerPage,
                            total: _total,
                            expanded: _expanded,
                            sortAscending: _sortAscending,
                            isLoading: _isLoading,
                            onPreviousPressed: (int page) {
                              setState(() {
                                _currentPage = page;
                              });
                              getData(_currentPage);
                            },
                            onNextPressed: (int page) {
                              setState(() {
                                _currentPage = page;
                              });
                              getData(_currentPage);
                            },
                            onPageSelected: (int page) {
                              setState(() {
                                _currentPage = page;
                              });
                              getData(_currentPage);
                            },
                          ),
                        );
                      }

                      return Container(
                        height: Dims.tableContainerMinHeight,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ));
  }

  void getData(int page) async {
    setState(() {
      _isLoading = true;
      _sourceOriginal.clear();
    });
    categoryBlocShow.fetchShow(
        apiAddress: 'category/show',
        body: {"search": _ctrlSearch.text, "type": "", "page": page.toString()},
        directResult: (res) {
          setState(() {
            _isLoading = false;
          });
        });
  }

  void deleteRecord(CategoryModel row) {
    categoryBlocDelete.fetchDelete(apiAddress: "category/delete", body: {
      "id": row.id
    }, fullResponse: (Response res) {
      if (res.statusCode == 200) {
        EsAlerts.success(context, Strings.successMessage);
        SaveNeedApi.category();
        getData(_currentPage);
      }
    });
  }
}
