import '/components/button/button_widget.dart';
import '/components/in_call_agentic_troubleshooting/in_call_transcription_widget.dart';
import '/components/step_indicator/step_indicator_widget.dart';
import '/data/plant_asset_data.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'issue_report_model.dart';
export 'issue_report_model.dart';

class IssueReportWidget extends StatefulWidget {
  final String? initialAssetId;
  const IssueReportWidget({super.key, this.initialAssetId});

  static String routeName = 'IssueReport';
  static String routePath = '/issueReport';

  @override
  State<IssueReportWidget> createState() => _IssueReportWidgetState();
}

class _IssueReportWidgetState extends State<IssueReportWidget> {
  late IssueReportModel _model;
  bool isPlayingAudio = false;
  bool showHeatmap = true;
  String faultCode = 'ERR-704 (Coolant Overheat)';
  late List<PlantAsset> _fleetAssets;
  late PlantAsset _selectedAsset;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IssueReportModel());
    _fleetAssets = PlantAssetRepository.getInitialFleet();
    _selectedAsset = _fleetAssets.firstWhere(
      (a) => a.id == widget.initialAssetId,
      orElse: () => _fleetAssets.first,
    );
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _showInCallTroubleshootingModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (dialogContext) => InCallTranscriptionWidget(
        assetId: _selectedAsset.id,
        assetName: _selectedAsset.name,
        initialSymptom: _selectedAsset.defaultSymptom,
        onCallComplete: ({
          required bool dispatchRequired,
          required String resolutionNotes,
          required int finalConfidence,
          required String resolvedBy,
          required String rootCause,
        }) {
          context.goNamed('AIAnalysisResult');
        },
      ),
    );
  }

  void _triggerAIInvestigation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const _AIInvestigationDialog();
      },
    );
  }

  void _showOCRScannerModal() {
    showModalBottomSheet(
      context: context,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.qr_code_scanner_rounded, color: Colors.indigoAccent),
                    const SizedBox(width: 8),
                    Text(
                      'OCR Fault Scanner',
                      style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white70),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.indigoAccent, width: 2),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('DETECTED ON PANEL:', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.indigoAccent)),
                  const SizedBox(height: 4),
                  Text('ERR-704: COOLANT TEMP CRITICAL', style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.amberAccent)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ButtonWidget(
              content: 'Attach Code to Evidence',
              variant: 'primary',
              size: 'large',
              fullWidth: true,
              onTap: () {
                setState(() {
                  faultCode = 'ERR-704: COOLANT TEMP CRITICAL';
                });
                Navigator.pop(context);
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 8,
                                buttonSize: 38,
                                fillColor: Colors.transparent,
                                icon: const Icon(Icons.arrow_back_rounded, size: 22),
                                onPressed: () {
                                  context.goNamed('AssetDashboard');
                                },
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Report Issue',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                            ],
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 8,
                            buttonSize: 38,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.help_outline_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 22,
                            ),
                            onPressed: () {},
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
                      // Steps
                      Column(
                        children: [
                          const StepIndicatorWidget(activeStep: '1'),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '1. Upload Evidence',
                                style: GoogleFonts.spaceGrotesk(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                              Text(
                                '2. AI Analysis',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 11,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                ),
                              ),
                              Text(
                                '3. Resolution',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 11,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Asset Pill
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary5,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).primary20,
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: const Icon(
                                    Icons.settings_input_component_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _selectedAsset.name,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                    Text(
                                      '${_selectedAsset.productModel} · ${_selectedAsset.location}',
                                      style: GoogleFonts.roboto(
                                        fontSize: 11,
                                        color: FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                _selectedAsset.id,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Visual Evidence
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Visual Evidence',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                showHeatmap = !showHeatmap;
                              });
                            },
                            child: Text(
                              showHeatmap ? 'Heatmap: ON' : 'Heatmap: OFF',
                              style: GoogleFonts.spaceGrotesk(fontSize: 11, fontWeight: FontWeight.bold, color: FlutterFlowTheme.of(context).primary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          height: 180,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.5,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(
                                  Icons.precision_manufacturing_rounded,
                                  size: 80,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              if (showHeatmap)
                                Positioned(
                                  top: 40,
                                  right: 60,
                                  child: Container(
                                    width: 85,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.amber.withOpacity(0.25),
                                      border: Border.all(color: Colors.amber, width: 2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          color: Colors.amber,
                                          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                                          child: const Text(
                                            'LEAK 85%',
                                            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                        ),
                                        const Spacer(),
                                        const Text('[Lower Clamp]', style: TextStyle(color: Colors.amberAccent, fontSize: 8)),
                                      ],
                                    ),
                                  ),
                                ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  color: Colors.black87,
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check_circle_rounded,
                                        color: FlutterFlowTheme.of(context).success,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Photo captured: Fluid leak detected at lower clamp',
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 11,
                                          color: Colors.white,
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
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          ButtonWidget(
                            icon: const Icon(Icons.photo_camera, size: 16),
                            iconPresent: true,
                            content: 'Retake Photo',
                            variant: 'outline',
                            size: 'small',
                            onTap: () {},
                          ),
                          const SizedBox(width: 8),
                          ButtonWidget(
                            icon: const Icon(Icons.add_a_photo, size: 16),
                            iconPresent: true,
                            content: 'Add Close-up',
                            variant: 'ghost',
                            size: 'small',
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      // Voice Description
                      Text(
                        'Voice Description',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      const SizedBox(height: 8),
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
                          children: [
                            Row(
                              children: [
                                FlutterFlowIconButton(
                                  borderRadius: 999,
                                  buttonSize: 40,
                                  fillColor: FlutterFlowTheme.of(context).primary10,
                                  icon: Icon(
                                    isPlayingAudio ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 22,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPlayingAudio = !isPlayingAudio;
                                    });
                                  },
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '0:08 / 0:15',
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 11,
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Stack(
                                        children: [
                                          Container(
                                            height: 4,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context).alternate,
                                              borderRadius: BorderRadius.circular(999),
                                            ),
                                          ),
                                          Container(
                                            height: 4,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context).primary,
                                              borderRadius: BorderRadius.circular(999),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '"Generator shuts down after 10 minutes under load"',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontStyle: FontStyle.italic,
                                fontSize: 13,
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ButtonWidget(
                              icon: const Icon(Icons.mic_rounded, size: 18),
                              iconPresent: true,
                              content: 'Hold to record more',
                              variant: 'secondary',
                              size: 'medium',
                              fullWidth: true,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      // Fault Code OCR
                      InkWell(
                        onTap: _showOCRScannerModal,
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.qr_code_scanner_rounded,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Fault Code (OCR Scanner)',
                                        style: GoogleFonts.roboto(
                                          fontSize: 13,
                                          color: FlutterFlowTheme.of(context).primaryText,
                                        ),
                                      ),
                                      Text(
                                        faultCode,
                                        style: GoogleFonts.roboto(
                                          fontSize: 11,
                                          color: FlutterFlowTheme.of(context).primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: FlutterFlowTheme.of(context).secondaryText,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ButtonWidget(
                        icon: const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
                        iconPresent: true,
                        content: 'Analyze Evidence with AI',
                        variant: 'primary',
                        size: 'large',
                        fullWidth: true,
                        onTap: _triggerAIInvestigation,
                      ),
                      const SizedBox(height: 8),
                      ButtonWidget(
                        icon: Icon(Icons.phone_in_talk_rounded, color: FlutterFlowTheme.of(context).primary, size: 18),
                        iconPresent: true,
                        content: 'Start Live AI Diagnostic Call',
                        variant: 'secondary',
                        size: 'medium',
                        fullWidth: true,
                        onTap: _showInCallTroubleshootingModal,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).info10,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_rounded,
                              color: FlutterFlowTheme.of(context).onInfo,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'AI will analyze photo, transcribe voice, and check asset history to find a resolution.',
                                style: GoogleFonts.roboto(
                                  fontSize: 11,
                                  color: FlutterFlowTheme.of(context).onInfo,
                                ),
                              ),
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

class _AIInvestigationDialog extends StatefulWidget {
  const _AIInvestigationDialog();

  @override
  State<_AIInvestigationDialog> createState() => _AIInvestigationDialogState();
}

class _AIInvestigationDialogState extends State<_AIInvestigationDialog> {
  int currentStep = 1;

  @override
  void initState() {
    super.initState();
    _runSimulation();
  }

  void _runSimulation() async {
    await Future.delayed(const Duration(milliseconds: 700));
    if (mounted) setState(() => currentStep = 2);
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => currentStep = 3);
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => currentStep = 4);
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => currentStep = 5);
    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) {
      Navigator.pop(context);
      context.goNamed('AIAnalysisResult');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF0F172A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: const Color(0xFF1A237E),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.indigoAccent, width: 2),
              ),
              alignment: Alignment.center,
              child: const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amberAccent),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'AI is Investigating',
              style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              'Synthesizing multimodal diagnostics for Generator ABC123',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(fontSize: 11, color: Colors.indigoAccent),
            ),
            const SizedBox(height: 20),
            _buildCheckItem(1, 'Analyzing fluid leak & hose clamp staining (85%)'),
            const SizedBox(height: 8),
            _buildCheckItem(2, 'Transcribing voice acoustic signature (90%)'),
            const SizedBox(height: 8),
            _buildCheckItem(3, 'Querying Freshworks MCP telemetry logs'),
            const SizedBox(height: 8),
            _buildCheckItem(4, 'Matching past repairs by Agent Ravi (Feb 2026)'),
            const SizedBox(height: 8),
            _buildCheckItem(5, 'Synthesizing fault probability matrix'),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckItem(int step, String label) {
    bool isDone = currentStep > step;
    bool isCurrent = currentStep == step;

    return Row(
      children: [
        if (isDone)
          const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 16)
        else if (isCurrent)
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.indigoAccent)),
          )
        else
          const Icon(Icons.circle_outlined, color: Color(0xFF475569), size: 16),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 11,
              color: isDone || isCurrent ? Colors.white : const Color(0xFF64748B),
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
