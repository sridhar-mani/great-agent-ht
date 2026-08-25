import '/components/button/button_widget.dart';
import '/components/confidence_row/confidence_row_widget.dart';
import '/components/evidence_card/evidence_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'a_i_analysis_result_model.dart';
export 'a_i_analysis_result_model.dart';

class AIAnalysisResultWidget extends StatefulWidget {
  const AIAnalysisResultWidget({super.key});

  static String routeName = 'AIAnalysisResult';
  static String routePath = '/aIAnalysisResult';

  @override
  State<AIAnalysisResultWidget> createState() => _AIAnalysisResultWidgetState();
}

class _AIAnalysisResultWidgetState extends State<AIAnalysisResultWidget> {
  late AIAnalysisResultModel _model;
  bool isCallbackConfirmed = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AIAnalysisResultModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _showCallbackModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0F172A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF1A237E),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.indigoAccent, width: 2),
              ),
              child: const Icon(Icons.phone_in_talk_rounded, color: Colors.amberAccent, size: 30),
            ),
            const SizedBox(height: 12),
            Text(
              'ServiceOps AI Voice Agent',
              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              'Pre-Analyzed Clarification Call',
              style: GoogleFonts.roboto(fontSize: 12, color: Colors.indigoAccent),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF334155)),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI QUESTION (Adaptive Interviewer):',
                    style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.indigoAccent),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '"Hello Arun, telemetry confirms thermal shutdown. Does Generator ABC123 continue running when idle at no load?"',
                    style: GoogleFonts.roboto(fontSize: 13, color: Colors.white, fontStyle: FontStyle.italic, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        isCallbackConfirmed = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color(0xFF065F46),
                          content: Text('Answer "Yes" recorded. Confidence updated to 89%.'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.check, color: Colors.white, size: 18),
                    label: Text('Yes (Runs at Idle)', style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF64748B)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('No / Unsure', style: GoogleFonts.inter(color: Colors.white70)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSafeFixModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).warning10,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.shield_outlined, color: FlutterFlowTheme.of(context).onSurface, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Guided Safe Fix (Precautionary)',
                      style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold, color: FlutterFlowTheme.of(context).primaryText),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              'Safety Guard Agent note: No permanent remote fix approved for cooling restriction. Complete these checks before restart:',
              style: GoogleFonts.roboto(fontSize: 12, color: FlutterFlowTheme.of(context).secondaryText),
            ),
            const SizedBox(height: 16),
            _buildCheckStep('1', 'Allow Engine Cool Down (15 min)', 'Do not service hose assembly while block temp is > 60°C.'),
            const SizedBox(height: 10),
            _buildCheckStep('2', 'Inspect Hose Clamp Screw', 'Turn clockwise with 8mm driver 1.5 turns to check for slippage.'),
            const SizedBox(height: 10),
            _buildCheckStep('3', 'Check Expansion Tank Level', 'Verify fluid level is between MIN and MAX markers.'),
            const SizedBox(height: 20),
            ButtonWidget(
              content: 'Dispatch Technician Instead',
              variant: 'primary',
              size: 'large',
              fullWidth: true,
              onTap: () {
                Navigator.pop(context);
                context.goNamed('DispatchConfirmation');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckStep(String num, String title, String desc) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: FlutterFlowTheme.of(context).alternate),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(num, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: FlutterFlowTheme.of(context).primaryText)),
                const SizedBox(height: 2),
                Text(desc, style: GoogleFonts.roboto(fontSize: 11, color: FlutterFlowTheme.of(context).secondaryText)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSpecialistModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.support_agent_rounded, color: Color(0xFF1A237E), size: 40),
            const SizedBox(height: 10),
            Text(
              'Escalate to Senior Specialist',
              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: FlutterFlowTheme.of(context).primaryText),
            ),
            const SizedBox(height: 6),
            Text(
              'Direct high-priority audio connection to Cummins Level 3 Diagnostics Desk (Bangalore).',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(fontSize: 12, color: FlutterFlowTheme.of(context).secondaryText),
            ),
            const SizedBox(height: 20),
            ButtonWidget(
              content: 'Connect to Senior Engineer',
              variant: 'primary',
              size: 'large',
              fullWidth: true,
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Connecting to Cummins Engineering Desk...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Header
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8,
                            buttonSize: 38,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 22,
                            ),
                            onPressed: () {
                              context.goNamed('IssueReport');
                            },
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Analysis Complete',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle_rounded,
                                      color: FlutterFlowTheme.of(context).success,
                                      size: 13,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Diagnosed just now (14:33)',
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 11,
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.phone_in_talk, color: Color(0xFF1A237E)),
                            onPressed: _showCallbackModal,
                            tooltip: 'Trigger AI Callback',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: FlutterFlowTheme.of(context).alternate,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Evidence Summary Header
                      Text(
                        'Evidence Summary',
                        style: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Evidence Cards Row
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            EvidenceCardWidget(
                              icon: Icon(
                                Icons.image_rounded,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 16,
                              ),
                              label: 'Visual',
                              sub: 'Fluid staining: lower hose clamp',
                              tint: FlutterFlowTheme.of(context).primary,
                            ),
                            const SizedBox(width: 10),
                            EvidenceCardWidget(
                              icon: Icon(
                                Icons.graphic_eq_rounded,
                                color: FlutterFlowTheme.of(context).tertiary,
                                size: 16,
                              ),
                              label: 'Voice',
                              sub: 'Shutdown under load, ~10m',
                              tint: FlutterFlowTheme.of(context).tertiary,
                            ),
                            const SizedBox(width: 10),
                            EvidenceCardWidget(
                              icon: Icon(
                                Icons.history_rounded,
                                color: FlutterFlowTheme.of(context).error,
                                size: 16,
                              ),
                              label: 'History',
                              sub: '2nd cooling issue in 90 days',
                              tint: FlutterFlowTheme.of(context).error,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Fault Hypotheses
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Fault Hypotheses',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary5,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  child: Text(
                                    '3 similar cases found',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            const ConfidenceRowWidget(
                              label: 'Cooling restriction (recurring)',
                              percent: '71',
                              isPrimary: true,
                            ),
                            const SizedBox(height: 12),
                            const ConfidenceRowWidget(
                              label: 'Coolant circulation issue',
                              percent: '18',
                            ),
                            const SizedBox(height: 12),
                            const ConfidenceRowWidget(
                              label: 'Temperature sensor fault',
                              percent: '9',
                            ),
                            const SizedBox(height: 12),
                            const ConfidenceRowWidget(
                              label: 'Other',
                              percent: '2',
                            ),
                            const Divider(height: 24, thickness: 1),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.info_rounded,
                                  color: FlutterFlowTheme.of(context).info,
                                  size: 15,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    'Confidence based on visual evidence + asset history + 3 similar resolved cases',
                                    style: GoogleFonts.roboto(
                                      fontSize: 11,
                                      color: FlutterFlowTheme.of(context).secondaryText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      // Key Insight Alert Banner
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).warning10,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).warning30,
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.lightbulb_rounded,
                              color: FlutterFlowTheme.of(context).onSurface,
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Key Insight',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: FlutterFlowTheme.of(context).onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Last repair: hose clamp replacement by Agent Ravi, 6 months ago (Feb 2026)',
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: FlutterFlowTheme.of(context).primaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      // Action & Callback Section
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            InkWell(
                              onTap: _showCallbackModal,
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).success10,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: FlutterFlowTheme.of(context).success30),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context).success,
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.phone_in_talk_rounded,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'AI Callback Complete',
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              color: FlutterFlowTheme.of(context).primaryText,
                                            ),
                                          ),
                                          Text(
                                            'Confirmed: cooling restriction. Dispatch recommended.',
                                            style: GoogleFonts.roboto(
                                              fontSize: 11,
                                              color: FlutterFlowTheme.of(context).secondaryText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.refresh, size: 16, color: Colors.grey),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ButtonWidget(
                              icon: const Icon(
                                Icons.local_shipping_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              iconPresent: true,
                              content: 'Approve Dispatch',
                              variant: 'primary',
                              size: 'large',
                              fullWidth: true,
                              onTap: () {
                                context.goNamed('DispatchConfirmation');
                              },
                            ),
                            const SizedBox(height: 8),
                            ButtonWidget(
                              content: 'Try Safe Fix First',
                              variant: 'outline',
                              size: 'medium',
                              fullWidth: true,
                              onTap: _showSafeFixModal,
                            ),
                            const SizedBox(height: 4),
                            ButtonWidget(
                              content: 'Escalate to Specialist',
                              variant: 'ghost',
                              size: 'medium',
                              fullWidth: true,
                              onTap: _showSpecialistModal,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
