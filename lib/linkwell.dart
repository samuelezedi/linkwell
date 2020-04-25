///  LinkWell is Text Plugin that detects URLs and Emails in a String and when tapped opens in user browsers,

/// I invite you to clone, star and make contributions to this project, Thanks.

/// Copyright 2020. All rights reserved.
/// Use of this source code is governed by a BSD-style license that can be
/// found in the LICENSE file.

library linkwell;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:linkwell/src/source.dart';

/// LinkWell depends on url_launcher plugin
/// it help lauches the links and emails when user taps
import 'package:url_launcher/url_launcher.dart';

/// LinkWell class created
class LinkWell extends StatelessWidget {
  /// The RegEx pattern is created
  final RegExp exp = Helper.regex;

  /// This is holds all links when detected
  final List links = <String>[];

  /// This hold all Names of links provided by the User
  /// this is set to null by default
  final Map<String, String> listOfNames;

  /// This hold TextSpan Widgets List
  /// which is then placed as child in the RichText Widget
  final List textSpanWidget = <TextSpan>[];

  /// This hold the text the user provides
  final String text;

  /// This hold user defined styling
  /// It's an instanciation of Flutter Widget TextStyle
  final TextStyle style;

  /// This hold user defined styling
  /// for the links
  /// It's also an instanciation of Flutter Widget TextStyle
  final TextStyle linkStyle;

  /// This hold user defined textAlignment
  /// It's also an instanciation of Flutter Widget TextAlign
  /// It has a default value of TextAlign.start,
  final TextAlign textAlign;

  /// This hold user defined MaxLines
  /// because LinkWell makes user of Flutter RichText Widget
  /// it also gives user the option to create max lines
  /// it can take a default value of null
  final int maxLines;

  /// This hold user defined locale
  /// because LinkWell makes user of Flutter RichText Widget
  /// it also gives user the option to define textOverflow
  /// by default this is set to TextOverflow.clip
  final Locale locale;

  /// This hold user defined overflow
  /// because LinkWell makes user of Flutter RichText Widget
  /// it also gives user the option to create locale
  /// by default can also be null
  final TextOverflow overflow;

  /// This hold user defined StrutStyle
  /// because LinkWell makes user of Flutter RichText Widget
  /// it also gives user the option to create strutstyle
  /// by default can also be null
  final StrutStyle strutStyle;

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
  final TextDirection textDirection;

  /// This hold user defined Widget key
  /// by default can also be null
  final Key key;

  /// LinkWell class is constructed here
  LinkWell(
    this.text, {
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
    this.textWidthBasis = TextWidthBasis.parent,
  })  : assert(text != null),
        assert(textAlign != null),
        assert(softWrap != null),
        assert(overflow != null),
        assert(textScaleFactor != null),
        assert(maxLines == null || maxLines > 0),
        assert(textWidthBasis != null) {
    /// At construction _initialize function is called
    _initialize();
  }

  /// _initialize function
  _initialize() {
    /// An Iterable with variable name matches
    /// Is assigned to our regular expression with
    /// allMatched method call
    Iterable<RegExpMatch> matches = exp.allMatches(this.text);

    /// We now run a forEach Loop to add our matche to
    /// the links List
    matches.forEach((match) {
      this.links.add(text.substring(match.start, match.end));
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
    this.links.forEach((value) async {
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

        var name = value;

        if (this.listOfNames != null) {
          if (this.listOfNames.containsKey(value)) {
            name = (this.listOfNames[value] != null ||
                    this.listOfNames[value] != '')
                ? this.listOfNames[value]
                : value;
          }
        }

        var link = TextSpan(
            text: name,
            style: linkStyle == null ? Helper.linkDefaultTextStyle : linkStyle,
            recognizer: new TapGestureRecognizer()..onTap = () => launch(url));

        /// added
        textSpanWidget.add(link);
      } else {
        /// else we let url_laucher know that this is url and not an email

        var l = value.toString().contains('https://')
            ? value
            : value.toString().contains('http://') ? value : 'http://' + value;
        var name = l;

        if (this.listOfNames != null) {
          if (this.listOfNames.containsKey(value)) {
            name = (this.listOfNames[value] != null ||
                    this.listOfNames[value] != '')
                ? this.listOfNames[value]
                : value;
          }
        }

        var link = TextSpan(
            text: name,
            style: linkStyle == null ? Helper.linkDefaultTextStyle : linkStyle,
            recognizer: new TapGestureRecognizer()..onTap = () => launch(l));

        /// added
        textSpanWidget.add(link);
      }

      if (wid[1] != '') {
        if (value == links.last) {
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
        key: key,
        text: TextSpan(children: textSpanWidget),
      ),
    );
  }
}
