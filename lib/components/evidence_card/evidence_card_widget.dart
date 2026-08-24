import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'evidence_card_model.dart';
export 'evidence_card_model.dart';

class EvidenceCardWidget extends StatefulWidget {
  const EvidenceCardWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.sub,
    required this.tint,
  });

  final Widget icon;
  final String label;
  final String sub;
  final Color tint;

  @override
  State<EvidenceCardWidget> createState() => _EvidenceCardWidgetState();
}

class _EvidenceCardWidgetState extends State<EvidenceCardWidget> {
  late EvidenceCardModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EvidenceCardModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: widget.tint.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: widget.icon,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.sub,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              fontSize: 11,
              color: FlutterFlowTheme.of(context).secondaryText,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
