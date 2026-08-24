import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'flutter_flow_model.dart';

export 'flutter_flow_model.dart';
export 'flutter_flow_theme.dart';
export 'package:go_router/go_router.dart';

extension ListDivideExtension on List<Widget> {
  List<Widget> divide(Widget separator) {
    if (isEmpty || length == 1) {
      return this;
    }
    final result = <Widget>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i != length - 1) {
        result.add(separator);
      }
    }
    return result;
  }
}

extension StateSafeSetState on State {
  void safeSetState(VoidCallback fn) {
    if (mounted) {
      // ignore: invalid_use_of_protected_member
      setState(fn);
    }
  }
}
