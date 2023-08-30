///  LinkWell is Text Plugin that detects URLs and Emails in a String and when tapped opens in user browsers,

/// I invite you to clone, star and make contributions to this project, Thanks.

/// Copyright 2020. All rights reserved.
/// Use of this source code is governed by a BSD-style license that can be
/// found in the LICENSE file.

library linkwell;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:linkwell/src/source.dart';
// import 'package:cm_utils/string_utils.dart';

/// LinkWell depends on url_launcher plugin
/// it help lauches the links and emails when user taps
import 'package:url_launcher/url_launcher.dart';

typedef LinkWellClickHandler = bool Function(String url);

/// LinkWell class created
class LinkWell extends StatelessWidget {
  /// (Optional) Custom regex strings can be passed in [regExLinkPatterns].
  /// This can be used to replace the built in pattern matching.
  final List<String>? regExLinkPatterns;

  /// This is holds all links found in the text.
  /// The format is jason:
  /// {link: 'examplelink.com', location: 20 };
  ///
  /// 'link' is the detected link which could be email, url, etc.
  /// 'location' is the location in the string where the link begins.
  ///
  final List<Map<String, dynamic>> links = [];

  /// This hold all Names of links provided by the User
  /// this is set to null by default
  final Map<String, String>? listOfNames;

  /// This hold TextSpan Widgets List
  /// which is then placed as child in the RichText Widget
  final List<InlineSpan> textSpanWidget = <TextSpan>[];

  /// This hold the text the user provides
  final String text;

  /// This hold user defined styling
  /// It's an instanciation of Flutter Widget TextStyle
  final TextStyle? style;

  /// This hold user defined styling
  /// for the links
  /// It's also an instanciation of Flutter Widget TextStyle
  final TextStyle? linkStyle;

  /// This hold user defined textAlignment
  /// It's also an instanciation of Flutter Widget TextAlign
  /// It has a default value of TextAlign.start,
  final TextAlign textAlign;

  /// This hold user defined MaxLines
  /// because LinkWell makes user of Flutter RichText Widget
  /// it also gives user the option to create max lines
  /// it can take a default value of null
  final int? maxLines;

  /// This hold user defined locale
  /// because LinkWell makes user of Flutter RichText Widget
  /// it also gives user the option to define textOverflow
  /// by default this is set to TextOverflow.clip
  final Locale? locale;

  /// This hold user defined overflow
  /// because LinkWell makes user of Flutter RichText Widget
  /// it also gives user the option to create locale
  /// by default can also be null
  final TextOverflow overflow;

  /// This hold user defined StrutStyle
  /// because LinkWell makes user of Flutter RichText Widget
  /// it also gives user the option to create strutstyle
  /// by default can also be null
  final StrutStyle? strutStyle;

  /// This hold user defined softWrap
  /// because LinkWell makes user of Flutter RichText Widget
  /// it also gives user the option to create softwrap
  /// by default this is set to null
  final bool softWrap;

  /// This hold user defined textScaleFactor
  /// because LinkWell makes user of Flutter RichText Widget
  /// it also gives user the option to create textScaleFactor
  /// by default can also be null
  final double textScaleFactor;

  /// This hold user defined textScaleFactor
  /// because LinkWell makes user of Flutter RichText Widget
  /// it also gives user the option to create textScaleFactor
  /// by default can also be null
  final TextWidthBasis textWidthBasis;

  /// This hold user defined textScaleFactor
  /// because LinkWell makes user of Flutter RichText Widget
  /// it also gives user the option to create textScaleFactor
  /// by default can also be null
  final TextDirection? textDirection;

  /// This optional parameter gives the caller the opportunity to evaluate
  /// the link prior to LinkWell calling the default click handling
  /// clickHandler should return 'true' if it processes the click,
  /// otherwise, if it returns 'false' then LinkWell will call the
  /// built-in click handler.
  final LinkWellClickHandler? clickHandler;

  /// This hold user defined Widget key
  /// by default can also be null
  final Key? key;

  /// LinkWell class is constructed here
  LinkWell(
    this.text, {
    this.regExLinkPatterns,
    this.key,
    this.style,
    this.linkStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.listOfNames,
    this.clickHandler,
    this.textWidthBasis = TextWidthBasis.parent,
  }) : assert(maxLines == null || maxLines > 0) {
    /// At construction _initialize function is called
    _initialize();
  }

  /// _initialize function
  _initialize() {
    // Use passed in regular expression strings if provided, otherwise use default
    var regexStrings = regExLinkPatterns ?? Helper.defaultLinkRegexStr;

    regexStrings.forEach((regexStr) {
      /// An Iterable with variable name matches
      /// Is assigned to our regular expression with
      /// allMatched method cal
      var exp = RegExp(regexStr);
      Iterable<RegExpMatch> matches = exp.allMatches(this.text);

      /// We now run a forEach Loop to add our match to
      /// the links List
      matches.forEach((match) {
        this.links.add({
          'link': text.substring(match.start, match.end),
          'location': match.start
        });
      });
    });

    // sort links by order found in the text string. Necessary so substitution
    // works correctly.
    links.sort((item1, item2) {
      return item1['location'] - item2['location'];
    });

    /// We run a check to know if urls and Emails are found
    /// by checking if links.isNotEmpty
    /// if true
    /// we call BuildBody
    /// else we call BuildNormalBody
    if (links.isNotEmpty) {
      _buildBody();
    } else {
      _buildNormalText();
    }
  }

  /// _buildNormalText()
  /// this is called when no links is detected
  /// It simple build add TextSpan widget to our
  /// textSpanWidget List
  _buildNormalText() {
    /// Adds TextSpan to textSpanWidget
    /// checks if style is null and set deafult style
    /// otherwise set style to user defined
    textSpanWidget.add(TextSpan(
        text: this.text,
        style: style == null ? Helper.defaultTextStyle : style));
  }

  /// _buildBody()
  /// this is called when links are detected
  /// It simple build add TextSpan widget to our
  /// textSpanWidget List
  _buildBody() async {
    /// var t is assigned to class text

    var t = this.text;

    /// a foreach is run on all the links found
    this.links.forEach((linkMap) async {
      var value = linkMap['link'] as String? ?? '';

      /// var wid which represents widget
      var wid = t.split(value.trim());

      /// if not value is found after splitting
      /// we simple place text inside TextSpan
      /// and add to textSpanWidget
      if (wid[0] != '') {
        var text = TextSpan(
          text: wid[0],
          style: style == null ? Helper.defaultTextStyle : style,
        );

        /// added
        textSpanWidget.add(text);
      }

      /// when a link is found
      /// we check if its an email,
      /// so we can instruct url_launcher
      /// that this is an email
      if (value.toString().contains('@') && !value.toString().contains('/')) {
        final Uri params = Uri(
          scheme: 'mailto',
          path: value,
        );

        String url = params.toString();

        String? name = value;

        if (this.listOfNames != null) {
          if (this.listOfNames!.containsKey(value)) {
            name = (this.listOfNames![value] != null ||
                    this.listOfNames![value] != '')
                ? this.listOfNames![value]
                : value;
          }
        }

        var link = TextSpan(
            text: name,
            style: linkStyle == null ? Helper.linkDefaultTextStyle : linkStyle,
            recognizer: new TapGestureRecognizer()..onTap = () => _launch(url));

        /// added
        textSpanWidget.add(link);

        // TODO: Uncomment here to allow clicking on and calling a phone number.
        // Must be implemented in custom clickHandler.
        //
        // } else if (value.isValidPhoneNumber()) {
        //   var link = TextSpan(
        //       text: value,
        //       style: linkStyle == null ? Helper.linkDefaultTextStyle : linkStyle,
        //       recognizer: new TapGestureRecognizer()
        //         ..onTap = () => _launch('tel:$value'));

        //   textSpanWidget.add(link);
      } else {
        /// else we let url_laucher know that this is url and not an email

        var l = value.toString().contains('https://')
            ? value
            : value.toString().contains('http://')
                ? value
                : 'http://' + value;
        String? name = l;

        if (this.listOfNames != null) {
          if (this.listOfNames!.containsKey(value)) {
            name = (this.listOfNames![value] != null ||
                    this.listOfNames![value] != '')
                ? this.listOfNames![value]
                : value;
          }
        }

        var link = TextSpan(
            text: name,
            style: linkStyle == null ? Helper.linkDefaultTextStyle : linkStyle,
            recognizer: new TapGestureRecognizer()..onTap = () => _launch(l));

        /// added
        textSpanWidget.add(link);
      }

      if (wid[1] != '') {
        if (value == links.last['link']) {
          var text = TextSpan(
            text: wid[1],
            style: style == null ? Helper.defaultTextStyle : style,
          );

          /// added
          textSpanWidget.add(text);
        } else {
          t = wid[1];
        }
      }
    });
  }

  void _launch(url) {
    var handled = false;
    if (clickHandler != null) {
      handled = clickHandler!(url);
    }
    if (!handled) {
      try {
        launch(url);
      } catch (err) {
        print('Error launching URL: $url. Error = $err');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        textAlign: textAlign,
        locale: locale,
        maxLines: maxLines,
        overflow: overflow,
        strutStyle: strutStyle,
        softWrap: softWrap,
        textScaleFactor: textScaleFactor,
        textWidthBasis: textWidthBasis,
        textDirection: textDirection,
        text: TextSpan(children: textSpanWidget),
      ),
    );
  }
}
