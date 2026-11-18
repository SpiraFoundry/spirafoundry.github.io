import 'dart:js_interop';

@JS('window.scrollTo')
external void _windowScrollTo(int x, int y);

void scrollToTop() {
  _windowScrollTo(0, 0);
}
