# LinkWell


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
