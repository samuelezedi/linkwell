import 'package:flutter/material.dart';

class LinkWellHelper {
  const LinkWellHelper(this.value);

  static List<String> defaultLinkRegexStr = [
    urlRegexStr,
    emailRegexStr,
  ];

  // This string will detect email addresses
  static var emailRegexStr =
      r'([a-zA-Z0-9+._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+)';

  // This string will detect url's
  static var urlRegexStr =
      r'((http|ftp|https):\/\/|www\.)([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:\/~+#-]*[\w@?^=%&\/~+#-])';

  // This string will detect phone numbers.
  static var phoneRegexStr =
      r'''(?<=[\s|'"]|^)((?:\+?1?)?[-.(]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4}))(?=[\s.;?'"!]|$)''';

  static var defaultTextStyle = TextStyle(
    fontSize: 17,
    color: Colors.black,
  );

  static var linkDefaultTextStyle = TextStyle(fontSize: 17, color: Colors.blue);

  final int value;
}
