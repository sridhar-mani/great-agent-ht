import '/components/button/button_widget.dart';
import '/components/confidence_row/confidence_row_widget.dart';
import '/components/evidence_card/evidence_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'a_i_analysis_result_widget.dart' show AIAnalysisResultWidget;
import 'package:flutter/material.dart';

class AIAnalysisResultModel extends FlutterFlowModel<AIAnalysisResultWidget> {
  late EvidenceCardModel evidenceCardModel1;
  late EvidenceCardModel evidenceCardModel2;
  late EvidenceCardModel evidenceCardModel3;

  late ConfidenceRowModel confidenceRowModel1;
  late ConfidenceRowModel confidenceRowModel2;
  late ConfidenceRowModel confidenceRowModel3;
  late ConfidenceRowModel confidenceRowModel4;

  late ButtonModel buttonModel1;
  late ButtonModel buttonModel2;
  late ButtonModel buttonModel3;

  @override
  void initState(BuildContext context) {
    evidenceCardModel1 = createModel(context, () => EvidenceCardModel());
    evidenceCardModel2 = createModel(context, () => EvidenceCardModel());
    evidenceCardModel3 = createModel(context, () => EvidenceCardModel());

    confidenceRowModel1 = createModel(context, () => ConfidenceRowModel());
    confidenceRowModel2 = createModel(context, () => ConfidenceRowModel());
    confidenceRowModel3 = createModel(context, () => ConfidenceRowModel());
    confidenceRowModel4 = createModel(context, () => ConfidenceRowModel());

    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
    buttonModel3 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    evidenceCardModel1.dispose();
    evidenceCardModel2.dispose();
    evidenceCardModel3.dispose();

    confidenceRowModel1.dispose();
    confidenceRowModel2.dispose();
    confidenceRowModel3.dispose();
    confidenceRowModel4.dispose();

    buttonModel1.dispose();
    buttonModel2.dispose();
    buttonModel3.dispose();
  }
}
