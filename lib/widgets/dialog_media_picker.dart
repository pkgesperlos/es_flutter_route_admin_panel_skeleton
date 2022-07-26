import 'package:cached_network_image/cached_network_image.dart';
import 'package:checklist_admin_panel/constants/strings.dart';
import 'package:checklist_admin_panel/resources/converter.dart';
import 'package:es_flutter_component/es_text/es_ordinary_text.dart';
import 'package:es_flutter_component/es_text/es_subtitle.dart';
import 'package:es_flutter_component/es_text/es_title.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../blocs/media_bloc.dart';
import '../constants/dims.dart';
import '../models/media_model.dart';
import '../resources/save.dart';

class DialogMediaPicker extends StatefulWidget {

  MediaController? controller;
  Function(MediaModel model)? onSelect;

  DialogMediaPicker({Key? key,this.controller,this.onSelect}) : super(key: key);

  @override
  _DialogMediaPickerState createState() => _DialogMediaPickerState();
}

class _DialogMediaPickerState extends State<DialogMediaPicker> {
  List<Map<String, dynamic>>? _source;
  bool _isLoading = true;
  late int _total;
  late int _currentPerPage;
  late int _lastPage;
  int _currentPage = 1;

  late double _imageWidth;

  String _mediaType = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData(_currentPage);
  }

  @override
  Widget build(BuildContext context) {
    _imageWidth = MediaQuery.of(context).size.width / 5;

    return Dialog(
      child: StreamBuilder<MediaPaginateModel?>(
        stream: mediaBlocShow.actions,
        builder: (context, AsyncSnapshot<MediaPaginateModel?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.source.length <
                int.parse(snapshot.data!.per_page)) {
              _currentPerPage = snapshot.data!.source.length;
            } else {
              _currentPerPage = int.parse(snapshot.data!.per_page);
            }

            _lastPage = int.parse(snapshot.data!.last_page);

            _total = int.parse(snapshot.data!.total);



            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dims.h1Padding(context) * 2,
                  vertical: Dims.h1Padding(context)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  header(),
                  content(snapshot),
                ],
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
      ),
    );
  }

  getData(int page) async {
    mediaBlocShow.fetchShow(
        apiAddress: 'media/show',
        body: {"search": "", "type": _mediaType, "page": page.toString()},
        directResult: (res) {});
  }

  Widget imageItems(MediaModel model) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(Dims.h1Padding(context)),
        width: _imageWidth,
        height: _imageWidth,
        child: CachedNetworkImage(
          imageUrl: Strings.baseFileUrl + model.url,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Container(
            width: _imageWidth,
            height: _imageWidth,
            child: Center(child: EsSubtitle("تصویر لود نشد")),
            decoration: BoxDecoration(color: Colors.black26),
          ),
        ),
      ),
      onTap: (){
        Navigator.of(context).pop();
        widget.controller!.mediaModel = model;
        widget.onSelect!(model);
      },
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EsTitle("رسانه ها"),
        Row(
          children: [
            Paginate(
              lastPage: _lastPage,
              currentPage: _currentPage,
              currentPerPage: _currentPerPage,
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
            DropdownButton(
                value: _mediaType,
                items: ["0", "1"]
                    .map((e) => DropdownMenuItem(
                    value: e,
                    child:
                    Text(Converter.getMediaTypeTitle(e))))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _mediaType = value.toString();
                  });
                  getData(_currentPage);
                })
          ],
        )
      ],
    );
  }

  Widget content(snapshot) {

    List<Widget> widgets = [];

    for (int i = 0; i < snapshot.data!.data!.list.length; i++) {
      widgets.add(imageItems(snapshot.data!.data!.list[i]));
    }

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(Dims.h1BorderRadius(context))),
          border: Border.all(color: Colors.black26)),
      height: MediaQuery.of(context).size.height * .8,
      width: double.maxFinite,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          direction: Axis.horizontal,
          children: widgets,
        ),
      ),
    );
  }

// Widget listItems(MediaModel model, index) {
//   return ;
// }
}

class Paginate extends StatefulWidget {
  Function(int page)? onNextPressed;
  Function(int page)? onPreviousPressed;
  Function(int page)? onPageSelected;
  late int? currentPerPage;
  late int? lastPage;
  int currentPage;

  Paginate(
      {this.onNextPressed,
      this.onPreviousPressed,
      this.onPageSelected,
      this.currentPerPage,
      this.lastPage,
      this.currentPage = 1});

  @override
  State<StatefulWidget> createState() {
    return _PaginateState();
  }
}

class _PaginateState extends State<Paginate> {
  late String _dropdownValue;

  late List<DropdownMenuItem<String>> _dropdownItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 1; i <= widget.lastPage!; i++)
      _dropdownItems.add(DropdownMenuItem<String>(
        value: i.toString(),
        child: Text(i.toString()),
      ));
  }

  @override
  Widget build(BuildContext context) {
    _dropdownValue = widget.currentPage.toString();

    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 16,
          ),
          onPressed: widget.currentPage == 1
              ? null
              : () {
                  var _nextSet = widget.currentPage - widget.currentPerPage!;
                  widget.currentPage--;
                  widget.onPreviousPressed!(widget.currentPage);

                  /*    setState(() {
                          _currentPage = _nextSet > 1 ? _nextSet : 1;
                          _resetData(start: _currentPage - 1);
                        });*/

                  print(_nextSet);
                },
          padding: EdgeInsets.symmetric(horizontal: 15),
        ),
        DropdownButton<String>(
          value: _dropdownValue,
          icon: const Icon(Icons.arrow_drop_up),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              _dropdownValue = newValue!;
            });
            widget.onPageSelected!(int.parse(newValue!));
          },
          items: _dropdownItems,
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios, size: 16),
          onPressed: widget.currentPage == widget.lastPage
              ? null
              : () {
                  var _nextSet = widget.currentPage + widget.currentPerPage!;
                  widget.currentPage++;
                  /* setState(() {
                          _isLoading = true;
                        });
*/
                  widget.onNextPressed!(widget.currentPage);
                },
          padding: EdgeInsets.symmetric(horizontal: 15),
        )
      ],
    );
  }
}


class MediaController{
  MediaModel? _mediaModel;

  MediaModel? get mediaModel => _mediaModel;

  set mediaModel(MediaModel? value) {
    _mediaModel = value;
  }
}