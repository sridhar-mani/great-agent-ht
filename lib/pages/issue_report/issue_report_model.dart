import '/components/button/button_widget.dart';
import '/components/step_indicator/step_indicator_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'issue_report_widget.dart' show IssueReportWidget;
import 'package:flutter/material.dart';

class IssueReportModel extends FlutterFlowModel<IssueReportWidget> {
  late StepIndicatorModel stepIndicatorModel;
  late ButtonModel buttonModel1;
  late ButtonModel buttonModel2;
  late ButtonModel buttonModel3;
  late ButtonModel buttonModel4;

  @override
  void initState(BuildContext context) {
    stepIndicatorModel = createModel(context, () => StepIndicatorModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
    buttonModel3 = createModel(context, () => ButtonModel());
    buttonModel4 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    stepIndicatorModel.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
    buttonModel3.dispose();
    buttonModel4.dispose();
  }
}
