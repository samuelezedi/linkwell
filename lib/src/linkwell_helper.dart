import 'package:cm_utils/string_utils.dart';
import 'package:flutter/material.dart';

class LinkWellHelper {
  const LinkWellHelper(this.value);

  static List<String> defaultLinkRegexStr = [
    urlRegexStr,
    emailRegexStr,
  ];

  // This string will detect email addresses
  static var emailRegexStr = CmRegexPatterns.embeddedEmailRegexStr;

  // This string will detect url's
  static var urlRegexStr = CmRegexPatterns.embeddedUrlRegexStr;

  // This string will detect phone numbers.
  static var phoneRegexStr = CmRegexPatterns.embeddedUSPhoneNum;

  static var defaultTextStyle = TextStyle(
    fontSize: 17,
    color: Colors.black,
  );

  static var linkDefaultTextStyle = TextStyle(fontSize: 17, color: Colors.blue);

  final int value;
}
