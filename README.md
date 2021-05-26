# point
Point (PT for short) is a QT-like GUI library in dart language.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/PtPoint/point/issues

## Run example
```sh
dart compile exe example\point_example.dart
```
The generated `point_example.exe` is about 4.9M

## Development log

### v0.01: 
- Use `win32` pub (https://pub.dev/packages/win32)
- Create class `Application` with default window
```dart
import 'package:point/point.dart';

void main() {
  final app = Application();
  app.Exec();
}
```
![image info](./example/v0.01.png)

### v0.02: **todo**: 
- change `Application` to have a `HWND_MESSAGE` window
- add `MainWindow` class
