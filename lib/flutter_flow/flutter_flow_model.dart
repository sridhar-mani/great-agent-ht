import 'package:flutter/material.dart';

abstract class FlutterFlowModel<T extends Widget> {
  bool _isInitialized = false;
  void initState(BuildContext context) {
    _isInitialized = true;
  }

  void maybeUpdate() {}

  void dispose() {}
}

T createModel<T extends FlutterFlowModel>(
  BuildContext context,
  T Function() defaultModel,
) {
  final model = defaultModel();
  model.initState(context);
  return model;
}

Widget wrapWithModel<T extends FlutterFlowModel>({
  required T model,
  required Widget child,
  required VoidCallback updateCallback,
}) {
  return child;
}
