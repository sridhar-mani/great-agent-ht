import 'dart:async';
import 'dart:math' as math;
import '/components/feedback/post_call_feedback_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'in_call_transcription_model.dart';
export 'in_call_transcription_model.dart';

/// Data class representing a transcript line in the in-call stream.
class TranscriptMessage {
  final String id;
  final String speaker; // 'operator' | 'ai' | 'system' | 'human_agent'
  final String message;
  final String timestamp;
  final List<String> entities;
  final String? toolInvocation;

  TranscriptMessage({
    required this.id,
    required this.speaker,
    required this.message,
    required this.timestamp,
    this.entities = const [],
    this.toolInvocation,
  });
}

class InCallTranscriptionWidget extends StatefulWidget {
  const InCallTranscriptionWidget({
    super.key,
    required this.onCallComplete,
    this.initialSymptom = 'ERR-704 Coolant Overheat after 10m load',
    this.assetId = 'ABC123',
    this.assetName = 'Generator Unit #1 (ABC123)',
    this.specialistName = 'Ravi Kumar (Lead Field Specialist)',
  });

  final String initialSymptom;
  final String assetId;
  final String assetName;
  final String specialistName;
  final void Function({
    required bool dispatchRequired,
    required String resolutionNotes,
    required int finalConfidence,
    required String resolvedBy,
    required String rootCause,
  }) onCallComplete;

  @override
  State<InCallTranscriptionWidget> createState() =>
      _InCallTranscriptionWidgetState();
}

class _InCallTranscriptionWidgetState extends State<InCallTranscriptionWidget>
    with TickerProviderStateMixin {
  late InCallTranscriptionModel _model;
  final ScrollController _scrollController = ScrollController();

  // Animation Controllers
  late AnimationController _voiceOrbController;
  late AnimationController _pulseController;
  late AnimationController _waveController;

  // Call timer state
  Timer? _callTimer;
  int _callSeconds = 14; // start at 14s for realistic demo

  // Dynamic Call States:
  // 1: Connecting / Greeting
  // 2: Step 1 (Symptom Isolation)
  // 3: AI Reasoning / MCP Tool Lookup
  // 4: Step 2 (Guided Physical Test)
  // 5: Diagnostic Synthesis
  // 6: Call Finalized (Resolution Certified)
  int _callStage = 1;

  // View Mode: 'hud' (Voice Calling Visualizer) or 'transcript' (Full Live Transcript)
  String _activeViewMode = 'hud';

  // Live Audio & In-Call States
  bool _isMuted = false;
  bool _isSpeakerOn = true;
  bool _isCameraActive = false;
  bool _aiSpeaking = true;
  bool _operatorSpeaking = false;
  bool _humanSpeaking = false;
  bool _isSynthesizing = false;

  // Human Escalation States
  bool _isEscalatedToHuman = false;
  bool _isBriefingExpanded = true;
  final String _humanAgentName = 'Ravi Kumar';
  final String _humanAgentRole = 'Lead Field Specialist (Peenya Desk)';

  // Dynamic Live Telemetry values
  double _telemetryTemp = 98.4;
  double _telemetryPressure = 1.42;
  int _diagnosticConfidence = 71;
  String _liveFeedbackStatus =
      'Apex-7 connected • Synchronizing SCADA telemetry...';

  // Selected paths for branching
  String _selectedSymptom = '';
  String _selectedActionTest = '';
  bool _isSelfResolved = false;
  String _detectedRootCause =
      'Cooling restriction at lower hose clamp assembly';

  // Live Transcript Stream
  final List<TranscriptMessage> _transcript = [];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InCallTranscriptionModel());

    _voiceOrbController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..repeat(reverse: true);

    _startCallTimer();
    _initializeCallTranscript();
  }

  @override
  void dispose() {
    _callTimer?.cancel();
    _voiceOrbController.dispose();
    _pulseController.dispose();
    _waveController.dispose();
    _scrollController.dispose();
    _model.dispose();
    super.dispose();
  }

  void _startCallTimer() {
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _callSeconds++;
        });
      }
    });
  }

  String _formatDuration(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _initializeCallTranscript() {
    _transcript.addAll([
      TranscriptMessage(
        id: 'msg_0',
        speaker: 'operator',
        message:
            'Apex, generator ABC123 tripped with ERR-704 after running under 80% load for 10 minutes. There is fluid residue near the bottom fitting.',
        timestamp: '14:23:02',
        entities: ['ERR-704', '80% Load', 'Bottom Fitting'],
      ),
      TranscriptMessage(
        id: 'msg_1',
        speaker: 'ai',
        message:
            'Hello Arun. Connected to Cummins 500KVA (ABC123). I am pulling telemetry and Freshworks records now.',
        timestamp: '14:23:05',
        toolInvocation:
            'Freshworks MCP: fetchAssetRecord("ABC123") -> Matched 2 cooling tickets in 90d.',
      ),
      TranscriptMessage(
        id: 'msg_2',
        speaker: 'ai',
        message:
            'Based on acoustic and photo evidence, coolant restriction is 71% probable. Let\'s perform a live isolation check while the engine cools down.',
        timestamp: '14:23:09',
        entities: ['71% Cooling Restriction', 'Cummins QSK19'],
      ),
    ]);

    // Transition to Stage 2 (Prompt 1)
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _callStage = 2;
          _aiSpeaking = false;
          _liveFeedbackStatus = 'Awaiting symptom isolation from operator...';
        });
        _scrollToBottom();
      }
    });
  }

  // Branch 1: User selects symptom observation
  void _onSelectSymptom(String symptom, String operatorSpoken, String toolLog) {
    setState(() {
      _selectedSymptom = symptom;
      _operatorSpeaking = true;
      _aiSpeaking = false;
      _isSynthesizing = true;
      _callStage = 3;
      _liveFeedbackStatus = 'Transmitting operator audio response...';

      _transcript.add(TranscriptMessage(
        id: 'user_symptom_${DateTime.now().millisecondsSinceEpoch}',
        speaker: 'operator',
        message: operatorSpoken,
        timestamp: _formatDuration(_callSeconds),
      ));
    });
    _scrollToBottom();

    // AI agent reasons with tools
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() {
        _operatorSpeaking = false;
        _aiSpeaking = true;
        _isSynthesizing = false;
        _callStage = 4;

        if (symptom == 'fluid_dripping') {
          _diagnosticConfidence = 89;
          _telemetryPressure = 1.38;
          _liveFeedbackStatus =
              'AI matched OEM §4.2 specs: 28 Nm torque required.';
          _detectedRootCause =
              'Elastomeric hose clamp fatigue & torque degradation (HC-500)';
          _transcript.add(TranscriptMessage(
            id: 'ai_tool_${DateTime.now().millisecondsSinceEpoch}',
            speaker: 'ai',
            message:
                'Telemetry confirms coolant expansion pressure is 1.4 bar. OEM manual §4.2 specifies 28 Nm on the lower hose clamp. Let\'s check the clamp bolt torque with an 8mm driver.',
            timestamp: _formatDuration(_callSeconds),
            toolInvocation: toolLog,
            entities: ['OEM §4.2 Specs: 28 Nm', 'Pressure: 1.4 bar'],
          ));
        } else if (symptom == 'steam_venting') {
          _diagnosticConfidence = 84;
          _telemetryTemp = 99.1;
          _liveFeedbackStatus =
              'Safety alert: Over-pressurization >1.1 bar cap rating.';
          _detectedRootCause =
              'Expansion tank 16 PSI pressure relief cap spring failure';
          _transcript.add(TranscriptMessage(
            id: 'ai_tool_${DateTime.now().millisecondsSinceEpoch}',
            speaker: 'ai',
            message:
                'Steam indicates over-pressurization exceeding 1.1 bar cap rating. Safety protocol: Do not open expansion cap while hot. Let\'s check the cap gasket seal.',
            timestamp: _formatDuration(_callSeconds),
            toolInvocation: toolLog,
            entities: ['Safety Alert: High Temp', 'Cap Rating: 16 PSI'],
          ));
        } else {
          _diagnosticConfidence = 78;
          _telemetryTemp = 97.8;
          _liveFeedbackStatus =
              'SCADA anomaly profile indicates air lock in manifold.';
          _detectedRootCause =
              'Entrapped air pocket in upper radiator manifold (Air Lock)';
          _transcript.add(TranscriptMessage(
            id: 'ai_tool_${DateTime.now().millisecondsSinceEpoch}',
            speaker: 'ai',
            message:
                'Dry overheat with normal coolant level often points to air lock. Let\'s check the brass bleeder valve #BV-2 on the upper radiator manifold.',
            timestamp: _formatDuration(_callSeconds),
            toolInvocation: toolLog,
            entities: ['Air Lock Protocol', 'Bleeder Valve #BV-2'],
          ));
        }
      });
      _scrollToBottom();
    });
  }

  // Branch 2: User completes actionable in-call test
  void _onSelectActionTest({
    required String testOutcome,
    required String operatorSpoken,
    required bool selfResolved,
    required int finalConfidence,
    required String aiFinalDialogue,
    required String toolFinalLog,
  }) {
    setState(() {
      _selectedActionTest = testOutcome;
      _isSelfResolved = selfResolved;
      _diagnosticConfidence = finalConfidence;
      _operatorSpeaking = true;
      _aiSpeaking = false;
      _isSynthesizing = true;
      _callStage = 5;
      _liveFeedbackStatus = 'Verifying test outcome with telemetry stream...';

      _transcript.add(TranscriptMessage(
        id: 'user_action_${DateTime.now().millisecondsSinceEpoch}',
        speaker: 'operator',
        message: operatorSpoken,
        timestamp: _formatDuration(_callSeconds),
      ));
    });
    _scrollToBottom();

    // AI Finalizes Diagnosis & Requisitions Parts / Certifies Resolution
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      setState(() {
        _operatorSpeaking = false;
        _aiSpeaking = true;
        _isSynthesizing = false;
        _callStage = 6;

        if (selfResolved) {
          _telemetryTemp = 84.1;
          _telemetryPressure = 1.08;
          _liveFeedbackStatus =
              'Resolution Certified: Temp stabilized at 84°C (Self-Resolved).';
        } else {
          _liveFeedbackStatus =
              'Resolution Certified: Dispatching Specialist Ravi Kumar (ETA 12m).';
        }

        _transcript.add(TranscriptMessage(
          id: 'ai_final_${DateTime.now().millisecondsSinceEpoch}',
          speaker: 'ai',
          message: aiFinalDialogue,
          timestamp: _formatDuration(_callSeconds),
          toolInvocation: toolFinalLog,
          entities: selfResolved
              ? ['Status: Self-Resolved', 'Confidence: $finalConfidence%']
              : [
                  'Status: Dispatch Certified',
                  'Confidence: $finalConfidence%',
                  'Part: OEM HC-500'
                ],
        ));
      });
      _scrollToBottom();
    });
  }

  // ESCALATE TO HUMAN SERVICE AGENT (RAVI KUMAR) WITH AUTOMATED SUMMARY HANDOVER
  void _escalateToHumanServiceAgent() {
    if (_isEscalatedToHuman) return;

    setState(() {
      _isEscalatedToHuman = true;
      _humanSpeaking = false;
      _aiSpeaking = false;
      _operatorSpeaking = false;
      _liveFeedbackStatus =
          'Connecting to Service Desk: Specialist Ravi Kumar (Van #4)...';
    });

    _transcript.add(TranscriptMessage(
      id: 'escalate_sys_${DateTime.now().millisecondsSinceEpoch}',
      speaker: 'system',
      message:
          '⚡ Live Call Escalated to Human Service Agent: Ravi Kumar (Lead Field Specialist). Transmitting real-time AI Diagnostic Handover Package & SCADA telemetry.',
      timestamp: _formatDuration(_callSeconds),
      toolInvocation:
          'Freshworks Dispatch: Transmitted Handover Briefing to Tech Ravi Kumar (ETA 12m). Status: 3-WAY CONFERENCE ACTIVE.',
      entities: ['3-Way Conference', 'Handover Transmitted', 'Tech Ravi Kumar'],
    ));
    _scrollToBottom();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color(0xFF1E1B4B),
        content: Text(
          '📞 Escalated to Human Field Specialist Ravi Kumar. Transmitting live diagnostic briefing & asset history...',
        ),
      ),
    );

    // Human Specialist joins call with spoken response
    Future.delayed(const Duration(milliseconds: 1600), () {
      if (!mounted) return;
      setState(() {
        _humanSpeaking = true;
        _liveFeedbackStatus =
            'Specialist Ravi Kumar joined call • Reviewing live briefing...';
        _transcript.add(TranscriptMessage(
          id: 'human_agent_${DateTime.now().millisecondsSinceEpoch}',
          speaker: 'human_agent',
          message:
              'Hello Arun, Ravi here from Peenya Field Desk. I just reviewed Apex-7\'s live handover package and SCADA telemetry. I see the 98°C coolant spike and the hose clamp thread failure. I have OEM Kit #HC-500 pre-reserved in Van #4 and I am en route (ETA 12m). Please keep the engine idling with zero load while I arrive.',
          timestamp: _formatDuration(_callSeconds),
          entities: [
            'Specialist Ravi Kumar',
            'Part #HC-500 Reserved',
            'ETA: 12m'
          ],
        ));
      });
      _scrollToBottom();
    });
  }

  void _finishAndSubmitCall() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (feedbackCtx) => PostCallFeedbackWidget(
        assetId: widget.assetId,
        assetName: widget.assetName,
        specialistName: _isEscalatedToHuman
            ? 'Ravi Kumar (Lead Specialist)'
            : 'Ravi Kumar (Field Specialist)',
        ticketId: 'SR-8924',
        diagnosticSummary: _detectedRootCause,
        onSubmitted: (feedbackResult) {
          Navigator.pop(feedbackCtx); // Close feedback dialog
          Navigator.pop(context); // Close in-call dialog
          final notesDetail = feedbackResult.aiTrainingNotes.isNotEmpty
              ? ' AI Retraining Feedback: "${feedbackResult.aiTrainingNotes}".'
              : '';
          widget.onCallComplete(
            dispatchRequired: !_isSelfResolved,
            resolutionNotes: _isSelfResolved
                ? 'Operator self-resolved via guided 8mm torque. Dual CSAT: ${feedbackResult.agentRating}/5 (AI) & ${feedbackResult.specialistRating}/5 (Tech).$notesDetail'
                : 'Diagnostic certified: $_detectedRootCause. Dispatched Tech Ravi Kumar. Dual CSAT: ${feedbackResult.agentRating}/5 (AI) & ${feedbackResult.specialistRating}/5 (Tech).$notesDetail',
            finalConfidence: _diagnosticConfidence,
            resolvedBy: _isSelfResolved
                ? 'Operator (Customer Self-Fix)'
                : (_isEscalatedToHuman
                    ? 'Ravi Kumar (Lead Specialist) & Apex-7 AI'
                    : 'Ravi Kumar (L3 Field Specialist)'),
            rootCause: _detectedRootCause,
          );
        },
        onDismissed: () {
          Navigator.pop(feedbackCtx); // Close feedback dialog
          Navigator.pop(context); // Close in-call dialog
          widget.onCallComplete(
            dispatchRequired: !_isSelfResolved,
            resolutionNotes: _isSelfResolved
                ? 'Operator Arun Kumar resolved hose clamp leakage via guided 8mm torque retighten.'
                : 'Diagnostic certified: $_detectedRootCause. Dispatched Tech Ravi Kumar.',
            finalConfidence: _diagnosticConfidence,
            resolvedBy: _isSelfResolved
                ? 'Operator Arun Kumar (Customer Self-Fix)'
                : (_isEscalatedToHuman
                    ? 'Ravi Kumar (Lead Specialist) & Apex-7 AI'
                    : 'Ravi Kumar (L3 Field Specialist)'),
            rootCause: _detectedRootCause,
          );
        },
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF8FAFC),
                  Color(0xFFF1F5F9),
                  Color(0xFFFFFFFF),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                // 1. TOP HEADER: CALL STATUS & PARTICIPANT HUD (3-WAY CONFERENCE AWARE)
                _buildInCallHeader(),

                // 2. LIVE TELEMETRY & CONFIDENCE HUD STRIP
                _buildLiveTelemetryHud(),

                // 3. LIVE FEEDBACK BANNER (AI / HUMAN / OPERATOR STATE)
                _buildLiveFeedbackBanner(),

                // 4. MAIN INTERACTIVE CONTENT AREA (VOICE HUD or TRANSCRIPT)
                Expanded(
                  child: _activeViewMode == 'hud'
                      ? _buildVoiceHudView()
                      : _buildTranscriptStreamView(),
                ),

                // 5. STEP-BY-STEP GUIDED INTERACTIVE PROMPT DRAWER
                _buildDynamicPromptArea(),

                // 6. BOTTOM CALL CONTROLS DOCK
                _buildBottomCallControls(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 1. TOP CALL HEADER HUD
  Widget _buildInCallHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Column(
        children: [
          // Row 1: Live Call Indicator & Meta Badges
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Live Status Pill
              Row(
                children: [
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, _) => Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: _isEscalatedToHuman
                            ? const Color(0xFF0284C7)
                            : (_callStage == 6
                                ? const Color(0xFF10B981)
                                : const Color(0xFFEF4444)),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (_isEscalatedToHuman
                                    ? const Color(0xFF0284C7)
                                    : (_callStage == 6
                                        ? const Color(0xFF10B981)
                                        : const Color(0xFFEF4444)))
                                .withOpacity(0.5 * _pulseController.value),
                            blurRadius: 8 * _pulseController.value,
                            spreadRadius: 1.5,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isEscalatedToHuman
                        ? '3-WAY CONFERENCE • ${_formatDuration(_callSeconds)}'
                        : (_callStage == 6
                            ? 'DIAGNOSTIC CERTIFIED • ${_formatDuration(_callSeconds)}'
                            : 'LIVE AI CALL • ${_formatDuration(_callSeconds)}'),
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: _isEscalatedToHuman
                          ? const Color(0xFF0369A1)
                          : (_callStage == 6
                              ? const Color(0xFF047857)
                              : const Color(0xFFB91C1C)),
                    ),
                  ),
                ],
              ),

              // Audio Quality & View Toggle
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.graphic_eq_rounded,
                            size: 12, color: Color(0xFF0284C7)),
                        const SizedBox(width: 4),
                        Text(
                          'HD Voice',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0284C7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // View Switcher (HUD / Transcript)
                  InkWell(
                    onTap: () {
                      setState(() {
                        _activeViewMode =
                            _activeViewMode == 'hud' ? 'transcript' : 'hud';
                      });
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _activeViewMode == 'transcript'
                            ? const Color(0xFFEEF2FF)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _activeViewMode == 'transcript'
                              ? const Color(0xFF6366F1)
                              : const Color(0xFFCBD5E1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _activeViewMode == 'transcript'
                                ? Icons.phone_in_talk_rounded
                                : Icons.subtitles_rounded,
                            size: 13,
                            color: _activeViewMode == 'transcript'
                                ? const Color(0xFF4F46E5)
                                : const Color(0xFF475569),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _activeViewMode == 'transcript'
                                ? 'Voice HUD'
                                : 'Transcript',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _activeViewMode == 'transcript'
                                  ? const Color(0xFF4F46E5)
                                  : const Color(0xFF334155),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Row 2: Participants Banner (Shows Human Specialist when escalated)
          Row(
            children: [
              // AI Core Avatar or Multi-avatar
              if (!_isEscalatedToHuman) ...[
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF0284C7),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0284C7).withOpacity(0.15),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/images/app_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Apex-7 Diagnostic Core',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0F2FE),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: const Color(0xFFBAE6FD)),
                            ),
                            child: Text(
                              'QSK19 Engine AI',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0284C7),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Connected to Arun Kumar • Cummins 500KVA (ABC123)',
                        style: GoogleFonts.roboto(
                          fontSize: 11,
                          color: const Color(0xFF64748B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // Escalated 3-Way Conference Banner
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0284C7), Color(0xFF10B981)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.engineering_rounded,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _humanAgentName,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0F2FE),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: const Color(0xFFBAE6FD), width: 0.8),
                            ),
                            child: Text(
                              'Field Specialist Live',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0369A1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '3-Way Call: Arun Kumar + Apex-7 AI Co-Pilot + Ravi Kumar',
                        style: GoogleFonts.roboto(
                          fontSize: 10,
                          color: const Color(0xFF64748B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // 2. LIVE TELEMETRY & CONFIDENCE HUD
  Widget _buildLiveTelemetryHud() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Telemetry Temp Metric
          _buildTelemetryMetricChip(
            icon: Icons.thermostat_rounded,
            label: 'Coolant Temp',
            value: '${_telemetryTemp.toStringAsFixed(1)}°C',
            valueColor: _telemetryTemp < 86
                ? const Color(0xFF059669)
                : (_telemetryTemp > 95
                    ? const Color(0xFFDC2626)
                    : const Color(0xFFD97706)),
          ),
          // Pressure Metric
          _buildTelemetryMetricChip(
            icon: Icons.compress_rounded,
            label: 'Manifold Pressure',
            value: '${_telemetryPressure.toStringAsFixed(2)} bar',
            valueColor: _telemetryPressure <= 1.15
                ? const Color(0xFF059669)
                : const Color(0xFFD97706),
          ),
          // Diagnostic Confidence Meter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: _diagnosticConfidence >= 90
                  ? const Color(0xFFECFDF5)
                  : const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _diagnosticConfidence >= 90
                    ? const Color(0xFFA7F3D0)
                    : const Color(0xFFBFDBFE),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.verified_rounded,
                  size: 13,
                  color: _diagnosticConfidence >= 90
                      ? const Color(0xFF059669)
                      : const Color(0xFF2563EB),
                ),
                const SizedBox(width: 4),
                Text(
                  'Confidence: $_diagnosticConfidence%',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _diagnosticConfidence >= 90
                        ? const Color(0xFF065F46)
                        : const Color(0xFF1E40AF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTelemetryMetricChip({
    required IconData icon,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 14, color: valueColor),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 8.5,
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 3. LIVE FEEDBACK BANNER (ACTIVE STATE FEEDBACK)
  Widget _buildLiveFeedbackBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: _isMuted
            ? const Color(0xFFFEF2F2)
            : (_operatorSpeaking
                ? const Color(0xFFECFDF5)
                : (_humanSpeaking
                    ? const Color(0xFFF0F9FF)
                    : const Color(0xFFEFF6FF))),
        border: Border(
          bottom: BorderSide(
            color: _isMuted
                ? const Color(0xFFFECACA)
                : (_operatorSpeaking
                    ? const Color(0xFFA7F3D0)
                    : (_humanSpeaking
                        ? const Color(0xFFBAE6FD)
                        : const Color(0xFFBFDBFE))),
          ),
        ),
      ),
      child: Row(
        children: [
          if (_isMuted) ...[
            const Icon(Icons.mic_off_rounded,
                size: 14, color: Color(0xFFDC2626)),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'Microphone Muted • Other participants cannot hear you',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF991B1B),
                ),
              ),
            ),
          ] else if (_operatorSpeaking) ...[
            const Icon(Icons.record_voice_over_rounded,
                size: 14, color: Color(0xFF059669)),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'Operator Arun speaking... Transmitting audio to call stream',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF065F46),
                ),
              ),
            ),
          ] else if (_humanSpeaking) ...[
            const Icon(Icons.support_agent_rounded,
                size: 14, color: Color(0xFF0284C7)),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'Specialist Ravi Kumar speaking (Peenya Field Desk)...',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF075985),
                ),
              ),
            ),
          ] else if (_isSynthesizing) ...[
            const SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Apex-7 reasoning with Freshworks MCP & Cummins Knowledge Core...',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1D4ED8),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ] else ...[
            const Icon(Icons.auto_awesome, size: 14, color: Color(0xFF2563EB)),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                _liveFeedbackStatus,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E40AF),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // 4. MAIN VOICE HUD VIEW (GLOWING ORB + LIVE DIALOGUE BANNER + HANDOVER BRIEFING)
  Widget _buildVoiceHudView() {
    final latestSpeakerMessage = _transcript.lastWhere(
      (m) => m.speaker == 'human_agent' || m.speaker == 'ai',
      orElse: () => _transcript.first,
    );

    return Stack(
      children: [
        // Camera Viewfinder Simulation Overlay (if enabled)
        if (_isCameraActive)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.85),
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.cyanAccent.withOpacity(0.8),
                            width: 2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.filter_center_focus_rounded,
                              size: 48, color: Colors.cyanAccent),
                          const SizedBox(height: 8),
                          Text(
                            'AI Visual Diagnostic Scan',
                            style: GoogleFonts.spaceGrotesk(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyanAccent),
                          ),
                          Text(
                            'Targeting Lower Hose Clamp HC-500',
                            style: GoogleFonts.roboto(
                                fontSize: 9, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      onPressed: () => setState(() => _isCameraActive = false),
                      icon: const Icon(Icons.close, color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ),

        // Normal Voice Calling HUD
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Column(
            children: [
              // If escalated, display the AI Handover Briefing Card to Service Desk
              if (_isEscalatedToHuman) ...[
                _buildHandoverBriefingCard(),
                const SizedBox(height: 12),
              ],

              // Animated Glowing Voice Orb
              Center(
                child: SizedBox(
                  width: _isEscalatedToHuman ? 110 : 135,
                  height: _isEscalatedToHuman ? 110 : 135,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer Pulse Ring
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, _) => Container(
                          width: (_isEscalatedToHuman ? 100 : 125) +
                              (20 * _pulseController.value),
                          height: (_isEscalatedToHuman ? 100 : 125) +
                              (20 * _pulseController.value),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: (_humanSpeaking
                                      ? const Color(0xFF38BDF8)
                                      : (_aiSpeaking
                                          ? const Color(0xFF06B6D4)
                                          : const Color(0xFF4F46E5)))
                                  .withOpacity(
                                      0.25 * (1 - _pulseController.value)),
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      // Rotating Gradient Glow Halo
                      AnimatedBuilder(
                        animation: _voiceOrbController,
                        builder: (context, _) => Transform.rotate(
                          angle: _voiceOrbController.value * 2 * math.pi,
                          child: Container(
                            width: _isEscalatedToHuman ? 90 : 110,
                            height: _isEscalatedToHuman ? 90 : 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: SweepGradient(
                                colors: [
                                  (_humanSpeaking
                                          ? const Color(0xFF0284C7)
                                          : const Color(0xFF4F46E5))
                                      .withOpacity(0.1),
                                  (_humanSpeaking
                                          ? const Color(0xFF38BDF8)
                                          : const Color(0xFF06B6D4))
                                      .withOpacity(0.8),
                                  const Color(0xFF8B5CF6).withOpacity(0.6),
                                  (_humanSpeaking
                                          ? const Color(0xFF0284C7)
                                          : const Color(0xFF4F46E5))
                                      .withOpacity(0.1),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Inner Orb Core with Equalizer Waves
                      Container(
                        width: _isEscalatedToHuman ? 74 : 88,
                        height: _isEscalatedToHuman ? 74 : 88,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: (_humanSpeaking
                                      ? const Color(0xFF0284C7)
                                      : const Color(0xFF4F46E5))
                                  .withOpacity(0.2),
                              blurRadius: 16,
                              spreadRadius: 2,
                            )
                          ],
                          border: Border.all(
                            color: _humanSpeaking
                                ? const Color(0xFF0284C7)
                                : const Color(0xFF4F46E5),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: _buildEqualizerBars(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Live Speaking Status Pill
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: _humanSpeaking
                      ? const Color(0xFFE0F2FE)
                      : (_aiSpeaking
                          ? const Color(0xFFEEF2FF)
                          : const Color(0xFFF1F5F9)),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _humanSpeaking
                        ? const Color(0xFFBAE6FD)
                        : (_aiSpeaking
                            ? const Color(0xFFC7D2FE)
                            : const Color(0xFFE2E8F0)),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _humanSpeaking
                          ? Icons.support_agent_rounded
                          : (_aiSpeaking
                              ? Icons.volume_up_rounded
                              : Icons.hearing_rounded),
                      size: 13,
                      color: _humanSpeaking
                          ? const Color(0xFF0369A1)
                          : (_aiSpeaking
                              ? const Color(0xFF4F46E5)
                              : const Color(0xFF64748B)),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _humanSpeaking
                          ? 'Specialist Ravi Kumar Speaking...'
                          : (_aiSpeaking
                              ? 'Apex-7 AI Speaking...'
                              : 'Awaiting Operator Input'),
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        color: _humanSpeaking
                            ? const Color(0xFF0369A1)
                            : (_aiSpeaking
                                ? const Color(0xFF4338CA)
                                : const Color(0xFF334155)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Live Spoken Subtitle Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              latestSpeakerMessage.speaker == 'human_agent'
                                  ? Icons.record_voice_over_rounded
                                  : Icons.chat_bubble_outline_rounded,
                              size: 13,
                              color: latestSpeakerMessage.speaker ==
                                      'human_agent'
                                  ? const Color(0xFF0284C7)
                                  : const Color(0xFF4F46E5),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              latestSpeakerMessage.speaker == 'human_agent'
                                  ? 'FIELD SPECIALIST (RAVI KUMAR)'
                                  : 'LIVE AI AUDIO TRANSCRIPT',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                color: latestSpeakerMessage.speaker ==
                                        'human_agent'
                                    ? const Color(0xFF0369A1)
                                    : const Color(0xFF4F46E5),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          latestSpeakerMessage.timestamp,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 9,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      latestSpeakerMessage.message,
                      style: GoogleFonts.inter(
                        fontSize: 12.5,
                        height: 1.4,
                        color: const Color(0xFF0F172A),
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    // Entities Tag Pill
                    if (latestSpeakerMessage.entities.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: latestSpeakerMessage.entities.map((e) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: const Color(0xFFE2E8F0)),
                            ),
                            child: Text(
                              e,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0284C7),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // AI HANDOVER BRIEFING CARD (TRANSMITTED TO SERVICE DESK)
  Widget _buildHandoverBriefingCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF86EFAC), width: 1.2),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(
                () => _isBriefingExpanded = !_isBriefingExpanded),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.sync_alt_rounded,
                        size: 15, color: Color(0xFF16A34A)),
                    const SizedBox(width: 6),
                    Text(
                      'AI HANDOVER BRIEFING TO FIELD DESK',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: const Color(0xFF166534),
                      ),
                    ),
                  ],
                ),
                Icon(
                  _isBriefingExpanded
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded,
                  size: 18,
                  color: const Color(0xFF16A34A),
                ),
              ],
            ),
          ),
          if (_isBriefingExpanded) ...[
            const Divider(height: 16, color: Color(0xFFBBF7D0)),
            _buildBriefingPoint('Diagnostic Alert',
                'ERR-704 Coolant Overheat (98.4°C @ 80% Load) on Generator ABC123'),
            _buildBriefingPoint('Physical Observation',
                'Lower clamp fitting dripping; screw thread stripped / loose'),
            _buildBriefingPoint('Telemetry Anomaly',
                'Manifold pressure 1.42 bar; temp spiked from 82°C to 98.4°C in 10m'),
            _buildBriefingPoint('Asset Service History',
                'Last hose replaced 18mo ago; 2 cooling tickets in 90d'),
            _buildBriefingPoint('Recommended Part',
                'OEM Kit #HC-500 reserved in Van #4 (Tech Ravi Kumar, ETA 12m)'),
          ],
        ],
      ),
    );
  }

  Widget _buildBriefingPoint(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: Color(0xFF16A34A),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF166534),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.roboto(
                fontSize: 10,
                color: const Color(0xFF14532D),
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEqualizerBars() {
    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(5, (index) {
            double factor = math.sin((_waveController.value * math.pi) +
                    (index * (math.pi / 3)))
                .abs();
            double height = 8.0 + (factor * 26.0);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 3.5,
              height: _aiSpeaking || _operatorSpeaking || _humanSpeaking
                  ? height
                  : 6.0,
              decoration: BoxDecoration(
                color: _humanSpeaking
                    ? const Color(0xFF38BDF8)
                    : (_aiSpeaking
                        ? Colors.cyanAccent
                        : const Color(0xFF818CF8)),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        );
      },
    );
  }

  // 4B. FULL TRANSCRIPT & TOOLS STREAM VIEW
  Widget _buildTranscriptStreamView() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      itemCount: _transcript.length + (_isSynthesizing ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _transcript.length && _isSynthesizing) {
          return _buildTypingIndicator();
        }
        final msg = _transcript[index];
        return _buildTranscriptItem(msg);
      },
    );
  }

  Widget _buildTranscriptItem(TranscriptMessage msg) {
    final isAI = msg.speaker == 'ai';
    final isHumanAgent = msg.speaker == 'human_agent';
    final isSystem = msg.speaker == 'system';

    if (isSystem) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            const Icon(Icons.hub_rounded, color: Color(0xFF0284C7), size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                msg.message,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: (isAI || isHumanAgent)
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          // Speaker Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isHumanAgent) ...[
                  const Icon(Icons.support_agent_rounded,
                      size: 12, color: Color(0xFF0284C7)),
                  const SizedBox(width: 4),
                  Text('Ravi Kumar (Lead Field Specialist)',
                      style: GoogleFonts.spaceGrotesk(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0284C7))),
                ] else if (isAI) ...[
                  const Icon(Icons.smart_toy_outlined,
                      size: 11, color: Color(0xFF4F46E5)),
                  const SizedBox(width: 4),
                  Text('Apex-7 AI Core',
                      style: GoogleFonts.spaceGrotesk(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF4F46E5))),
                ] else ...[
                  Text('Arun Kumar (Operator)',
                      style: GoogleFonts.spaceGrotesk(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF64748B))),
                  const SizedBox(width: 4),
                  const Icon(Icons.person_outline,
                      size: 11, color: Color(0xFF64748B)),
                ],
                const SizedBox(width: 6),
                Text(msg.timestamp,
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 8, color: const Color(0xFF94A3B8))),
              ],
            ),
          ),

          // Speech Bubble
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.82,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isHumanAgent
                  ? const Color(0xFFF0FDF4)
                  : (isAI
                      ? Colors.white
                      : const Color(0xFFEFF6FF)),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular((isAI || isHumanAgent) ? 2 : 16),
                bottomRight:
                    Radius.circular((isAI || isHumanAgent) ? 16 : 2),
              ),
              border: Border.all(
                color: isHumanAgent
                    ? const Color(0xFFBBF7D0)
                    : (isAI
                        ? const Color(0xFFE2E8F0)
                        : const Color(0xFFBFDBFE)),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  msg.message,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: isHumanAgent
                        ? const Color(0xFF14532D)
                        : (isAI
                            ? const Color(0xFF0F172A)
                            : const Color(0xFF1E3A8A)),
                    height: 1.35,
                  ),
                ),

                // Extracted Entities
                if (msg.entities.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: msg.entities.map((e) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Text(
                          e,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: isHumanAgent
                                ? const Color(0xFF15803D)
                                : const Color(0xFF0284C7),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),

          // Tool Invocation Chip
          if (msg.toolInvocation != null) ...[
            const SizedBox(height: 4),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.82,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFFFDE68A)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.data_object_rounded,
                      size: 11, color: Color(0xFFD97706)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      msg.toolInvocation!,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 9,
                        color: const Color(0xFF92400E),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF0284C7)),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Apex-7 is executing diagnostics...',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 5. DYNAMIC PROMPT AREA (GUIDED INTERACTIVE STEPS + ESCALATION)
  Widget _buildDynamicPromptArea() {
    if (_callStage == 2) {
      return _buildPromptStage1SymptomIsolation();
    } else if (_callStage == 4) {
      return _buildPromptStage2ActionableTest();
    } else if (_callStage == 6) {
      return _buildPromptStage3ResolutionCertified();
    } else {
      return const SizedBox.shrink();
    }
  }

  // STAGE 1: SYMPTOM ISOLATION OPTIONS
  Widget _buildPromptStage1SymptomIsolation() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.touch_app_rounded,
                      size: 14, color: Color(0xFF0284C7)),
                  const SizedBox(width: 6),
                  Text(
                    'AI PROMPT • STEP 1 OF 2: ISOLATE SYMPTOM',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: const Color(0xFF0284C7),
                    ),
                  ),
                ],
              ),
              if (!_isEscalatedToHuman)
                InkWell(
                  onTap: _escalateToHumanServiceAgent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F2FE),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: const Color(0xFFBAE6FD), width: 0.8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.headset_mic_rounded,
                            size: 11, color: Color(0xFF0284C7)),
                        const SizedBox(width: 4),
                        Text(
                          'Call Service Agent',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0284C7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          _buildPromptOptionCard(
            title: '1. Fluid actively dripping at lower clamp fitting',
            subtitle: 'Wet staining visible around OEM silicone hose junction',
            icon: Icons.water_drop_rounded,
            iconColor: const Color(0xFF0284C7),
            onTap: () => _onSelectSymptom(
              'fluid_dripping',
              'Apex, I see coolant visibly dripping from the lower hose clamp fitting while idling.',
              'Freshworks MCP: queryHistoricalRepairs("ABC123") -> Matched repair note by Tech Ravi 6mo ago.',
            ),
          ),
          const SizedBox(height: 6),
          _buildPromptOptionCard(
            title: '2. Steam & boiling at expansion reservoir cap',
            subtitle: 'Pressure relief valve hissing; coolant reservoir boiling',
            icon: Icons.waves_rounded,
            iconColor: const Color(0xFFD97706),
            onTap: () => _onSelectSymptom(
              'steam_venting',
              'Apex, steam is venting from the radiator expansion cap and boiling sounds inside the reservoir.',
              'Safety Engine: Overpressurization warning triggered. SOP-112 cap isolation active.',
            ),
          ),
          const SizedBox(height: 6),
          _buildPromptOptionCard(
            title: '3. No visible leak, but temperature spiked dry',
            subtitle: 'Temp gauge at 98°C; suspecting air lock or pump impeller',
            icon: Icons.thermostat_rounded,
            iconColor: const Color(0xFFDC2626),
            onTap: () => _onSelectSymptom(
              'air_lock',
              'Apex, no external leak is visible, but the block temperature climbed quickly to 98°C.',
              'SCADA Analytics: Anomaly profile matches air-lock or coolant circulation stagnation.',
            ),
          ),
        ],
      ),
    );
  }

  // STAGE 2: GUIDED MECHANICAL / DIAGNOSTIC TEST
  Widget _buildPromptStage2ActionableTest() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.build_circle_rounded,
                      size: 14, color: Color(0xFFD97706)),
                  const SizedBox(width: 6),
                  Text(
                    'AI GUIDED TEST • STEP 2 OF 2: TORQUE CHECK',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: const Color(0xFFD97706),
                    ),
                  ),
                ],
              ),
              if (!_isEscalatedToHuman)
                InkWell(
                  onTap: _escalateToHumanServiceAgent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F2FE),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: const Color(0xFFBAE6FD), width: 0.8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.headset_mic_rounded,
                            size: 11, color: Color(0xFF0284C7)),
                        const SizedBox(width: 4),
                        Text(
                          'Call Service Agent',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0284C7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (_selectedSymptom == 'fluid_dripping') ...[
            _buildPromptOptionCard(
              title: 'A. Clamp screw spins freely (Stripped / Cracked)',
              subtitle: 'Cannot hold 28 Nm torque; clamp band fractured',
              icon: Icons.cancel_outlined,
              iconColor: const Color(0xFFDC2626),
              onTap: () => _onSelectActionTest(
                testOutcome: 'clamp_stripped',
                operatorSpoken:
                    'I tried turning the 8mm bolt clockwise, but the thread is stripped and spins freely. The clamp is damaged.',
                selfResolved: false,
                finalConfidence: 94,
                aiFinalDialogue:
                    'Diagnostic Certified (94% confidence). Verified: Hose clamp elastomeric thread failure. Requisitioning OEM Kit #HC-500 from Van #4 and authorizing Specialist Ravi Kumar for field dispatch.',
                toolFinalLog:
                    'Freshworks Inventory: Reserved OEM Kit #HC-500 in Van #4 (Tech Ravi Kumar, ETA 12m).',
              ),
            ),
            const SizedBox(height: 6),
            _buildPromptOptionCard(
              title: 'B. Clamp tightened 1.5 turns & leak stopped completely',
              subtitle: 'Retorqued to 28 Nm; telemetry temperature stabilizing',
              icon: Icons.check_circle_outline_rounded,
              iconColor: const Color(0xFF10B981),
              onTap: () => _onSelectActionTest(
                testOutcome: 'clamp_tightened',
                operatorSpoken:
                    'I tightened the clamp 1.5 turns with the 8mm driver. The drip stopped immediately and engine temp dropped to 84°C.',
                selfResolved: true,
                finalConfidence: 96,
                aiFinalDialogue:
                    'Self-Resolution Certified (96% confidence)! Telemetry confirms coolant temperature stabilized at 84°C. Logging closed resolution ticket to Freshworks and updating asset memory.',
                toolFinalLog:
                    'Freshworks MCP: createTicketNote("ABC123", "Operator Self-Resolved via 8mm clamp torque"). Status: CLOSED.',
              ),
            ),
          ] else if (_selectedSymptom == 'air_lock') ...[
            _buildPromptOptionCard(
              title: 'A. Purged bleeder valve 1/4 turn → Air hissed out, temp normal',
              subtitle: 'Trapped air purged; coolant circulating properly',
              icon: Icons.check_circle_outline_rounded,
              iconColor: const Color(0xFF10B981),
              onTap: () => _onSelectActionTest(
                testOutcome: 'air_purged',
                operatorSpoken:
                    'I cracked open the bleeder valve by 1/4 turn. A pocket of air hissed out followed by coolant, and temp dropped back to 82°C.',
                selfResolved: true,
                finalConfidence: 92,
                aiFinalDialogue:
                    'Self-Resolution Certified! Thermal equilibrium restored. Air pocket purged from manifold. Logging customer resolution to Freshworks.',
                toolFinalLog:
                    'Freshworks MCP: createTicketNote("ABC123", "Air Lock Purged by Operator"). Status: RESOLVED.',
              ),
            ),
            const SizedBox(height: 6),
            _buildPromptOptionCard(
              title: 'B. Bleeder valve opened, but water pump making cavitation noise',
              subtitle: 'Mechanical circulation failure; requires pump replacement',
              icon: Icons.cancel_outlined,
              iconColor: const Color(0xFFDC2626),
              onTap: () => _onSelectActionTest(
                testOutcome: 'pump_failure',
                operatorSpoken:
                    'Bleeder valve is clear, but the water pump is making a loud metallic grinding noise.',
                selfResolved: false,
                finalConfidence: 91,
                aiFinalDialogue:
                    'Diagnostic Certified: Water pump mechanical impeller failure. Authorizing Emergency Specialist Dispatch with Part #WP-900.',
                toolFinalLog:
                    'Freshworks Dispatch: Requisitioned Heavy Water Pump #WP-900. Dispatched Specialist Ravi.',
              ),
            ),
          ] else ...[
            _buildPromptOptionCard(
              title: 'A. Pressure cap seal degraded → Dispatch technician with cap',
              subtitle: 'Cap spring fatigued; unable to sustain 16 PSI',
              icon: Icons.report_problem_rounded,
              iconColor: const Color(0xFFDC2626),
              onTap: () => _onSelectActionTest(
                testOutcome: 'cap_failure',
                operatorSpoken:
                    'Cap rubber gasket is degraded and spring has lost tension.',
                selfResolved: false,
                finalConfidence: 93,
                aiFinalDialogue:
                    'Diagnostic Certified: Radiator pressure cap relief valve failure. Authorizing Dispatch with replacement 16 PSI OEM cap #RC-16.',
                toolFinalLog:
                    'Freshworks MCP: Requisitioned OEM Cap #RC-16. Tech Ravi assigned.',
              ),
            ),
          ],
        ],
      ),
    );
  }

  // STAGE 3: RESOLUTION CERTIFIED BANNER
  Widget _buildPromptStage3ResolutionCertified() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: BoxDecoration(
        color: _isSelfResolved
            ? const Color(0xFFECFDF5)
            : const Color(0xFFEFF6FF),
        border: Border(
          top: BorderSide(
            color: _isSelfResolved
                ? const Color(0xFFA7F3D0)
                : const Color(0xFFBFDBFE),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _isSelfResolved
                    ? Icons.verified_rounded
                    : Icons.local_shipping_rounded,
                color: _isSelfResolved
                    ? const Color(0xFF059669)
                    : const Color(0xFF2563EB),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _isSelfResolved
                      ? 'OPERATOR SELF-RESOLUTION CERTIFIED!'
                      : 'AI DIAGNOSTIC DISPATCH CERTIFIED',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _isSelfResolved
                        ? const Color(0xFF065F46)
                        : const Color(0xFF1E40AF),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _isSelfResolved
                      ? const Color(0xFFD1FAE5)
                      : const Color(0xFFDBEAFE),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '$_diagnosticConfidence% CONFIDENCE',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _isSelfResolved
                        ? const Color(0xFF047857)
                        : const Color(0xFF1D4ED8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            _isSelfResolved
                ? 'Coolant leak resolved via 8mm clamp torque retighten. Telemetry stabilized at 84°C. Ticket marked CLOSED.'
                : 'Verified: $_detectedRootCause. Part #HC-500 reserved in Van #4. Specialist Ravi Kumar dispatched.',
            style: GoogleFonts.roboto(
              fontSize: 11,
              color: const Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }

  // PROMPT OPTION CARD
  Widget _buildPromptOptionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 16),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.roboto(
                      fontSize: 10,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 12, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }

  // 6. BOTTOM CALL CONTROLS DOCK
  Widget _buildBottomCallControls() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Mute Button
          _buildCircleCallButton(
            icon: _isMuted ? Icons.mic_off_rounded : Icons.mic_rounded,
            isActive: _isMuted,
            activeColor: const Color(0xFFDC2626),
            label: _isMuted ? 'Muted' : 'Mute',
            onTap: () {
              setState(() => _isMuted = !_isMuted);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 900),
                  backgroundColor: _isMuted
                      ? const Color(0xFF991B1B)
                      : const Color(0xFF065F46),
                  content: Text(
                    _isMuted ? 'Microphone Muted' : 'Microphone Active',
                    style: GoogleFonts.spaceGrotesk(fontSize: 11),
                  ),
                ),
              );
            },
          ),

          // Speaker Button
          _buildCircleCallButton(
            icon: _isSpeakerOn
                ? Icons.volume_up_rounded
                : Icons.hearing_rounded,
            isActive: _isSpeakerOn,
            activeColor: const Color(0xFF4F46E5),
            label: _isSpeakerOn ? 'Speaker' : 'Earpiece',
            onTap: () => setState(() => _isSpeakerOn = !_isSpeakerOn),
          ),

          // Call Human Agent Escalation Button
          _buildCircleCallButton(
            icon: _isEscalatedToHuman
                ? Icons.support_agent_rounded
                : Icons.headset_mic_rounded,
            isActive: _isEscalatedToHuman,
            activeColor: const Color(0xFF0284C7),
            label: _isEscalatedToHuman ? 'Specialist' : 'Call Desk',
            onTap: _escalateToHumanServiceAgent,
          ),

          // Camera Share Button (Visual Inspection)
          _buildCircleCallButton(
            icon: _isCameraActive
                ? Icons.videocam_rounded
                : Icons.videocam_outlined,
            isActive: _isCameraActive,
            activeColor: const Color(0xFF0284C7),
            label: 'Scan Cam',
            onTap: () => setState(() => _isCameraActive = !_isCameraActive),
          ),

          const SizedBox(width: 4),

          // Main Call Action Button (End Call & Rate)
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _finishAndSubmitCall,
              icon: Icon(
                _callStage == 6
                    ? Icons.rate_review_rounded
                    : Icons.call_end_rounded,
                color: Colors.white,
                size: 16,
              ),
              label: Text(
                _callStage == 6
                    ? 'Resolve & Rate'
                    : 'End Call & Rate',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _callStage == 6
                    ? (_isSelfResolved
                        ? const Color(0xFF10B981)
                        : const Color(0xFF4F46E5))
                    : const Color(0xFFDC2626),
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleCallButton({
    required IconData icon,
    required bool isActive,
    required Color activeColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isActive
                    ? activeColor.withOpacity(0.12)
                    : const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isActive ? activeColor : const Color(0xFFE2E8F0),
                  width: 1.5,
                ),
              ),
              child: Icon(
                icon,
                color: isActive ? activeColor : const Color(0xFF64748B),
                size: 17,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 8.5,
                fontWeight: FontWeight.w600,
                color: isActive ? activeColor : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
