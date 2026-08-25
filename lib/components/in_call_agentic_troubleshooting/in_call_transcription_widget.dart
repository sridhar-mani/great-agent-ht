import 'dart:async';
import 'dart:math' as math;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'in_call_transcription_model.dart';
export 'in_call_transcription_model.dart';

/// Data class representing a transcript line in the in-call stream.
class TranscriptMessage {
  final String id;
  final String speaker; // 'operator' or 'ai' or 'system'
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

/// Dynamic troubleshooting decision branch
class TroubleshootingOption {
  final String label;
  final String description;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onSelect;

  TroubleshootingOption({
    required this.label,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.onSelect,
  });
}

class InCallTranscriptionWidget extends StatefulWidget {
  const InCallTranscriptionWidget({
    super.key,
    required this.onCallComplete,
    this.initialSymptom = 'ERR-704 Coolant Overheat after 10m load',
  });

  final String initialSymptom;
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
  late AnimationController _equalizerController;
  late AnimationController _pulseController;

  // Call duration state
  Timer? _callTimer;
  int _callSeconds = 14; // start at 14s for realistic demo

  // Dynamic Call States
  // 1: In-call Greeting & SToT initial processing
  // 2: Dynamic Prompt 1 (Symptom Isolation)
  // 3: Agent Reasoning / Tool Execution (Freshworks / OEM)
  // 4: Dynamic Prompt 2 (In-Call Actionable Check)
  // 5: Diagnostic Synthesis
  // 6: Call Finalized (Resolution Certified)
  int _callStage = 1;

  bool _isMuted = false;
  bool _isSpeakerOn = true;
  bool _showToolLogs = true;
  bool _isSynthesizing = false;

  // Selected paths for branching
  String _selectedSymptom = '';
  String _selectedActionTest = '';
  bool _isSelfResolved = false;
  int _diagnosticConfidence = 71;
  String _detectedRootCause = 'Cooling restriction at lower hose clamp assembly';

  // Live Transcript Stream
  final List<TranscriptMessage> _transcript = [];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InCallTranscriptionModel());

    _equalizerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _startCallTimer();
    _initializeCallTranscript();
  }

  @override
  void dispose() {
    _callTimer?.cancel();
    _equalizerController.dispose();
    _pulseController.dispose();
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

    // Automatically transition to Stage 2 after initial rendering
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _callStage = 2;
        });
        _scrollToBottom();
      }
    });
  }

  // Branch 1: User selects symptom observation
  void _onSelectSymptom(String symptom, String operatorSpoken, String toolLog) {
    setState(() {
      _selectedSymptom = symptom;
      _isSynthesizing = true;
      _callStage = 3;

      _transcript.add(TranscriptMessage(
        id: 'user_symptom_${DateTime.now().millisecondsSinceEpoch}',
        speaker: 'operator',
        message: operatorSpoken,
        timestamp: _formatDuration(_callSeconds),
      ));
    });
    _scrollToBottom();

    // AI agent reasons with tools
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      setState(() {
        _isSynthesizing = false;
        _callStage = 4;

        if (symptom == 'fluid_dripping') {
          _diagnosticConfidence = 89;
          _detectedRootCause =
              'Elastomeric hose clamp fatigue & torque degradation (HC-500)';
          _transcript.add(TranscriptMessage(
            id: 'ai_tool_${DateTime.now().millisecondsSinceEpoch}',
            speaker: 'ai',
            message:
                'Telemetry confirms coolant expansion pressure is 1.4 bar. OEM manual §4.2 specifies 28 Nm on the lower hose clamp. Let\'s check the clamp bolt torque.',
            timestamp: _formatDuration(_callSeconds),
            toolInvocation: toolLog,
            entities: ['OEM §4.2 Specs: 28 Nm', 'Pressure: 1.4 bar'],
          ));
        } else if (symptom == 'steam_venting') {
          _diagnosticConfidence = 84;
          _detectedRootCause =
              'Expansion tank 16 PSI pressure relief cap spring failure';
          _transcript.add(TranscriptMessage(
            id: 'ai_tool_${DateTime.now().millisecondsSinceEpoch}',
            speaker: 'ai',
            message:
                'Steam indicates over-pressurization exceeding 1.1 bar cap rating. Safety protocol: Do not open expansion cap while hot.',
            timestamp: _formatDuration(_callSeconds),
            toolInvocation: toolLog,
            entities: ['Safety Alert: High Temp', 'Cap Rating: 16 PSI'],
          ));
        } else {
          _diagnosticConfidence = 78;
          _detectedRootCause =
              'Entrapped air pocket in upper radiator manifold (Air Lock)';
          _transcript.add(TranscriptMessage(
            id: 'ai_tool_${DateTime.now().millisecondsSinceEpoch}',
            speaker: 'ai',
            message:
                'Dry overheat with normal coolant level often points to air lock. Let\'s check the brass bleeder valve on the upper radiator manifold.',
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
      _isSynthesizing = true;
      _callStage = 5;

      _transcript.add(TranscriptMessage(
        id: 'user_action_${DateTime.now().millisecondsSinceEpoch}',
        speaker: 'operator',
        message: operatorSpoken,
        timestamp: _formatDuration(_callSeconds),
      ));
    });
    _scrollToBottom();

    // AI Finalizes Diagnosis & Requisitions Parts / Certifies Resolution
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        _isSynthesizing = false;
        _callStage = 6;

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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF0F172A),
      insetPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.88,
          maxWidth: 480,
        ),
        child: Column(
          children: [
            // 1. TOP HEADER: CALL TELEMETRY & PARTICIPANTS
            _buildInCallHeader(),

            // 2. AGENTIC ACTIVITY BANNER (COLLAPSIBLE)
            _buildAgenticThoughtBar(),

            // 3. LIVE BIDIRECTIONAL TRANSCRIPT STREAM
            Expanded(
              child: _buildTranscriptStream(),
            ),

            // 4. DYNAMIC AGENTIC TROUBLESHOOTING PROMPT AREA
            _buildDynamicPromptArea(),

            // 5. IN-CALL BOTTOM CONTROLS & ACTIONS
            _buildBottomCallControls(),
          ],
        ),
      ),
    );
  }

  // HEADER WIDGET
  Widget _buildInCallHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(bottom: BorderSide(color: Color(0xFF334155))),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Live Status Badge
              Row(
                children: [
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, _) => Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _callStage == 6
                            ? const Color(0xFF10B981)
                            : const Color(0xFFEF4444),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (_callStage == 6
                                    ? const Color(0xFF10B981)
                                    : const Color(0xFFEF4444))
                                .withOpacity(0.5 * _pulseController.value),
                            blurRadius: 8 * _pulseController.value,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _callStage == 6
                        ? 'CALL RESOLUTION CERTIFIED'
                        : 'LIVE CALL • ${_formatDuration(_callSeconds)}',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: _callStage == 6
                          ? const Color(0xFF34D399)
                          : const Color(0xFFF87171),
                    ),
                  ),
                ],
              ),

              // Audio Waveform Equalizer
              Row(
                children: [
                  _buildEqualizer(),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF334155),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.close,
                          size: 18, color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Participants Banner
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFF1A237E),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text('AK',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Arun Kumar (Lead Operator)',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Generator ABC123 • Peenya Industrial Bay 4',
                      style: GoogleFonts.roboto(
                        fontSize: 10,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF4338CA).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF6366F1)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.auto_awesome,
                        color: Colors.amberAccent, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      'Apex-7 AI Agent',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ANIMATED EQUALIZER WIDGET
  Widget _buildEqualizer() {
    return AnimatedBuilder(
      animation: _equalizerController,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(4, (index) {
            double factor = math.sin((_equalizerController.value * math.pi) +
                    (index * (math.pi / 4)))
                .abs();
            double height = 4.0 + (factor * 12.0);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 1.5),
              width: 3,
              height: height,
              decoration: BoxDecoration(
                color: _callStage == 6
                    ? const Color(0xFF10B981)
                    : Colors.indigoAccent,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        );
      },
    );
  }

  // AGENTIC THOUGHT BAR
  Widget _buildAgenticThoughtBar() {
    return InkWell(
      onTap: () => setState(() => _showToolLogs = !_showToolLogs),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: const Color(0xFF131E33),
          border: Border(
            bottom: BorderSide(color: const Color(0xFF1E293B)),
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.psychology_rounded,
                color: Colors.cyanAccent, size: 15),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                _isSynthesizing
                    ? '⚡ AI Agent executing Freshworks MCP & Multimodal Reasoning...'
                    : '⚡ Agentic Diagnostic Core: Cummins QSK19 Knowledge Active',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.cyanAccent,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              _showToolLogs
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: Colors.cyanAccent,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // TRANSCRIPT STREAM LIST
  Widget _buildTranscriptStream() {
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

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment:
            isAI ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          // Speaker Tag & Timestamp
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isAI) ...[
                  const Icon(Icons.smart_toy_outlined,
                      size: 11, color: Colors.indigoAccent),
                  const SizedBox(width: 4),
                  Text('Apex-7 AI (Voice & Telemetry)',
                      style: GoogleFonts.spaceGrotesk(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigoAccent)),
                ] else ...[
                  Text('Arun Kumar',
                      style: GoogleFonts.spaceGrotesk(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF94A3B8))),
                  const SizedBox(width: 4),
                  const Icon(Icons.person_outline,
                      size: 11, color: Color(0xFF94A3B8)),
                ],
                const SizedBox(width: 6),
                Text(msg.timestamp,
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 8, color: const Color(0xFF64748B))),
              ],
            ),
          ),

          // Speech Bubble
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.76,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isAI ? const Color(0xFF1E293B) : const Color(0xFF1E3A8A),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isAI ? 2 : 16),
                bottomRight: Radius.circular(isAI ? 16 : 2),
              ),
              border: Border.all(
                color: isAI ? const Color(0xFF334155) : const Color(0xFF3B82F6),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  msg.message,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: Colors.white,
                    height: 1.35,
                  ),
                ),

                // Extracted Entities / Chips
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
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: isAI
                                ? Colors.indigoAccent.withOpacity(0.5)
                                : Colors.blueAccent.withOpacity(0.5),
                          ),
                        ),
                        child: Text(
                          e,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: isAI
                                ? Colors.cyanAccent
                                : const Color(0xFF93C5FD),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),

          // Tool Invocation Footnote (if present)
          if (_showToolLogs && msg.toolInvocation != null) ...[
            const SizedBox(height: 4),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.76,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF0B132B),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFF1E293B)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.data_object_rounded,
                      size: 11, color: Colors.amberAccent),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      msg.toolInvocation!,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 9,
                        color: Colors.amberAccent.shade100,
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
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF334155)),
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
                        AlwaysStoppedAnimation<Color>(Colors.indigoAccent),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Apex-7 is reasoning with company telemetry...',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // DYNAMIC PROMPT AREA (ADAPTIVE TROUBLESHOOTING ENGINE)
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

  // STAGE 1: DYNAMIC SYMPTOM ISOLATION OPTIONS
  Widget _buildPromptStage1SymptomIsolation() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B),
        border: Border(top: BorderSide(color: Color(0xFF334155))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'AI PROMPT: OBSERVE & SELECT LIVE SYMPTOM',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: Colors.indigoAccent,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.indigoAccent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Step 1 of 2',
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 9, color: Colors.indigoAccent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildPromptOptionCard(
            title: '1. Fluid actively dripping at lower clamp fitting',
            subtitle: 'Wet staining visible around OEM silicone hose junction',
            icon: Icons.water_drop_rounded,
            iconColor: Colors.blueAccent,
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
            iconColor: Colors.amberAccent,
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
            iconColor: Colors.redAccent,
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

  // STAGE 2: DYNAMIC ACTIONABLE IN-CALL TEST
  Widget _buildPromptStage2ActionableTest() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B),
        border: Border(top: BorderSide(color: Color(0xFF334155))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'AI GUIDED TEST: EXECUTE WITH DRIVER',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: Colors.amberAccent,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.amberAccent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Diagnostic Step 2',
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 9, color: Colors.amberAccent),
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
              iconColor: Colors.redAccent,
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
              iconColor: Colors.redAccent,
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
              iconColor: Colors.redAccent,
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

  // STAGE 3: RESOLUTION SUMMARY & CONFIRMATION
  Widget _buildPromptStage3ResolutionCertified() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _isSelfResolved ? const Color(0xFF064E3B) : const Color(0xFF1E293B),
        border: Border(
          top: BorderSide(
            color: _isSelfResolved
                ? const Color(0xFF10B981)
                : const Color(0xFF6366F1),
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
                    ? const Color(0xFF34D399)
                    : const Color(0xFF818CF8),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _isSelfResolved
                      ? 'OPERATOR SELF-RESOLUTION CERTIFIED!'
                      : 'AI DIAGNOSTIC DISPATCH CERTIFIED',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '$_diagnosticConfidence% CONFIDENCE',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _isSelfResolved
                        ? const Color(0xFF34D399)
                        : const Color(0xFFA5B4FC),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            _isSelfResolved
                ? 'Issue successfully resolved by Operator Arun Kumar via AI guided torque check. Ticket marked Resolved.'
                : 'Verified: $_detectedRootCause. Part #HC-500 reserved in Van #4. Specialist Ravi Kumar assigned.',
            style: GoogleFonts.roboto(
              fontSize: 11,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  // PROMPT OPTION CARD COMPONENT
  Widget _buildPromptOptionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF334155)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
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
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.roboto(
                      fontSize: 10,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 12, color: Color(0xFF64748B)),
          ],
        ),
      ),
    );
  }

  // BOTTOM CONTROLS
  Widget _buildBottomCallControls() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
      decoration: const BoxDecoration(
        color: Color(0xFF0B132B),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Audio Mute Toggle
          IconButton(
            onPressed: () => setState(() => _isMuted = !_isMuted),
            icon: Icon(
              _isMuted ? Icons.mic_off_rounded : Icons.mic_rounded,
              color: _isMuted ? const Color(0xFFEF4444) : Colors.white70,
              size: 20,
            ),
            tooltip: _isMuted ? 'Unmute' : 'Mute',
          ),

          // Speaker Toggle
          IconButton(
            onPressed: () => setState(() => _isSpeakerOn = !_isSpeakerOn),
            icon: Icon(
              _isSpeakerOn ? Icons.volume_up_rounded : Icons.volume_off_rounded,
              color: _isSpeakerOn ? Colors.indigoAccent : Colors.white70,
              size: 20,
            ),
            tooltip: 'Speaker',
          ),

          const SizedBox(width: 8),

          // Main Action Button
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                widget.onCallComplete(
                  dispatchRequired: !_isSelfResolved,
                  resolutionNotes: _isSelfResolved
                      ? 'Operator Arun Kumar resolved hose clamp leakage via guided 8mm torque retighten.'
                      : 'Diagnostic certified: $_detectedRootCause. Dispatched Tech Ravi Kumar.',
                  finalConfidence: _diagnosticConfidence,
                  resolvedBy: _isSelfResolved
                      ? 'Operator Arun Kumar (Customer Self-Fix)'
                      : 'Ravi Kumar (L3 Field Specialist)',
                  rootCause: _detectedRootCause,
                );
              },
              icon: Icon(
                _callStage == 6
                    ? Icons.check_circle_rounded
                    : Icons.call_end_rounded,
                color: Colors.white,
                size: 16,
              ),
              label: Text(
                _callStage == 6
                    ? 'Confirm & Apply Resolution'
                    : 'End Call & Apply Current Data',
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
                    : const Color(0xFFEF4444),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
