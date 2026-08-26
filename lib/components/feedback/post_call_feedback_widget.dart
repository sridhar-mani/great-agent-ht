import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/flutter_flow/flutter_flow_theme.dart';

/// Data class holding the dual post-call feedback results
class PostCallFeedbackResult {
  final int agentRating; // 1 to 5
  final List<String> agentTags;
  final String aiTrainingNotes; // Manual typed feedback for AI model fine-tuning
  final int specialistRating; // 1 to 5
  final List<String> specialistTags;
  final String specialistNotes; // Manual typed feedback for field service execution
  final String qualitativeNotes; // Combined summary
  final int netPromoterScore; // 1 to 10
  final String assetId;
  final String ticketId;
  final DateTime timestamp;

  PostCallFeedbackResult({
    required this.agentRating,
    required this.agentTags,
    required this.aiTrainingNotes,
    required this.specialistRating,
    required this.specialistTags,
    required this.specialistNotes,
    required this.qualitativeNotes,
    required this.netPromoterScore,
    required this.assetId,
    required this.ticketId,
    required this.timestamp,
  });
}

class PostCallFeedbackWidget extends StatefulWidget {
  final String assetId;
  final String assetName;
  final String specialistName;
  final String ticketId;
  final String diagnosticSummary;
  final Function(PostCallFeedbackResult result) onSubmitted;
  final VoidCallback onDismissed;

  const PostCallFeedbackWidget({
    super.key,
    required this.assetId,
    required this.assetName,
    this.specialistName = 'Ravi Kumar (Lead Field Specialist)',
    this.ticketId = 'SR-8924',
    this.diagnosticSummary = 'Cooling restriction verified. Clamp replacement recommended.',
    required this.onSubmitted,
    required this.onDismissed,
  });

  @override
  State<PostCallFeedbackWidget> createState() => _PostCallFeedbackWidgetState();
}

class _PostCallFeedbackWidgetState extends State<PostCallFeedbackWidget> {
  int _agentRating = 5;
  final Set<String> _selectedAgentTags = {};

  int _specialistRating = 5;
  final Set<String> _selectedSpecialistTags = {};

  final int _npsScore = 10;

  // Manual typed feedback controllers for AI training & Field execution
  final TextEditingController _aiTrainingController = TextEditingController();
  final TextEditingController _specialistNotesController = TextEditingController();

  bool _isSubmitting = false;
  bool _isSubmitted = false;

  final List<String> _availableAgentTags = [
    '🎯 Accurate Diagnosis',
    '⚡ Fast Telemetry Response',
    '🎙️ Clear Audio Guidance',
    '🔍 Root Cause Isolated',
    '🧠 Freshworks Match',
  ];

  final List<String> _availableSpecialistTags = [
    '⏱️ Prompt ETA',
    '🔧 Technical Expertise',
    '📦 Correct Parts Ready',
    '💬 Clear Communication',
    '🛡️ Safety Verified',
  ];

  @override
  void dispose() {
    _aiTrainingController.dispose();
    _specialistNotesController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    setState(() {
      _isSubmitting = true;
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        _isSubmitted = true;
      });

      final aiNotes = _aiTrainingController.text.trim();
      final techNotes = _specialistNotesController.text.trim();
      final combined = [
        if (aiNotes.isNotEmpty) 'AI Training Feedback: $aiNotes',
        if (techNotes.isNotEmpty) 'Technician Feedback: $techNotes',
      ].join('\n\n');

      final result = PostCallFeedbackResult(
        agentRating: _agentRating,
        agentTags: _selectedAgentTags.toList(),
        aiTrainingNotes: aiNotes,
        specialistRating: _specialistRating,
        specialistTags: _selectedSpecialistTags.toList(),
        specialistNotes: techNotes,
        qualitativeNotes: combined.isNotEmpty ? combined : 'Manual review completed by plant operator.',
        netPromoterScore: _npsScore,
        assetId: widget.assetId,
        ticketId: widget.ticketId,
        timestamp: DateTime.now(),
      );

      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          widget.onSubmitted(result);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 780),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 28,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: _isSubmitted ? _buildSuccessView() : _buildFormView(),
      ),
    );
  }

  Widget _buildFormView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Clean Light Header
        Container(
          padding: const EdgeInsets.fromLTRB(20, 18, 16, 16),
          decoration: const BoxDecoration(
            color: Color(0xFFF8FAFC),
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFE2E8F0),
                width: 1,
              ),
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0284C7).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.rate_review_rounded,
                      color: Color(0xFF0284C7),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Post-Call Diagnostic Feedback',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF0F172A),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${widget.assetName} • Ticket #${widget.ticketId}',
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF64748B),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: widget.onDismissed,
                icon: const Icon(Icons.close_rounded, color: Color(0xFF64748B)),
                tooltip: 'Dismiss',
              ),
            ],
          ),
        ),

        // Scrollable Body
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Training purpose banner
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFBFDBFE),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.school_rounded,
                        color: Color(0xFF2563EB),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Your typed notes provide direct training data to refine the AI reasoning pipeline and track field technician service quality.',
                          style: GoogleFonts.roboto(
                            color: const Color(0xFF1E40AF),
                            fontSize: 11.5,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // 1. AI DIAGNOSTIC AGENT SECTION
                _buildSectionHeader(
                  icon: Icons.psychology_rounded,
                  iconColor: const Color(0xFF0284C7),
                  title: 'Apex-7 AI Diagnostic Core',
                  subtitle: 'Reasoning precision, telemetry extraction & voice clarity',
                ),
                const SizedBox(height: 10),

                // Star rating row
                _buildStarRatingRow(
                  rating: _agentRating,
                  onRatingChanged: (val) => setState(() => _agentRating = val),
                  accentColor: const Color(0xFF0284C7),
                ),
                const SizedBox(height: 10),

                // AI Manual Typed Training Feedback Box
                Text(
                  'Manual AI Model Training Notes (Crucial for Fine-Tuning):',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF334155),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _aiTrainingController,
                  maxLines: 3,
                  style: GoogleFonts.roboto(
                    color: const Color(0xFF0F172A),
                    fontSize: 12.5,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type specific feedback for AI retraining: Did it isolate the root cause correctly? What telemetry/manual corrections should be fed to model training?...',
                    hintStyle: GoogleFonts.roboto(
                      color: const Color(0xFF94A3B8),
                      fontSize: 12,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFF0284C7),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Quick tags wrap
                _buildTagsWrap(
                  availableTags: _availableAgentTags,
                  selectedTags: _selectedAgentTags,
                  accentColor: const Color(0xFF0284C7),
                ),

                const Divider(height: 32, thickness: 1, color: Color(0xFFE2E8F0)),

                // 2. FIELD SERVICE SPECIALIST SECTION
                _buildSectionHeader(
                  icon: Icons.engineering_rounded,
                  iconColor: const Color(0xFFD97706),
                  title: widget.specialistName,
                  subtitle: 'Technical expertise, ETA punctuality & parts readiness',
                ),
                const SizedBox(height: 10),

                // Star rating row
                _buildStarRatingRow(
                  rating: _specialistRating,
                  onRatingChanged: (val) => setState(() => _specialistRating = val),
                  accentColor: const Color(0xFFD97706),
                ),
                const SizedBox(height: 10),

                // Specialist Manual Typed Feedback Box
                Text(
                  'Field Specialist Execution Notes:',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF334155),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _specialistNotesController,
                  maxLines: 2,
                  style: GoogleFonts.roboto(
                    color: const Color(0xFF0F172A),
                    fontSize: 12.5,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type notes on technician response time, physical inspection accuracy, and parts installation...',
                    hintStyle: GoogleFonts.roboto(
                      color: const Color(0xFF94A3B8),
                      fontSize: 12,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFFD97706),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Quick tags wrap
                _buildTagsWrap(
                  availableTags: _availableSpecialistTags,
                  selectedTags: _selectedSpecialistTags,
                  accentColor: const Color(0xFFD97706),
                ),

                const SizedBox(height: 16),

                // 3. FRESHWORKS CRM WRITE-BACK PREVIEW
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFFBBF7D0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF16A34A),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Freshworks Sync: CSAT ($_agentRating/5 AI, $_specialistRating/5 Tech) -> Ticket #${widget.ticketId}',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 11,
                            color: const Color(0xFF15803D),
                            fontWeight: FontWeight.w600,
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

        // Action Buttons
        Container(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
          decoration: const BoxDecoration(
            color: Color(0xFFF8FAFC),
            border: Border(
              top: BorderSide(
                color: Color(0xFFE2E8F0),
                width: 1,
              ),
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onDismissed,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(
                      color: Color(0xFFCBD5E1),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Skip for Now',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF475569),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FlutterFlowTheme.of(context).primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.send_rounded,
                              size: 16,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Submit Feedback',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: const Color(0xFF0F172A),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.roboto(
                  color: const Color(0xFF64748B),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStarRatingRow({
    required int rating,
    required ValueChanged<int> onRatingChanged,
    required Color accentColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: List.generate(5, (index) {
            final starVal = index + 1;
            final isFilled = starVal <= rating;
            return InkWell(
              onTap: () => onRatingChanged(starVal),
              borderRadius: BorderRadius.circular(6),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Icon(
                  isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: isFilled ? const Color(0xFFF59E0B) : const Color(0xFFCBD5E1),
                  size: 28,
                ),
              ),
            );
          }),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: accentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: accentColor.withOpacity(0.3)),
          ),
          child: Text(
            '$rating / 5 Stars',
            style: GoogleFonts.spaceGrotesk(
              color: accentColor,
              fontWeight: FontWeight.bold,
              fontSize: 11.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagsWrap({
    required List<String> availableTags,
    required Set<String> selectedTags,
    required Color accentColor,
  }) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: availableTags.map((tag) {
        final isSelected = selectedTags.contains(tag);
        return InkWell(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedTags.remove(tag);
              } else {
                selectedTags.add(tag);
              }
            });
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? accentColor.withOpacity(0.12)
                  : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? accentColor
                    : const Color(0xFFE2E8F0),
              ),
            ),
            child: Text(
              tag,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? accentColor : const Color(0xFF475569),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSuccessView() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF10B981), width: 2),
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: Color(0xFF059669),
              size: 44,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Feedback Logged!',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Apex-7 AI Core & ${widget.specialistName} feedback successfully synced to Freshworks Ticket #${widget.ticketId}.',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: const Color(0xFF475569),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn('AI AGENT', '$_agentRating/5 ★', const Color(0xFF0284C7)),
                Container(width: 1, height: 28, color: const Color(0xFFE2E8F0)),
                _buildStatColumn('SPECIALIST', '$_specialistRating/5 ★', const Color(0xFFD97706)),
                Container(width: 1, height: 28, color: const Color(0xFFE2E8F0)),
                _buildStatColumn('CSAT RATING', '100%', const Color(0xFF059669)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String val, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 9.5,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          val,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
