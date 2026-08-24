import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'step_indicator_model.dart';
export 'step_indicator_model.dart';

class StepIndicatorWidget extends StatefulWidget {
  const StepIndicatorWidget({
    super.key,
    required this.activeStep,
  });

  final String activeStep; // '1', '2', '3'

  @override
  State<StepIndicatorWidget> createState() => _StepIndicatorWidgetState();
}

class _StepIndicatorWidgetState extends State<StepIndicatorWidget> {
  late StepIndicatorModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StepIndicatorModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int current = int.tryParse(widget.activeStep) ?? 1;

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildStep(context, 1, current),
        Expanded(
          child: Container(
            height: 2,
            color: current >= 2 ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).alternate,
          ),
        ),
        _buildStep(context, 2, current),
        Expanded(
          child: Container(
            height: 2,
            color: current >= 3 ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).alternate,
          ),
        ),
        _buildStep(context, 3, current),
      ],
    );
  }

  Widget _buildStep(BuildContext context, int step, int current) {
    bool isCompleted = current > step;
    bool isActive = current == step;

    Color bg;
    Color fg;
    if (isCompleted || isActive) {
      bg = FlutterFlowTheme.of(context).primary;
      fg = Colors.white;
    } else {
      bg = FlutterFlowTheme.of(context).alternate;
      fg = FlutterFlowTheme.of(context).secondaryText;
    }

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: isCompleted
          ? const Icon(Icons.check, size: 14, color: Colors.white)
          : Text(
              '$step',
              style: TextStyle(
                color: fg,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
