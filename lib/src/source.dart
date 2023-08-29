import 'package:flutter/material.dart';

class Helper {
  const Helper(this.value);

  static List<String> defaultLinkRegexStr = [
    // This string will detect url's
    r'((http|ftp|https):\/\/|www\.)([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:\/~+#-]*[\w@?^=%&\/~+#-])',

    // This string will detect email addresses
    r'([a-zA-Z0-9+._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+)'

    // TODO: Uncomment here to allow clicking on and calling a phone number.
    // '(?:\\+?(\\d{1,3}))?[-.(]*(\\d{3})[-. )]*(\\d{3})[-. ]*(\\d{4})(?: *x(\\d+))?'
  ];

  static var phoneRegex = new RegExp(r"(^(?:[+0]9)?[0-9]{10,12}$)");

  static var defaultTextStyle = TextStyle(
    fontSize: 17,
    color: Colors.black,
  );

  static var linkDefaultTextStyle = TextStyle(fontSize: 17, color: Colors.blue);

  final int value;
}
