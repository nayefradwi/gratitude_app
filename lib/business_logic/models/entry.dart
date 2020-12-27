import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part '../type_adapters/entry.g.dart';

@HiveType(typeId: 0)
class Entry extends HiveObject {
  @HiveField(0)
  String _entryText;
  @HiveField(1)
  DateTime _creationDate;

  @HiveField(2)
  String _color1;

  @HiveField(3)
  String _color2;

  Entry(this._entryText,
      {Color color1: Colors.white, Color color2: Colors.white}) {
    _creationDate = DateTime.now();
    this._color1 = color1.toString();
    this._color2 = color2.toString();
  }

  String get entryText => _entryText;
  DateTime get creationDate => _creationDate;
  Color get color1 => _fromColorToString(this._color1);
  Color get color2 => _fromColorToString(this._color2);

  @override
  String toString() {
    return "$_entryText, $_creationDate, $key, $color1, $color2";
  }

  Future<Entry> setEntryText(String text, {Color color1, Color color2}) async {
    this._entryText = text;
    if (color1 != null && color2 != null) {
      _color1 = color1.toString();
      _color2 = color2.toString();
    }

    await this.save();
    return this;
  }

  Color _fromColorToString(String colorString) {
    String valueString =
        colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }
}
