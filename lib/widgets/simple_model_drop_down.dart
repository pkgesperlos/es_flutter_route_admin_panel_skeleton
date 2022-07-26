import 'package:flutter/material.dart';

class SimpleModelDropDown extends StatefulWidget {
  String value;
  String initialTitle;
  String idName;
  String valueName;
  List? list;
  Function(String id)? onChange;

  SimpleModelDropDown(
      {
        this.value = "",
        this.list,
        this.onChange,
        this.idName = "_id",
        this.valueName = "title",
        this.initialTitle = "انخاب کتید"});

  @override
  State<StatefulWidget> createState() {
    return _SimpleModelDropDownState();
  }
}

class _SimpleModelDropDownState extends State<SimpleModelDropDown> {
  String _value = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _value = widget.value;


    if(widget.list![0][widget.idName] != "")
    widget.list!
        .insert(0, {widget.idName: "", widget.valueName: widget.initialTitle});
  }

  @override
  Widget build(BuildContext context) {



    return DropdownButton(
        isExpanded: true,
        value: _value,
        items: widget.list!
            .map((model) => DropdownMenuItem(
          value: model[widget.idName],
          child: Text(model[widget.valueName]),
        ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _value = value.toString();

            widget.onChange!(value.toString());
          });
        });
  }

  @override
  void didUpdateWidget(covariant SimpleModelDropDown oldWidget) {
    super.didUpdateWidget(oldWidget);



    if (widget.list!.length == oldWidget.list!.length - 1) {
      if(widget.list![0][widget.idName] != "")
      widget.list!.insert(
          0, {widget.idName: "", widget.valueName: widget.initialTitle});
    }
    _value = widget.value;
  }
}