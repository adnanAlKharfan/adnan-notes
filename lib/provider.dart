import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import './class.dart';

class data extends ChangeNotifier {
  var databasesPath;
  Database db;
  int index = null;
  List<Color> cs = [
    Colors.pink,
    Colors.blue,
    Colors.amber,
    Colors.blueGrey,
    Colors.yellow,
    Colors.green
  ];
  math.Random rand = new math.Random();
  List<note> items = new List<note>();
  static bool isLoading = false;
  Future<bool> initialize() async {
    isLoading = true;
    notifyListeners();
    databasesPath = await getDatabasesPath();
    db = await openDatabase('notes.db');
    if (db.isOpen) {
      await db.execute('''CREATE TABLE notes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    body TEXT
)''').onError((error, stackTrace) async {
        List<Map<dynamic, dynamic>> temp =
            await db.rawQuery('select * from notes order by id desc');

        for (int i = 0; i < temp.length; i++) {
          note tmp = new note(
              id: temp[i]['id'],
              body: temp[i]['body'],
              c: cs[rand.nextInt(cs.length)]);
          items.add(tmp);
        }
      });
    }

    isLoading = false;
    notifyListeners();
  }

  insert(body) async {
    isLoading = true;
    notifyListeners();
    if (db.isOpen) {
      int t = await db.insert('notes', {'body': body}).whenComplete(() {});

      note tmp = new note(id: t, body: body, c: cs[rand.nextInt(cs.length)]);
      items.insert(0, tmp);
    }

    isLoading = false;
    notifyListeners();
  }

  delete() async {
    isLoading = true;
    notifyListeners();
    if (db.isOpen) {
      await db.delete('notes', where: 'id=?', whereArgs: [index]);
      items.removeWhere((item) => item.id == index);

      index = null;
    }
    isLoading = false;
    notifyListeners();
  }

  update(body) async {
    isLoading = true;
    notifyListeners();
    if (db.isOpen) {
      await db.update('notes', {'body': body},
          where: 'id=?', whereArgs: [index]);
      items.firstWhere((element) => element.id == index).body = body;

      index = null;
    }

    isLoading = false;
    notifyListeners();
  }
}
