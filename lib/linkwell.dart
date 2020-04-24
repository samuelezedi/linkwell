library linkwell;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkWell extends StatelessWidget {


  //  RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
  final RegExp exp = new RegExp(r"((https?:www\.)|(https?:\/\/)|(www\.))?[\w/\-?=%.][-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
  List links = <String>[];

  String text;
  TextStyle style;
  TextStyle linkStyle;
  TextAlign textAlign;

  List widgets = <TextSpan>[];

  LinkWell({@required this.text, this.linkStyle, this.textAlign, this.style}) {
    if(this.text == null){
      throw "text is required";
    } else {
      if(linkStyle == null){
        linkStyle = TextStyle(color: Colors.blue);
      }
      if(style == null){
        style = TextStyle(color: Colors.black);
      }
      initialize();
    }
  }

  initialize() {
    Iterable<RegExpMatch> matches = exp.allMatches(this.text);
    matches.forEach((match) {
      this.links.add(text.substring(match.start, match.end));
    });
    if(links.isNotEmpty){
      _buildBody();
    } else {
      _buildNormalText();
    }
  }

  _buildNormalText() {
    widgets.add(TextSpan(text: this.text, style: style));
  }

  _buildBody() async {
    var t = this.text;
    this.links.forEach((value) async {
      var wid = t.split(value.trim());
      print(wid);
      if (wid[0] != '') {
        var text =
        TextSpan(text: wid[0], style: style);
        widgets.add(text);
      }

      if (value.toString().contains('@') && !value.toString().contains('/')) {
        //and
        final Uri params = Uri(
          scheme: 'mailto',
          path: value,
        );
        String  url = params.toString();

        var link = TextSpan(
            text: value,
            style: linkStyle,
            recognizer: new TapGestureRecognizer()
              ..onTap = () => launch(url));

        widgets.add(link);
      } else {
        var l = value.toString().contains('https://')
            ? value
            : value.toString().contains('http://')
            ? value
            : 'http://' + value;
        var link = TextSpan(
            text: value,
            style: linkStyle,
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
        text: TextSpan(children: widgets),
      ),
    );
  }
}
