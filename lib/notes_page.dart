import 'package:flutter/material.dart';
import 'package:notes/note_page.dart';

import 'package:provider/provider.dart';

import './provider.dart';
import 'package:intl/intl.dart' as international;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool cancel = false;
  data r = data();
  bool right = false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  Widget itemCard(int i, String title, Color color, context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return note_page(model: r, c: color, body: title);
          })).then((value) {
            setState(() {
              Provider.of<data>(context, listen: false).index = i;

              if (value.trim() == "") {
                Provider.of<data>(context, listen: false).delete();
              } else if (value != title) {
                Provider.of<data>(context, listen: false).update(value);
              }
            });
          });
        },
        onLongPress: () {
          setState(() {
            cancel = true;
          });
        },
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: color),
            width: MediaQuery.of(context).size.width * 0.46,
            height: MediaQuery.of(context).size.height > 800
                ? MediaQuery.of(context).size.height * 0.1
                : MediaQuery.of(context).size.height * 0.2,
            padding: EdgeInsets.all(10.0),
            child: Text(
              title,
              textDirection:
                  international.Bidi.detectRtlDirectionality(title[0])
                      ? TextDirection.rtl
                      : TextDirection.ltr,
            ),
          ),
          cancel
              ? Material(
                  color: Colors.red,
                  shadowColor: Colors.red,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  elevation: 10.0,
                  child: IconButton(
                      color: Colors.red,
                      onPressed: () {
                        setState(() {
                          Provider.of<data>(context, listen: false).index = i;
                          Provider.of<data>(context, listen: false).delete();
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      )))
              : SizedBox()
        ]));
  }

  @override
  Widget build(BuildContext contex) {
    return GestureDetector(
        onTap: () {
          setState(() {
            cancel = false;
          });
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height > 800
                ? MediaQuery.of(context).size.height * 0.1
                : MediaQuery.of(context).size.height * 0.3,
            leadingWidth: MediaQuery.of(context).size.width,
            backgroundColor: Colors.transparent,
            elevation: 10.0,
            shape: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[850]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))),
            title: Text(
              "NOTES",
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.1),
            ),
            centerTitle: true,
          ),
          body: Provider.of<data>(context, listen: true).isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: PageScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding: EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                    left: MediaQuery.of(context).size.width * 0.03,
                    right: MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        runSpacing: 10.0,
                        children: Provider.of<data>(context, listen: false)
                            .items
                            .map((item) => itemCard(
                                item.id, item.body, item.c, this.context))
                            .toList()
                            .cast<Widget>(),
                      ))),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(this.context)
                  .push(MaterialPageRoute(builder: (context) {
                return note_page(
                    model: Provider.of<data>(context, listen: false),
                    c: Provider.of<data>(context, listen: false).cs[
                        Provider.of<data>(context, listen: false).rand.nextInt(
                            Provider.of<data>(context, listen: false)
                                .cs
                                .length)],
                    body: "");
              })).then((value) {
                if (value.trim() != "") {
                  Provider.of<data>(context, listen: false).insert(value);
                }
              });
            },
            tooltip: 'create notes',
            child: Icon(Icons.library_books),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
