import 'eventdispatcher_win.dart';

class EventLoop {
  late EventDispatcherWin Dispatcher;

  EventLoop(EventDispatcherWin dispatcher) {
    Dispatcher = dispatcher;
  }

  int Exec() {
    ProcessEvent();
    return 0;
  }

  bool ProcessEvent() {
    Dispatcher.ProcessEvents();
    return true;
  }
}
