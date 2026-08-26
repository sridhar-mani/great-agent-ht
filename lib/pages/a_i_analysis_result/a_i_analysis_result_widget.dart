import '/components/button/button_widget.dart';
import '/components/confidence_row/confidence_row_widget.dart';
import '/components/evidence_card/evidence_card_widget.dart';
import '/components/in_call_agentic_troubleshooting/in_call_transcription_widget.dart';
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
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Workflow state flags
  bool initialTroubleshootingAttempted = false;
  bool initialTroubleshootingFailed = false;
  bool aiVoiceCallCompleted = false;
  String voiceCallAnswer = '';
  int coolingConfidence = 71;
  bool isSelfResolved = false;
  String resolvedBy = '';
  String certifiedRootCause = 'Cooling restriction at lower hose clamp assembly';

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

  // COMPULSORY AI VOICE AGENT CALL MODAL
  void _showAIVoiceCallModal({bool autoTriggered = false}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (dialogContext) => InCallTranscriptionWidget(
        assetId: 'ABC123',
        assetName: 'Generator Unit #1 (ABC123)',
        specialistName: 'Ravi Kumar (Field Specialist)',
        initialSymptom: 'ERR-704 Coolant Overheat Tripped on Generator ABC123',
        onCallComplete: ({
          required bool dispatchRequired,
          required String resolutionNotes,
          required int finalConfidence,
          required String resolvedBy,
          required String rootCause,
        }) {
          setState(() {
            aiVoiceCallCompleted = true;
            voiceCallAnswer = resolutionNotes;
            coolingConfidence = finalConfidence;
            isSelfResolved = !dispatchRequired;
            this.resolvedBy = resolvedBy;
            certifiedRootCause = rootCause;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: dispatchRequired
                  ? const Color(0xFF1E1B4B)
                  : const Color(0xFF065F46),
              content: Row(
                children: [
                  Icon(
                    dispatchRequired
                        ? Icons.local_shipping_rounded
                        : Icons.verified_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      dispatchRequired
                          ? 'AI Diagnostic Certified ($finalConfidence%). Specialist Ravi Kumar Dispatched!'
                          : 'Operator Self-Resolution Certified ($finalConfidence%). $resolvedBy logged to Freshworks!',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // GUIDED SAFE FIX / INITIAL TROUBLESHOOTING MODAL
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
                      child: Icon(Icons.shield_outlined,
                          color: FlutterFlowTheme.of(context).onSurface, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Initial Guided Safe-Fix Steps',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: FlutterFlowTheme.of(context).primaryText),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Safety Protocol: Execute these 3 non-invasive checks to test if thermal runaway can be mitigated before escalation:',
              style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: FlutterFlowTheme.of(context).secondaryText),
            ),
            const SizedBox(height: 16),
            _buildCheckStep('1', 'Allow Engine Cool Down (15 min)',
                'Do not service hose assembly while block temp is > 60°C.'),
            const SizedBox(height: 10),
            _buildCheckStep('2', 'Inspect Hose Clamp Torque',
                'Turn clockwise with 8mm driver 1.5 turns to check for bolt slip.'),
            const SizedBox(height: 10),
            _buildCheckStep('3', 'Verify Expansion Tank Level',
                'Ensure coolant reservoir level is between MIN and MAX marks.'),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: FlutterFlowTheme.of(context).alternate),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Restart Test Result (Under Load):',
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: FlutterFlowTheme.of(context).primaryText),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              initialTroubleshootingAttempted = true;
                              initialTroubleshootingFailed = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Color(0xFF065F46),
                                content: Text('Issue marked as resolved by safe-fix.'),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF10B981)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text('Resolved (Normal)',
                              style: GoogleFonts.spaceGrotesk(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF10B981))),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              initialTroubleshootingAttempted = true;
                              initialTroubleshootingFailed = true;
                            });
                            // Automatically launch the COMPULSORY AI Voice Agent Call
                            Future.delayed(const Duration(milliseconds: 300), () {
                              _showAIVoiceCallModal(autoTriggered: true);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEF4444),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text('Failed / Overheat Persists',
                              style: GoogleFonts.spaceGrotesk(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
            child: Text(num,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: FlutterFlowTheme.of(context).primaryText)),
                const SizedBox(height: 2),
                Text(desc,
                    style: GoogleFonts.roboto(
                        fontSize: 11,
                        color: FlutterFlowTheme.of(context).secondaryText)),
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
            const Icon(Icons.support_agent_rounded,
                color: Color(0xFF1A237E), size: 40),
            const SizedBox(height: 10),
            Text(
              'Escalate to Cummins Senior Desk',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: FlutterFlowTheme.of(context).primaryText),
            ),
            const SizedBox(height: 6),
            Text(
              'Direct high-priority audio line to Cummins Level 3 Engineering Support (Bangalore Hub).',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: FlutterFlowTheme.of(context).secondaryText),
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
                  const SnackBar(
                      content: Text('Connecting to Cummins Engineering Desk...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleDispatchAttempt() {
    if (!aiVoiceCallCompleted) {
      // Barred until AI call is completed!
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF1E293B),
          duration: const Duration(seconds: 4),
          content: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Compulsory Pathway: AI Voice Agent Diagnostic Call required before technician dispatch.',
                  style: GoogleFonts.roboto(fontSize: 12, color: Colors.white),
                ),
              ),
            ],
          ),
          action: SnackBarAction(
            label: 'Call AI',
            textColor: Colors.amberAccent,
            onPressed: () {
              _showAIVoiceCallModal();
            },
          ),
        ),
      );
      _showAIVoiceCallModal(autoTriggered: true);
    } else {
      context.goNamed('DispatchConfirmation');
    }
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
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
                                  'AI Analysis & Resolution',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).success,
                                      size: 13,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Multimodal Synthesis Complete (14:33)',
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 11,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.phone_in_talk,
                                color: Color(0xFF1A237E)),
                            onPressed: () => _showAIVoiceCallModal(),
                            tooltip: 'Trigger AI Voice Call',
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

              // Pathway Progress Ribbon
              Container(
                color: FlutterFlowTheme.of(context).primary.withOpacity(0.04),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPathwayStep('1. Analyze', true, true),
                    const Icon(Icons.chevron_right, size: 14, color: Colors.grey),
                    _buildPathwayStep(
                        '2. Safe-Fix',
                        initialTroubleshootingAttempted,
                        !initialTroubleshootingFailed),
                    const Icon(Icons.chevron_right, size: 14, color: Colors.grey),
                    _buildPathwayStep(
                        '3. AI Call',
                        initialTroubleshootingFailed || aiVoiceCallCompleted,
                        aiVoiceCallCompleted),
                    const Icon(Icons.chevron_right, size: 14, color: Colors.grey),
                    _buildPathwayStep('4. Dispatch', aiVoiceCallCompleted, false),
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
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        FlutterFlowTheme.of(context).primary5,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  child: Text(
                                    '3 similar cases found',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            ConfidenceRowWidget(
                              label: 'Cooling restriction (recurring)',
                              percent: '$coolingConfidence',
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
                                    'Confidence synthesized from OCR code ERR-704 + thermal staining + 3 historical work orders.',
                                    style: GoogleFonts.roboto(
                                      fontSize: 11,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
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
                                    'Key Predictive Insight',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color:
                                          FlutterFlowTheme.of(context).onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Last repair: hose clamp replacement by Specialist Ravi Kumar, 6 months ago (Feb 2026). High likelihood of repeat bolt fatigue.',
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // DYNAMIC PATHWAY ACTION CARD
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: aiVoiceCallCompleted
                                ? const Color(0xFF10B981)
                                : initialTroubleshootingFailed
                                    ? const Color(0xFFEF4444)
                                    : FlutterFlowTheme.of(context).alternate,
                            width: (aiVoiceCallCompleted || initialTroubleshootingFailed) ? 1.5 : 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // State 1: Troubleshooting Failed -> Compulsory Call Notification
                            if (initialTroubleshootingFailed && !aiVoiceCallCompleted) ...[
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF2F2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFFFCA5A5)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.error_outline_rounded,
                                        color: Color(0xFFDC2626), size: 20),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Initial Safe-Fix Failed • Escalation Triggered',
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: const Color(0xFF991B1B)),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            'Telemetry confirms thermal runaway persists. AI Voice Agent Call is COMPULSORY before field dispatch.',
                                            style: GoogleFonts.roboto(
                                                fontSize: 11,
                                                color: const Color(0xFFB91C1C)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 14),
                              ElevatedButton.icon(
                                onPressed: () => _showAIVoiceCallModal(),
                                icon: const Icon(Icons.phone_in_talk_rounded, color: Colors.white, size: 20),
                                label: Text(
                                  'Start Compulsory AI Voice Call',
                                  style: GoogleFonts.spaceGrotesk(
                                      fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: FlutterFlowTheme.of(context).primary,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ]
                            // State 2: AI Voice Call Complete
                            else if (aiVoiceCallCompleted) ...[
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).success10,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: FlutterFlowTheme.of(context).success30),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF10B981),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.verified_rounded,
                                          color: Colors.white, size: 18),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'AI Voice Call Complete & Certified',
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: const Color(0xFF065F46)),
                                          ),
                                          Text(
                                            'Response: "$voiceCallAnswer" • Parts reserved in Van #4',
                                            style: GoogleFonts.roboto(
                                                fontSize: 11,
                                                color: FlutterFlowTheme.of(context).secondaryText),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 14),
                              ButtonWidget(
                                icon: const Icon(
                                  Icons.local_shipping_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                iconPresent: true,
                                content: 'Approve & Confirm Dispatch',
                                variant: 'primary',
                                size: 'large',
                                fullWidth: true,
                                onTap: () {
                                  context.goNamed('DispatchConfirmation');
                                },
                              ),
                            ]
                            // State 3: Initial State (Not attempted yet)
                            else ...[
                              Text(
                                'Recommended Pathway Step 1',
                                style: GoogleFonts.spaceGrotesk(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Perform initial safe-fix checks. If unresolved, AI Voice Agent Call will automatically initiate.',
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                ),
                              ),
                              const SizedBox(height: 14),
                              ButtonWidget(
                                icon: const Icon(Icons.shield_outlined, color: Colors.white, size: 18),
                                iconPresent: true,
                                content: 'Try Initial Safe-Fix Troubleshooting',
                                variant: 'primary',
                                size: 'large',
                                fullWidth: true,
                                onTap: _showSafeFixModal,
                              ),
                              const SizedBox(height: 8),
                              ButtonWidget(
                                icon: const Icon(Icons.phone_in_talk_rounded, size: 16),
                                iconPresent: true,
                                content: 'Escalate to AI Voice Agent Call',
                                variant: 'outline',
                                size: 'medium',
                                fullWidth: true,
                                onTap: () => _showAIVoiceCallModal(),
                              ),
                            ],

                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: _showSpecialistModal,
                                  child: Text(
                                    'Connect to Senior Specialist',
                                    style: GoogleFonts.spaceGrotesk(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: FlutterFlowTheme.of(context).primary),
                                  ),
                                ),
                                InkWell(
                                  onTap: _handleDispatchAttempt,
                                  child: Text(
                                    'Direct Dispatch >',
                                    style: GoogleFonts.spaceGrotesk(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: aiVoiceCallCompleted
                                            ? const Color(0xFF10B981)
                                            : FlutterFlowTheme.of(context).secondaryText),
                                  ),
                                ),
                              ],
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

  Widget _buildPathwayStep(String label, bool isActive, bool isComplete) {
    Color color = isComplete
        ? const Color(0xFF10B981)
        : isActive
            ? FlutterFlowTheme.of(context).primary
            : FlutterFlowTheme.of(context).secondaryText;
    return Row(
      children: [
        Icon(
          isComplete
              ? Icons.check_circle_rounded
              : isActive
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_unchecked_rounded,
          size: 13,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 10,
            fontWeight: isActive || isComplete ? FontWeight.bold : FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}


