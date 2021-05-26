import 'dart:ffi';
import 'package:ffi/ffi.dart';

import 'package:win32/win32.dart';

import 'eventdispatcher.dart';

//any function defined in dart, use `dart` types like `int` instead of `Win` types of `HWND` or `LPARAM`
int PtInternalProc(int hwnd, int message, int wparam, int lparam) {
  switch (message) {
    case WM_DESTROY:
      PostQuitMessage(0);
      return 0;
  }
  return DefWindowProc(hwnd, message, wparam, lparam);
}

//hwnd and EventDispatcherWin are linked
int CreateInternalWindow(WindClass wndClass, EventDispatcherWin dispatcher) {
  //setp 2: create window and show it
  final hWnd = CreateWindow(
      wndClass.className,
      wndClass.className,
      WS_OVERLAPPEDWINDOW,
      100,
      100,
      100,
      100,
      0,
      0,
      GetModuleHandle(nullptr),
      nullptr);

  ShowWindow(hWnd, SW_SHOWNORMAL);
  UpdateWindow(hWnd);

  return hWnd;
}

class EventDispatcherWin extends EventDispatcher {
  int InternalHwnd = 0;

  EventDispatcherWin(WindClass wndClass) {
    InternalHwnd = CreateInternalWindow(wndClass, this);
  }

  bool ProcessEvents() {
    //step 3: dispatch the message
    final msg = calloc<MSG>();

    //PeekMessage(msg, 0, 0, 0, PM_REMOVE
    while (GetMessage(msg, NULL, 0, 0) != 0) {
      if (msg.ref.message == WM_QUIT) {}
      TranslateMessage(msg);
      DispatchMessage(msg);
    }
    free(msg);

    return true;
  }
}

class WindClass {
  //ATOM atom = ATOM(0);
  //wchar_t *className;
  Pointer<WNDCLASS> wc = nullptr; //native memory is not freed
  Pointer<Utf16> className = nullptr;

  WindClass() {
    //step 1: register wndclass
    className = TEXT('EventDispatcherWin');
    wc = calloc<WNDCLASS>()
      ..ref.style = 0
      ..ref.lpfnWndProc = Pointer.fromFunction<WindowProc>(PtInternalProc, 0)
      ..ref.cbClsExtra = 0
      ..ref.cbWndExtra = 0
      ..ref.hInstance = GetModuleHandle(nullptr)
      ..ref.hIcon = 0
      ..ref.hCursor = 0
      ..ref.hbrBackground = 0
      ..ref.lpszMenuName = nullptr
      ..ref.lpszClassName = className;

    final atom = RegisterClass(wc);
    // if (!atom) {
    //     qErrnoWarning("%ls RegisterClass() failed", qUtf16Printable(qClassName));
    //     delete [] className;
    //     className = 0;
    // }
  }
}
