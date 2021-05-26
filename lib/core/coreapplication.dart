import 'eventloop.dart';
import 'eventdispatcher_win.dart';

class CoreApplication {
  WindClass WndClass = WindClass();
  late EventDispatcherWin Dispatcher;

  CoreApplication() {
    Dispatcher = EventDispatcherWin(WndClass);
  }

  int Exec() {
    final eventLoop = EventLoop(Dispatcher);
    final returnCode = eventLoop.Exec();

    return returnCode;
  }
}
