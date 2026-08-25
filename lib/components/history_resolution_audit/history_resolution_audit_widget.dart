import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'history_resolution_audit_model.dart';
export 'history_resolution_audit_model.dart';

/// Data class representing an issue history record with full attribution
class IssueHistoryRecord {
  final String ticketId;
  final String title;
  final String assetId;
  final String date;
  final String category; // 'Cooling', 'Electrical', 'Mechanical', 'Routine PM'
  final String symptom;
  final String rootCause;
  
  // Who solved it
  final String resolvedBy;
  final String resolverRole; // 'Field Technician', 'Plant Manager', 'Customer Self-Resolved'
  final String resolverAvatarText;
  final Color roleColor;
  final IconData roleIcon;

  // How did they solve it
  final List<String> resolutionSteps;
  final List<String> partsUsed;
  final String mttrDuration; // e.g. "38 mins"
  final String finalTelemetryVerification;

  // Company Data & AI Input Contribution
  final int totalCompanyDataContribution; // e.g. 88%
  final int freshworksContribution; // e.g. 38%
  final int oemManualContribution; // e.g. 28%
  final int aiReasoningContribution; // e.g. 22%
  final int humanOperatorContribution; // e.g. 12%

  final List<CompanyDataSourceCitation> citations;

  const IssueHistoryRecord({
    required this.ticketId,
    required this.title,
    required this.assetId,
    required this.date,
    required this.category,
    required this.symptom,
    required this.rootCause,
    required this.resolvedBy,
    required this.resolverRole,
    required this.resolverAvatarText,
    required this.roleColor,
    required this.roleIcon,
    required this.resolutionSteps,
    required this.partsUsed,
    required this.mttrDuration,
    required this.finalTelemetryVerification,
    required this.totalCompanyDataContribution,
    required this.freshworksContribution,
    required this.oemManualContribution,
    required this.aiReasoningContribution,
    required this.humanOperatorContribution,
    required this.citations,
  });
}

class CompanyDataSourceCitation {
  final String sourceName;
  final String documentReference;
  final String insightProvided;
  final IconData icon;

  const CompanyDataSourceCitation({
    required this.sourceName,
    required this.documentReference,
    required this.insightProvided,
    required this.icon,
  });
}

class HistoryResolutionAuditWidget extends StatefulWidget {
  const HistoryResolutionAuditWidget({
    super.key,
    required this.record,
  });

  final IssueHistoryRecord record;

  @override
  State<HistoryResolutionAuditWidget> createState() =>
      _HistoryResolutionAuditWidgetState();
}

class _HistoryResolutionAuditWidgetState
    extends State<HistoryResolutionAuditWidget> {
  late HistoryResolutionAuditModel _model;
  int _selectedTab = 0; // 0: Resolution Steps, 1: Company Data & AI Contribution, 2: Audit Logs

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistoryResolutionAuditModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final record = widget.record;

    return Dialog(
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      insetPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.90,
          maxWidth: 500,
        ),
        child: Column(
          children: [
            // 1. MODAL HEADER
            _buildModalHeader(record),

            // 2. RESOLVER & ATTRIBUTION HERO CARD
            _buildResolverAttributionCard(record),

            // 3. SEGMENTED TABS (Steps vs Data Contribution vs Audit)
            _buildSegmentedTabBar(),

            // 4. TAB BODY (Scrollable)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
                child: _selectedTab == 0
                    ? _buildResolutionStepsView(record)
                    : _selectedTab == 1
                        ? _buildCompanyDataContributionView(record)
                        : _buildAuditLogView(record),
              ),
            ),

            // 5. MODAL BOTTOM FOOTER
            _buildModalFooter(),
          ],
        ),
      ),
    );
  }

  // MODAL HEADER
  Widget _buildModalHeader(IssueHistoryRecord record) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 16, 14),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          bottom: BorderSide(color: FlutterFlowTheme.of(context).alternate),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: record.roleColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(record.roleIcon, color: record.roleColor, size: 20),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        record.ticketId,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'RESOLVED & AUDITED',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF059669),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    record.title,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  // RESOLVER ATTRIBUTION CARD
  Widget _buildResolverAttributionCard(IssueHistoryRecord record) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: FlutterFlowTheme.of(context).alternate),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Resolver Avatar
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: record.roleColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              record.resolverAvatarText,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Resolver Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Solved By: ',
                      style: GoogleFonts.roboto(
                        fontSize: 11,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ),
                    Text(
                      record.resolvedBy,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: record.roleColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        record.resolverRole.toUpperCase(),
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: record.roleColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'MTTR: ${record.mttrDuration}',
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

          // AI & Company Data Contribution Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1B4B),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF4338CA)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${record.totalCompanyDataContribution}%',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFA5B4FC),
                  ),
                ),
                Text(
                  'DATA ASSIST',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // SEGMENTED TAB BAR
  Widget _buildSegmentedTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(3),
      child: Row(
        children: [
          _buildTabItem(0, 'Resolution Steps'),
          _buildTabItem(1, 'Company Knowledge'),
          _buildTabItem(2, 'Audit Dossier'),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String title) {
    bool isSelected = _selectedTab == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedTab = index),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: isSelected
                ? FlutterFlowTheme.of(context).secondaryBackground
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    )
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected
                  ? FlutterFlowTheme.of(context).primaryText
                  : FlutterFlowTheme.of(context).secondaryText,
            ),
          ),
        ),
      ),
    );
  }

  // TAB 0: RESOLUTION STEPS & ROOT CAUSE
  Widget _buildResolutionStepsView(IssueHistoryRecord record) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Root Cause Box
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBEB),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFDE68A)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.search_rounded,
                  color: Color(0xFFD97706), size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VERIFIED ROOT CAUSE:',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFB45309),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      record.rootCause,
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: const Color(0xFF78350F),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Sequential Resolution Steps
        Text(
          'Exact Actions & Procedures Executed:',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: FlutterFlowTheme.of(context).primaryText,
          ),
        ),
        const SizedBox(height: 10),

        ...record.resolutionSteps.asMap().entries.map((entry) {
          int stepNum = entry.key + 1;
          String stepText = entry.value;

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
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
                  child: Text(
                    '$stepNum',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate),
                    ),
                    child: Text(
                      stepText,
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: FlutterFlowTheme.of(context).primaryText,
                        height: 1.35,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),

        const SizedBox(height: 8),

        // Replaced Parts / Consumables
        if (record.partsUsed.isNotEmpty) ...[
          Text(
            'Replaced Parts & Requisitioned Materials:',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: record.partsUsed.map((part) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFBFDBFE)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.build_circle_outlined,
                        size: 13, color: Color(0xFF2563EB)),
                    const SizedBox(width: 4),
                    Text(
                      part,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E40AF),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],

        const SizedBox(height: 12),

        // Telemetry Verification Note
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFECFDF5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFA7F3D0)),
          ),
          child: Row(
            children: [
              const Icon(Icons.check_circle_rounded,
                  color: Color(0xFF059669), size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Telemetry Verified: ${record.finalTelemetryVerification}',
                  style: GoogleFonts.roboto(
                    fontSize: 11,
                    color: const Color(0xFF065F46),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // TAB 1: COMPANY DATA & KNOWLEDGE INPUT CONTRIBUTION
  Widget _buildCompanyDataContributionView(IssueHistoryRecord record) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Overall Summary Banner
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'KNOWLEDGE ATTRIBUTION BREAKDOWN',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent,
                    ),
                  ),
                  Text(
                    '${record.totalCompanyDataContribution}% Total Assist',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF34D399),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Multi-bar Meter
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  height: 12,
                  child: Row(
                    children: [
                      Expanded(
                        flex: record.freshworksContribution,
                        child: Container(color: const Color(0xFF3B82F6)),
                      ),
                      Expanded(
                        flex: record.oemManualContribution,
                        child: Container(color: const Color(0xFF8B5CF6)),
                      ),
                      Expanded(
                        flex: record.aiReasoningContribution,
                        child: Container(color: const Color(0xFF10B981)),
                      ),
                      Expanded(
                        flex: record.humanOperatorContribution,
                        child: Container(color: const Color(0xFFF59E0B)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Legend
              Wrap(
                spacing: 12,
                runSpacing: 6,
                children: [
                  _buildLegendItem('Freshworks MCP',
                      '${record.freshworksContribution}%', const Color(0xFF3B82F6)),
                  _buildLegendItem('OEM Manuals',
                      '${record.oemManualContribution}%', const Color(0xFF8B5CF6)),
                  _buildLegendItem('AI Diagnostic',
                      '${record.aiReasoningContribution}%', const Color(0xFF10B981)),
                  _buildLegendItem('Human Physical',
                      '${record.humanOperatorContribution}%', const Color(0xFFF59E0B)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        Text(
          'Specific Company Data & Grounding Sources Cited:',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: FlutterFlowTheme.of(context).primaryText,
          ),
        ),
        const SizedBox(height: 10),

        ...record.citations.map((cite) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: FlutterFlowTheme.of(context).alternate),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(cite.icon,
                      color: FlutterFlowTheme.of(context).primary, size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cite.sourceName,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .alternate
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              cite.documentReference,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: FlutterFlowTheme.of(context).secondaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        cite.insightProvided,
                        style: GoogleFonts.roboto(
                          fontSize: 11,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildLegendItem(String label, String pct, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          '$label ($pct)',
          style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.white70),
        ),
      ],
    );
  }

  // TAB 2: AUDIT LOG VIEW
  Widget _buildAuditLogView(IssueHistoryRecord record) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAuditRow('Asset Serial Number', 'SN-78234-B (Cummins QSK19 500KVA)'),
        _buildAuditRow('Operating Location', 'Peenya Stage 2 Industrial Facility, Bay 4'),
        _buildAuditRow('Reported Timestamp', '${record.date} 14:22:18 IST'),
        _buildAuditRow('Resolution Signed By', '${record.resolvedBy} (${record.resolverRole})'),
        _buildAuditRow('Freshworks Ticket ID', record.ticketId),
        _buildAuditRow('Freshworks MCP Writeback', 'Synchronized & Verified (Status: CLOSED)'),
        _buildAuditRow('Audit Standard Compliance', 'ISO 10816-3 & OEM Cummins Tier 2 Service SLA'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(Icons.lock_outline_rounded,
                  size: 16, color: Color(0xFF475569)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Cryptographically sealed audit log. Immutable record stored in Freshworks Service Desk memory.',
                  style: GoogleFonts.roboto(
                    fontSize: 10,
                    color: const Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAuditRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: GoogleFonts.roboto(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: FlutterFlowTheme.of(context).secondaryText,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.roboto(
                fontSize: 11,
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MODAL FOOTER
  Widget _buildModalFooter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        border: Border(
          top: BorderSide(color: FlutterFlowTheme.of(context).alternate),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Audit Log exported to Freshworks Ticket Dossier (PDF).'),
                  backgroundColor: Color(0xFF1E293B),
                ),
              );
            },
            icon: const Icon(Icons.download_rounded, size: 16),
            label: Text(
              'Export Audit Dossier',
              style: GoogleFonts.spaceGrotesk(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Close Dossier',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
