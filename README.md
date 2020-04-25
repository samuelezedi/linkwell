# LinkWell

LinkWell is Text Plugin that detects URLs and Emails in a String and when tapped opens in user browsers,

# `linkwell` [![pub package](https://img.shields.io/badge/pub-0.1.2-brightgreen)](https://pub.dartlang.org/packages/linkwell)

[GitHub](https://github.com/samuelezedi/linkwell)

## ScreenShots

![Basic Usage](https://raw.githubusercontent.com/samuelezedi/linkwell/master/assets/images/sc2.jpeg)
Basic Usage

![Names Links](https://raw.githubusercontent.com/samuelezedi/linkwell/master/assets/images/sc.jpeg)
Named Links

## Usage

Basic:

```dart
import 'package:linkwell/linkwell.dart';

LinkWell(
"Hi here's my email: samuelezedi@gmail.com and website: https://samuelezed.com"
);
```

### Add Styling

To add style to links

```dart
LinkWell(
"Hi here's my email: samuelezedi@gmail.com and website: https://samuelezed.com",
linkStyle: TextStyle(color: Colors.blue,fontSize: 17)
);
```

To add style to non links

```dart
LinkWell(
"Hi here's my email: samuelezedi@gmail.com and website: https://samuelezed.com",
style: TextStyle(color: Colors.blue,fontSize: 17)
);
```

### Naming Links

If you would like to name the links

```dart
LinkWell(
"By registering you agree to our samuelezedi.com/terms and samuelezedi.com/privacy",
listOfNames: {
'samuelezedi.com/terms' : 'Terms',
'samuelezedi.com/privacy' : 'Privacy Policy'
},
);
```

## Why I made this plugin

I was building a chat application and I need something to detect when user post links and email
so I went online and found a couple plugin but they only one fit the need, I imported it and discovered
that it could not detect emails correctly and it long urls fully and finally I could not name URLs or emails, So I built LinkWell.
I hope this is what you are looking for and it solves your link problems.
