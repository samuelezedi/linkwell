
import 'package:example/b.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LinkWell Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'LinkWell Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LinkWell(
                  """My website url: https://blasanka.github.io/ Google sam@mail.com search medium.com/@samuelezedi using: www.google.com, social gdk@gmail.com media is facebook.com, http://example.com/method?param=flutter stackoverflow.com is my greatest website. DartPad share: https://github.com/dart-lang/dart-pad/wiki/Sharing-Guide see this example and edit it here """,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                """My website url: https://blasanka.github.io/ Google sam@mail.com search medium.com/@samuelezedi using: www.google.com, social gdk@gmail.com media is facebook.com, http://example.com/method?param=flutter stackoverflow.com is my greatest website. DartPad share: https://github.com/dart-lang/dart-pad/wiki/Sharing-Guide see this example and edit it here """
              ),
              LinkWell("Here I am samuel@ezedi.com", textAlign: TextAlign.end,)
            ],
          ),
        
      ),
    );
  }
}
