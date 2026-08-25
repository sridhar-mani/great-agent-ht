import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'confidence_row_model.dart';
export 'confidence_row_model.dart';

class ConfidenceRowWidget extends StatefulWidget {
  const ConfidenceRowWidget({
    super.key,
    required this.label,
    required this.percent,
    this.isPrimary = false,
  });

  final String label;
  final String percent;
  final bool isPrimary;

  @override
  State<ConfidenceRowWidget> createState() => _ConfidenceRowWidgetState();
}

class _ConfidenceRowWidgetState extends State<ConfidenceRowWidget> {
  late ConfidenceRowModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConfidenceRowModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double value = (double.tryParse(widget.percent) ?? 0.0) / 100.0;
    bool isMain = (double.tryParse(widget.percent) ?? 0) >= 50;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  if (isMain) ...[
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(
                      widget.label,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: isMain ? FontWeight.bold : FontWeight.w500,
                        color: isMain
                            ? FlutterFlowTheme.of(context).primaryText
                            : FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: isMain
                  ? BoxDecoration(
                      color: FlutterFlowTheme.of(context).primary,
                      borderRadius: BorderRadius.circular(6),
                    )
                  : null,
              child: Text(
                '${widget.percent}%',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isMain
                      ? Colors.white
                      : FlutterFlowTheme.of(context).secondaryText,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: value.clamp(0.0, 1.0)),
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOutCubic,
          builder: (context, animValue, _) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(9999),
              child: Container(
                height: isMain ? 10 : 6,
                color: FlutterFlowTheme.of(context).alternate,
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: animValue,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: isMain
                          ? LinearGradient(
                              colors: [
                                FlutterFlowTheme.of(context).primary,
                                FlutterFlowTheme.of(context).secondary,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )
                          : null,
                      color: isMain ? null : const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
