import '/components/button/button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dispatch_confirmation_widget.dart' show DispatchConfirmationWidget;
import 'package:flutter/material.dart';

class DispatchConfirmationModel extends FlutterFlowModel<DispatchConfirmationWidget> {
  late ButtonModel buttonModel1;
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
