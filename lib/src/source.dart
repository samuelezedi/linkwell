import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Helper {
  const Helper(this.value);

  static var regex = RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))?[\w/\-?=%.][-a-zA-Z0-9@:%._\+~#=]{1,256}\.(com|net|org|edu|gov|mil|int|biz|info|jobs|mobi|name|aero|coop|asia|tel|travel|museum|arpa|pro)");

  static var phoneRegex = new RegExp(r"(^(?:[+0]9)?[0-9]{10,12}$)");

  static var defaultTextStyle = TextStyle(
    fontSize: 17,
    color: Colors.black,
  );

  static var linkDefaultTextStyle = TextStyle(fontSize: 17, color: Colors.blue);

  final int value;
}
