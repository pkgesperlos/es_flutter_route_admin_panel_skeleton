import 'dart:math';

import 'package:checklist_admin_panel/blocs/media_bloc.dart';
import 'package:checklist_admin_panel/models/media_model.dart';
import 'package:checklist_admin_panel/widgets/dialogs/forms/media/dialog_media_store.dart';
import 'package:checklist_admin_panel/widgets/es_button_streamer.dart';
import 'package:es_flutter_component/es_alert/es_alerts.dart';
import 'package:es_flutter_component/es_button/es_button.dart';
import 'package:es_flutter_component/es_button/es_icon_button.dart';
import 'package:es_flutter_component/es_form/es_text_field/es_search_text_field.dart';

import 'package:es_flutter_component/es_layer/es_card.dart';
import 'package:es_flutter_component/es_spacer/es_v_spacer.dart';
import 'package:es_flutter_component/es_table/es_responsive_table.dart';
import 'package:es_flutter_component/resources/Constants/styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:http/http.dart';
import 'package:responsive_table/responsive_table.dart';

import '../../constants/dims.dart';
import '../../images/panelConstants.dart';
import '../../../../constants/strings.dart';

class Media extends StatefulWidget {
  Media({Key? key}) : super(key: key);

  @override
  _MediaState createState() => _MediaState();
}

class _MediaState extends State<Media> {
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
          text: "نام فایل",
          value: "file_name",
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
                EsButtonStreamer(
                    stream: mediaBlocDelete.actions,
                    useConfidence: true,
                    onPressed: () {
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
                            builder: (context) => DialogMediaStore(
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
                    hint: "جستجو در نام فایل...",
                    controller: _ctrlSearch,
                    onChange: (String value) {
                      setState(() {
                        _currentPage = 1;
                      });

                      getData(_currentPage);
                    },
                  ),
                  EsVSpacer(),
                  StreamBuilder<MediaPaginateModel?>(
                    stream: mediaBlocShow.actions,
                    builder:
                        (context, AsyncSnapshot<MediaPaginateModel?> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.source.length <
                            int.parse(snapshot.data!.per_page)) {
                          _currentPerPage = snapshot.data!.source.length;
                        } else {
                          _currentPerPage = int.parse(snapshot.data!.per_page);
                        }

                        _expanded = List.generate(
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
    mediaBlocShow.fetchShow(
        apiAddress: 'media/show',
        body: {"search": _ctrlSearch.text, "type": "", "page": page.toString()},
        directResult: (res) {
          setState(() {
            _isLoading = false;
          });
        });
  }

  void deleteRecord(MediaModel row) {
    mediaBlocDelete.fetchDelete(
        apiAddress: "media/delete",
        body: {"id": row.id},
        fullResponse: (Response res) {
          if (res.statusCode == 200) {
            EsAlerts.success(context, Strings.successMessage);
            getData(_currentPage);
          }
        });
  }
}
