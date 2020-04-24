library linkwell;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkWell {
  //  RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
  final RegExp exp = new RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))?[\w/\-?=%.][-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
  final List links = <String>[];

  final String text;
  final TextStyle style;
  final TextStyle linkStyle;
  final TextAlign textAlign;
  final int maxLines;
  final Locale locale;
  final TextOverflow overflow;
  final StrutStyle strutStyle;
  final bool softWrap;
  final double textScaleFactor;
  final TextWidthBasis textWidthBasis;
  final TextDirection textDirection;
  final Key key;

  List widgets = <TextSpan>[];

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
        this.textWidthBasis = TextWidthBasis.parent,
      })  : assert(text != null),
        assert(textAlign != null),
        assert(softWrap != null),
        assert(overflow != null),
        assert(textScaleFactor != null),
        assert(maxLines == null || maxLines > 0),
        assert(textWidthBasis != null) {
    _initialize();
  }

  _initialize() {
    Iterable<RegExpMatch> matches = exp.allMatches(this.text);
    matches.forEach((match) {
      this.links.add(text.substring(match.start, match.end));
    });
    if (links.isNotEmpty) {
      _buildBody();
    } else {
      _buildNormalText();
    }
  }

  _buildNormalText() {
    widgets.add(TextSpan(
        text: this.text,
        style: style == null
            ? TextStyle(color: Colors.black, fontSize: 15)
            : style));
  }

  _buildBody() async {
    var t = this.text;
    this.links.forEach((value) async {
      var wid = t.split(value.trim());

      if (wid[0] != '') {
        var text = TextSpan(
          text: wid[0],
          style: style == null
              ? TextStyle(
            color: Colors.black,
            fontSize: 15,
          )
              : style,
        );
        widgets.add(text);
      }

      if (value.toString().contains('@') && !value.toString().contains('/')) {
        //and
        final Uri params = Uri(
          scheme: 'mailto',
          path: value,
        );
        String url = params.toString();

        var link = TextSpan(
            text: value,
            style: linkStyle == null
                ? TextStyle(color: Colors.blue, fontSize: 15)
                : linkStyle,
            recognizer: new TapGestureRecognizer()..onTap = () => launch(url));

        widgets.add(link);
      } else {
        var l = value.toString().contains('https://')
            ? value
            : value.toString().contains('http://') ? value : 'http://' + value;
        var link = TextSpan(
            text: value,
            style: linkStyle == null
                ? TextStyle(color: Colors.blue, fontSize: 15)
                : linkStyle,
            recognizer: new TapGestureRecognizer()..onTap = () => launch(l));

        widgets.add(link);
      }

      if (wid[1] != '') {
        t = wid[1];
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
        text: TextSpan(children: widgets),
      ),
    );
  }
}
