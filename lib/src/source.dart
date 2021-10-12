import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Helper {
  const Helper(this.value);

  static var regex = new RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))?[\w\-?=%.][-a-zA-Z@:%._\+~#=]{1,256}\.+((com|ru|org|gov|net|ir|in|uk|au|de|ua|edu|io|co))(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

  static var phoneRegex = new RegExp(r"(^(?:[+0]9)?[0-9]{10,12}$)");

  static var defaultTextStyle = TextStyle(
    fontSize: 17,
    color: Colors.black,
  );

  static var linkDefaultTextStyle = TextStyle(fontSize: 17, color: Colors.blue);

  final int value;
}
