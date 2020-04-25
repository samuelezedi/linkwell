# LinkWell

LinkWell is Text Plugin that detects URLs and Emails in a String and when tapped opens in user browsers,

# `linkwell` [![pub package](https://img.shields.io/badge/pub-0.1.9-brightgreen)](https://pub.dartlang.org/packages/linkwell)

[GitHub](https://github.com/samuelezedi/linkwell)

## ScreenShots

| Basic Usage | Named Links |
| ------------- | ------------- |
| <image width="200" src="https://raw.githubusercontent.com/samuelezedi/linkwell/master/example/assets/images/sc.jpeg"> | <image width="200" src="https://raw.githubusercontent.com/samuelezedi/linkwell/master/example/assets/images/sc2.jpeg"> |


## Usage

Basic:

```dart
import 'package:linkwell/linkwell.dart';
```

```dart
LinkWell(
    "Hi here's my email: samuelezedi@gmail.com and website: https://samuelezedi.com"
);
```

### Add Styling

To add style to links

```dart
LinkWell(
    "Hi here's my email: samuelezedi@gmail.com and website: https://samuelezedi.com",
    linkStyle: TextStyle(color: Colors.blue,fontSize: 17)
);
```

To add style to non links

```dart
LinkWell(
    "Hi here's my email: samuelezedi@gmail.com and website: https://samuelezedi.com",
    style: TextStyle(color: Colors.black,fontSize: 17)
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

I was building a chat application and I needed to detect when users posted links and emails
so I went online and found a couple plugin but then, only one fit the need, I imported it and discovered
that it could not detect emails and long urls correctly and I could not name URLs or emails, So I built LinkWell.
I hope this is what you are looking for and it solves your link problems.

## Kindly follow me on
[twitter](https://twitter.com/samuelezedi)
[medium](https://medium.com/@samuelezedi)
[instagram](https://instagram.com/samuelezedi)

