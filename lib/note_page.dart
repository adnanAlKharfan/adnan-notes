import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as international;

class note_page extends StatefulWidget {
  final Color c;
  final String body;
  final model;

  note_page({this.model, this.c, this.body});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _note_page();
  }
}

class _note_page extends State<note_page> {
  TextEditingController bodyController = TextEditingController();
  bool p = false;
  bool f = true;
  @override
  void initState() {
    // TODO: implement initState

    bodyController.text = widget.body;
    p = international.Bidi.detectRtlDirectionality(bodyController.text);
    bodyController.selection = TextSelection.fromPosition(
        TextPosition(offset: bodyController.text.length));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            appBar: AppBar(
              leading: Align(
                  alignment: Alignment.bottomLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () =>
                        Navigator.of(context).pop(bodyController.text),
                  )),
              toolbarHeight: 30.0,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: widget.c,
            body: Padding(
              padding: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0),
              child: TextField(
                textAlign: p ? TextAlign.right : TextAlign.left,
                expands: true,
                maxLines: null,
                minLines: null,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none)),
                cursorColor: Colors.black,
                autofocus: true,
                controller: bodyController,
                onChanged: (v) {
                  setState(() {
                    if (f) {
                      p = international.Bidi.detectRtlDirectionality(
                          bodyController.text);
                      f = false;
                    }
                    if (bodyController.text.trim() == "") f = true;
                  });
                },
              ),
            )));
  }
}
