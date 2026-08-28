import '/components/activity_item/activity_item_widget.dart';
import '/components/bottom_nav/bottom_nav_widget.dart';
import '/components/bottom_nav_child/bottom_nav_child_widget.dart';
import '/components/button/button_widget.dart';
import '/components/history_resolution_audit/history_resolution_audit_widget.dart';
import '/components/in_call_agentic_troubleshooting/in_call_transcription_widget.dart';
import '/data/plant_asset_data.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'asset_dashboard_model.dart';
export 'asset_dashboard_model.dart';

class AssetDashboardWidget extends StatefulWidget {
  const AssetDashboardWidget({super.key});

  static String routeName = 'AssetDashboard';
  static String routePath = '/assetDashboard';

  @override
  State<AssetDashboardWidget> createState() => _AssetDashboardWidgetState();
}

class _AssetDashboardWidgetState extends State<AssetDashboardWidget>
    with SingleTickerProviderStateMixin {
  late AssetDashboardModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentNavIndex = 0;
  String _selectedAssetFilter = 'All';
  String _selectedHistoryFilter = 'All';
  bool _offlineSyncEnabled = true;
  String _selectedAssetId = 'ABC123';
  bool _isPreRequisitioned = false;
  bool _isAppointmentDismissed = false;
  String _scheduledDate = 'Aug 28, 2026';
  String _scheduledTime = '10:30 AM';

  // Multi-product and multi-instance fleet state
  List<PlantAsset> _fleetAssets = PlantAssetRepository.getInitialFleet();
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  PlantAsset get _activeAsset {
    return _fleetAssets.firstWhere(
      (a) => a.id == _selectedAssetId,
      orElse: () => _fleetAssets.first,
    );
  }

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AssetDashboardModel());
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pulseController.dispose();
    _model.dispose();
    super.dispose();
  }

  void _showNotificationsModal() {
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
                        color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.notifications_active_rounded,
                          color: FlutterFlowTheme.of(context).primary, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Plant Alerts & Notifications (3)',
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
            const SizedBox(height: 16),
            // High Priority Predictive Maintenance Notification (10 Days to Failure)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF7F1D1D).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFEF4444), width: 1.2),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.warning_amber_rounded,
                        color: Color(0xFFF87171), size: 20),
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
                              'PREDICTIVE: 10 Days to Failure',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFCA5A5),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEF4444),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'ACTION DUE',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Generator ABC123: Lower Hose (HC-500) predicted wear limit reached in 10 days. Pre-requisition advised.',
                          style: GoogleFonts.roboto(
                            fontSize: 11,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            _showPredictiveMaintenanceModal();
                          },
                          child: Text(
                            'View Lifecycle Forecast & Requisition →',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF60A5FA),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _buildNotificationItem('Just now', 'Coolant Temp Warning',
                'Generator ABC123 reported 98°C spike during load peak', Colors.red),
            const Divider(height: 16),
            _buildNotificationItem('2 hrs ago', 'Dispatched Technician Assigned',
                'Ravi Kumar confirmed arrival ETA 12 mins', Colors.green),
            const Divider(height: 16),
            _buildNotificationItem('Yesterday', 'Scheduled Audit Complete',
                'Quarterly vibration analysis passed ISO 10816-3', Colors.blue),
            const SizedBox(height: 20),
            ButtonWidget(
              content: 'Mark All As Read',
              variant: 'primary',
              size: 'large',
              fullWidth: true,
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
      String date, String title, String sub, MaterialColor color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 9,
          height: 9,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
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
              Text(sub,
                  style: GoogleFonts.roboto(
                      fontSize: 11,
                      color: FlutterFlowTheme.of(context).secondaryText)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(date,
            style: GoogleFonts.spaceGrotesk(
                fontSize: 11,
                color: FlutterFlowTheme.of(context).secondaryText)),
      ],
    );
  }

  // PREDICTIVE MAINTENANCE & COMPONENT LIFECYCLE MODAL
  void _showPredictiveMaintenanceModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.88,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(color: const Color(0xFF1E293B)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Modal Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.indigoAccent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.auto_awesome,
                          color: Colors.cyanAccent, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI Predictive Maintenance Core',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Cummins QSK19 Lifecycle Tracker • ABC123',
                          style: GoogleFonts.roboto(
                            fontSize: 11,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white70),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Summary Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF334155)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.psychology_rounded,
                      color: Colors.cyanAccent, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'AI analyzed 4,850 runtime hours, thermal cycles, and historical service tickets. 1 component requires replacement in 10 days.',
                      style: GoogleFonts.roboto(
                        fontSize: 11,
                        color: const Color(0xFFCBD5E1),
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Component Lifecycle List
            Expanded(
              child: ListView(
                children: [
                  // 1. Lower Radiator Silicone Hose & Clamp (High Alert: 10 Days)
                  _buildComponentLifecycleCard(
                    title: 'Lower Radiator Hose & Clamp',
                    partNumber: 'OEM Kit #HC-500',
                    daysRemaining: 10,
                    remainingLifePercent: 18,
                    lastReplaced: 'Feb 04, 2026 (18 mos ago)',
                    technician: 'Tech Ravi Kumar',
                    status: 'Critical Alert',
                    statusColor: const Color(0xFFEF4444),
                    insight:
                        'Thermal fatigue & micro-elasticity degradation detected at 80% peak engine load. Replace within 10 days to prevent road trip.',
                    actionLabel: 'Pre-Requisition OEM Kit #HC-500',
                    onAction: () {
                      Navigator.pop(context);
                      setState(() {
                        _isPreRequisitioned = true;
                        _isAppointmentDismissed = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color(0xFF065F46),
                          duration: Duration(seconds: 3),
                          content: Row(
                            children: [
                              Icon(Icons.verified_rounded,
                                  color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '✅ Pre-requisitioned OEM Kit #HC-500! Preventive appointment scheduled for Aug 28 with Tech Ravi Kumar.',
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  // 2. Primary Fuel Filter & Water Separator (28 Days)
                  _buildComponentLifecycleCard(
                    title: 'Primary Fuel Filter & Water Separator',
                    partNumber: 'OEM #FF-200',
                    daysRemaining: 28,
                    remainingLifePercent: 42,
                    lastReplaced: 'Nov 10, 2025 (9 mos ago)',
                    technician: 'Tech Suresh M.',
                    status: 'Nominal Wear',
                    statusColor: const Color(0xFFFBBF24),
                    insight:
                        'Differential pressure nominal at 0.18 bar. Filter particulate loading is at 58% capacity.',
                    actionLabel: 'Add to Next Scheduled Service',
                    onAction: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color(0xFF1E1B4B),
                          content: Text(
                            'Added OEM #FF-200 to 30-Day Preventive Service Checklist.',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  // 3. Alternator Serpentine Drive Belt (65 Days)
                  _buildComponentLifecycleCard(
                    title: 'Alternator Serpentine Drive Belt',
                    partNumber: 'OEM #AB-90',
                    daysRemaining: 65,
                    remainingLifePercent: 74,
                    lastReplaced: 'Sept 12, 2025 (11 mos ago)',
                    technician: 'Tech Ravi Kumar',
                    status: 'Good Health',
                    statusColor: const Color(0xFF10B981),
                    insight:
                        'Rib deflection is 1.1mm (Tolerance <3.0mm). Belt tension holding steady at 520 N.',
                    actionLabel: 'View Sensor Logs',
                    onAction: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 12),

                  // 4. Valve Cover Gasket Set (110 Days)
                  _buildComponentLifecycleCard(
                    title: 'Valve Cover Gasket Set',
                    partNumber: 'OEM #VG-31',
                    daysRemaining: 110,
                    remainingLifePercent: 91,
                    lastReplaced: 'Jan 15, 2026 (7 mos ago)',
                    technician: 'Tech Anita S.',
                    status: 'Optimal',
                    statusColor: const Color(0xFF10B981),
                    insight:
                        'Hermetic seal verified. Zero micro-seepage detected in crankcase breather telemetry.',
                    actionLabel: 'View Audit Certificate',
                    onAction: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComponentLifecycleCard({
    required String title,
    required String partNumber,
    required int daysRemaining,
    required int remainingLifePercent,
    required String lastReplaced,
    required String technician,
    required String status,
    required Color statusColor,
    required String insight,
    required String actionLabel,
    required VoidCallback onAction,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF131E33),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: daysRemaining <= 10
              ? const Color(0xFFEF4444)
              : const Color(0xFF1E293B),
          width: daysRemaining <= 10 ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '$partNumber • Replaced: $lastReplaced',
                      style: GoogleFonts.roboto(
                        fontSize: 10,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: statusColor.withOpacity(0.5)),
                ),
                child: Text(
                  daysRemaining <= 10
                      ? 'FAIL IN $daysRemaining DAYS'
                      : '$daysRemaining DAYS DUE',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Health Progress Bar
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: remainingLifePercent / 100.0,
                    minHeight: 6,
                    backgroundColor: const Color(0xFF1E293B),
                    valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '$remainingLifePercent% Life',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // AI Insight
          Text(
            insight,
            style: GoogleFonts.roboto(
              fontSize: 11,
              color: const Color(0xFFCBD5E1),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 10),

          // Action Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onAction,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: daysRemaining <= 10
                      ? const Color(0xFFEF4444)
                      : Colors.indigoAccent,
                ),
                backgroundColor: daysRemaining <= 10
                    ? const Color(0xFF7F1D1D).withOpacity(0.2)
                    : Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: Text(
                actionLabel,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: daysRemaining <= 10
                      ? const Color(0xFFFCA5A5)
                      : Colors.cyanAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showInCallAgentModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (dialogContext) => InCallTranscriptionWidget(
        assetId: _activeAsset.id,
        assetName: _activeAsset.name,
        initialSymptom: _activeAsset.defaultSymptom,
        onCallComplete: ({
          required bool dispatchRequired,
          required String resolutionNotes,
          required int finalConfidence,
          required String resolvedBy,
          required String rootCause,
        }) {
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
                          ? 'AI Diagnostic Certified ($finalConfidence%). Field Technician Ravi Kumar Dispatched!'
                          : 'Self-Resolution Verified ($finalConfidence%). $resolvedBy logged to Freshworks!',
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

  void _showResolutionAuditModal(IssueHistoryRecord record) {
    showDialog(
      context: context,
      builder: (dialogContext) => HistoryResolutionAuditWidget(record: record),
    );
  }

  void _showSupportModal() {
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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.headset_mic_rounded,
                  color: FlutterFlowTheme.of(context).primary, size: 36),
            ),
            const SizedBox(height: 12),
            Text('Plant Support & AI Diagnostic Desk',
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: FlutterFlowTheme.of(context).primaryText)),
            const SizedBox(height: 4),
            Text('Autonomous AI Call Agent with Live Transcription & SCADA Sync',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: FlutterFlowTheme.of(context).secondaryText)),
            const SizedBox(height: 16),
            ButtonWidget(
              icon: const Icon(Icons.phone_in_talk_rounded, color: Colors.white, size: 18),
              iconPresent: true,
              content: 'Start AI In-Call Diagnostic',
              variant: 'primary',
              size: 'large',
              fullWidth: true,
              onTap: () {
                Navigator.pop(context);
                _showInCallAgentModal();
              },
            ),
            const SizedBox(height: 8),
            ButtonWidget(
              content: 'Call Manual Control Desk (+91 80 2839 0000)',
              variant: 'outline',
              size: 'medium',
              fullWidth: true,
              onTap: () => Navigator.pop(context),
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
              // Global Top App Bar
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Image.asset(
                                  'assets/images/app_logo.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ServiceOps AI',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                  Text(
                                    'Peenya Stage 2 • Node #12',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Stack(
                                children: [
                                  FlutterFlowIconButton(
                                    borderRadius: 8,
                                    buttonSize: 36,
                                    fillColor: Colors.transparent,
                                    icon: Icon(
                                      Icons.notifications_none_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 22,
                                    ),
                                    onPressed: _showNotificationsModal,
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  setState(() => _currentNavIndex = 3);
                                },
                                borderRadius: BorderRadius.circular(17),
                                child: Container(
                                  width: 34,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    color: _currentNavIndex == 3
                                        ? FlutterFlowTheme.of(context).secondary
                                        : FlutterFlowTheme.of(context).primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _currentNavIndex == 3
                                          ? FlutterFlowTheme.of(context).primary
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'AK',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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

              // Dynamic Tab Body using IndexedStack
              Expanded(
                child: IndexedStack(
                  index: _currentNavIndex,
                  children: [
                    _buildHomeView(),
                    _buildAssetsView(),
                    _buildHistoryView(),
                    _buildProfileView(),
                  ],
                ),
              ),

              // Persistent Bottom Navigation Bar
              BottomNavWidget(
                child: () => BottomNavChildWidget(
                  currentIndex: _currentNavIndex,
                  onTap: (index) {
                    setState(() {
                      _currentNavIndex = index;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // PREDICTIVE MAINTENANCE EARLY WARNING BANNER
  Widget _buildPredictiveMaintenanceAlertCard() {
    final alert = _activeAsset.predictiveAlert;
    if (alert == null) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E1B4B), Color(0xFF0F172A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: alert.severityColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: alert.severityColor.withOpacity(0.15),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, _) => Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: alert.severityColor.withOpacity(0.25),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: alert.severityColor
                                  .withOpacity(0.4 * _pulseAnimation.value),
                              blurRadius: 8 * _pulseAnimation.value,
                            )
                          ],
                        ),
                        child: Icon(Icons.warning_amber_rounded,
                            color: alert.severityColor, size: 18),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            alert.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              color: const Color(0xFFFCA5A5),
                            ),
                          ),
                          Text(
                            'Asset: ${_activeAsset.name}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              fontSize: 10,
                              color: const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: alert.severityColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: alert.severityColor),
                ),
                child: Text(
                  '${alert.daysToLimit} DAYS',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            alert.component,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            alert.description,
            style: GoogleFonts.roboto(
              fontSize: 11,
              color: const Color(0xFFCBD5E1),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 10),

          // Health Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (_activeAsset.healthScore / 100.0).clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor: const Color(0xFF334155),
              valueColor: AlwaysStoppedAnimation<Color>(alert.severityColor),
            ),
          ),
          const SizedBox(height: 12),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _isPreRequisitioned = true;
                      _isAppointmentDismissed = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xFF065F46),
                        duration: const Duration(seconds: 3),
                        content: Row(
                          children: [
                            const Icon(Icons.verified_rounded,
                                color: Colors.white, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '✅ ${alert.recommendedAction} scheduled! Preventive service confirmed for $_scheduledDate with Tech Ravi Kumar.',
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_checkout_rounded,
                      size: 14, color: Colors.white),
                  label: Text(
                    alert.recommendedAction.length > 25
                        ? '${alert.recommendedAction.substring(0, 24)}...'
                        : alert.recommendedAction,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F46E5),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: _showPredictiveMaintenanceModal,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF64748B)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'All Parts',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyanAccent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // CONFIRMED PREVENTIVE SERVICE APPOINTMENT CARD (REPLACES WARNING AFTER PRE-REQUISITION)
  Widget _buildConfirmedAppointmentCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF064E3B), Color(0xFF0B192C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF10B981), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withOpacity(0.18),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, _) => Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.25),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF10B981)
                                  .withOpacity(0.4 * _pulseAnimation.value),
                              blurRadius: 8 * _pulseAnimation.value,
                            )
                          ],
                        ),
                        child: const Icon(Icons.verified_rounded,
                            color: Color(0xFF34D399), size: 18),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PREVENTIVE SERVICE APPOINTMENT CONFIRMED',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              color: const Color(0xFF6EE7B7),
                            ),
                          ),
                          Text(
                            'Work Order Ref: REQ-78234-HC • Pre-emptive Window',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              fontSize: 10,
                              color: const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () => setState(() => _isAppointmentDismissed = true),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child:
                      const Icon(Icons.close, size: 14, color: Colors.white70),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Lower Radiator Hose & Clamp Replacement (Kit #HC-500)',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),

          // Appointment Info Rows
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A).withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF1E293B)),
            ),
            child: Column(
              children: [
                _buildAppointmentDetailRow(
                  icon: Icons.calendar_today_rounded,
                  label: 'Appointment',
                  value:
                      '$_scheduledDate at $_scheduledTime (7d before wear limit)',
                  valueColor: const Color(0xFF34D399),
                ),
                const SizedBox(height: 8),
                _buildAppointmentDetailRow(
                  icon: Icons.engineering_rounded,
                  label: 'Field Specialist',
                  value: 'Ravi Kumar (Van #4 • Peenya Service Desk)',
                  valueColor: Colors.white,
                ),
                const SizedBox(height: 8),
                _buildAppointmentDetailRow(
                  icon: Icons.inventory_2_rounded,
                  label: 'Part Allocated',
                  value: 'OEM Kit #HC-500 (Reserved from Central Hub)',
                  valueColor: const Color(0xFF93C5FD),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Color(0xFF1E1B4B),
                        content: Text(
                            '📅 Appointment confirmed for Aug 28, 10:30 AM. SMS and Calendar invite sent to Arun Kumar.'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_calendar_rounded,
                      size: 14, color: Color(0xFF6EE7B7)),
                  label: Text(
                    'Modify / Reschedule',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF6EE7B7),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF10B981)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _showPredictiveMaintenanceModal,
                  icon: const Icon(Icons.inventory_rounded,
                      size: 14, color: Colors.white),
                  label: Text(
                    'Track All Parts (4)',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: valueColor),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF94A3B8),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }

  // TAB 0: HOME / DASHBOARD VIEW
  Widget _buildHomeView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // PREDICTIVE MAINTENANCE CARD (WARNING vs. CONFIRMED APPOINTMENT)
          if (!_isAppointmentDismissed) ...[
            _isPreRequisitioned
                ? _buildConfirmedAppointmentCard()
                : _buildPredictiveMaintenanceAlertCard(),
            const SizedBox(height: 16),
          ],

          // Main Asset Card
          Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: FlutterFlowTheme.of(context).alternate,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _activeAsset.name,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${_activeAsset.productModel} • ${_activeAsset.serialNumber} • ${_activeAsset.location}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: _showQuickAssetSwitcherModal,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).primary.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.swap_horiz_rounded,
                                    size: 14,
                                    color: FlutterFlowTheme.of(context).primary),
                                const SizedBox(width: 4),
                                Text(
                                  'Switch',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          decoration: BoxDecoration(
                            color: _activeAsset.statusColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _activeAsset.statusColor.withOpacity(0.4),
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedBuilder(
                                animation: _pulseAnimation,
                                builder: (context, _) => Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: _activeAsset.statusColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: _activeAsset.statusColor
                                            .withOpacity(
                                                _pulseAnimation.value * 0.6),
                                        blurRadius: 6 * _pulseAnimation.value,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _activeAsset.status,
                                style: GoogleFonts.spaceGrotesk(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: _activeAsset.statusColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(height: 22, thickness: 1),
                GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.2,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildSpecItem('Serial Number', _activeAsset.serialNumber),
                    _buildSpecItem('Install Date', _activeAsset.installDate),
                    _buildSpecItem('Last Service', _activeAsset.lastService),
                    _buildSpecItem('Location', _activeAsset.location),
                  ],
                ),
                const Divider(height: 22, thickness: 1),
                // Real-time Telemetry Row
                Row(
                  children: [
                    _buildTelemetryMetric(
                        'Load',
                        '${_activeAsset.telemetry.loadPercent.toStringAsFixed(0)}%',
                        Icons.bolt_rounded,
                        const Color(0xFF3B82F6)),
                    const SizedBox(width: 8),
                    _buildTelemetryMetric(
                        'Temp',
                        '${_activeAsset.telemetry.temperatureC.toStringAsFixed(1)}°C',
                        Icons.thermostat_rounded,
                        const Color(0xFFEF4444)),
                    const SizedBox(width: 8),
                    _buildTelemetryMetric(
                        'Vibration',
                        '${_activeAsset.telemetry.vibrationMmS.toStringAsFixed(1)} mm/s',
                        Icons.vibration_rounded,
                        const Color(0xFF10B981)),
                    const SizedBox(width: 8),
                    _buildTelemetryMetric(
                        'Runtime',
                        '${_activeAsset.telemetry.operatingHours}h',
                        Icons.timer_rounded,
                        const Color(0xFF8B5CF6)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Action CTA Buttons
          ButtonWidget(
            icon: const Icon(
              Icons.report_problem_rounded,
              color: Colors.white,
              size: 20,
            ),
            iconPresent: true,
            content: 'Report Issue for ${_activeAsset.id}',
            variant: 'primary',
            size: 'large',
            fullWidth: true,
            onTap: () {
              context.goNamed('IssueReport');
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  icon: Icon(
                    Icons.history_rounded,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 18,
                  ),
                  iconPresent: true,
                  content: 'Service History',
                  variant: 'outline',
                  size: 'medium',
                  fullWidth: true,
                  onTap: () {
                    setState(() => _currentNavIndex = 2);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ButtonWidget(
                  icon: Icon(
                    Icons.support_agent_rounded,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 18,
                  ),
                  iconPresent: true,
                  content: 'Control Desk',
                  variant: 'outline',
                  size: 'medium',
                  fullWidth: true,
                  onTap: _showSupportModal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Recent Activity Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() => _currentNavIndex = 2);
                },
                child: Text(
                  'See All',
                  style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
                if (_isPreRequisitioned) ...[
                  ActivityItemWidget(
                    color: const Color(0xFF10B981),
                    date: 'Aug 28, 2026',
                    icon: const Icon(
                      Icons.event_available_rounded,
                      color: Color(0xFF10B981),
                      size: 18,
                    ),
                    status: 'Scheduled',
                    title: 'Pre-emptive Hose & Clamp (Kit #HC-500)',
                  ),
                  const Divider(height: 20, thickness: 1),
                ],
                ActivityItemWidget(
                  color: FlutterFlowTheme.of(context).success,
                  date: 'Jan 15, 2026',
                  icon: Icon(
                    Icons.check_circle_rounded,
                    color: FlutterFlowTheme.of(context).success,
                    size: 18,
                  ),
                  status: 'Completed',
                  title: 'Routine Maintenance',
                ),
                const Divider(height: 20, thickness: 1),
                ActivityItemWidget(
                  color: FlutterFlowTheme.of(context).info,
                  date: 'Sept 12, 2025',
                  icon: Icon(
                    Icons.settings_rounded,
                    color: FlutterFlowTheme.of(context).info,
                    size: 18,
                  ),
                  status: 'Completed',
                  title: 'Belt Replacement',
                ),
                const Divider(height: 20, thickness: 1),
                ActivityItemWidget(
                  color: FlutterFlowTheme.of(context).warning,
                  date: 'Feb 04, 2026',
                  icon: Icon(
                    Icons.build_rounded,
                    color: FlutterFlowTheme.of(context).warning,
                    size: 18,
                  ),
                  status: 'Resolved',
                  title: 'Hose Clamp Repair',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // FILTERED ASSETS GETTER (Multi-product and Multi-instance support)
  List<PlantAsset> get _filteredAssets {
    return _fleetAssets.where((asset) {
      final filter = _selectedAssetFilter;
      bool matchesFilter = true;
      if (filter == 'All') {
        matchesFilter = true;
      } else if (filter == 'Power Gen' || filter == 'Generators') {
        matchesFilter = asset.category == 'Generators';
      } else if (filter == 'Compressors') {
        matchesFilter = asset.category == 'Compressors';
      } else if (filter == 'HVAC') {
        matchesFilter = asset.category == 'HVAC';
      } else if (filter == 'Boilers') {
        matchesFilter = asset.category == 'Boilers';
      } else if (filter == 'Robotics') {
        matchesFilter = asset.category == 'Robotics';
      }

      final query = _searchQuery.trim().toLowerCase();
      final matchesQuery = query.isEmpty ||
          asset.name.toLowerCase().contains(query) ||
          asset.productModel.toLowerCase().contains(query) ||
          asset.serialNumber.toLowerCase().contains(query) ||
          asset.location.toLowerCase().contains(query) ||
          asset.id.toLowerCase().contains(query);

      return matchesFilter && matchesQuery;
    }).toList();
  }

  // MODAL: QUICK UNIT SWITCHER
  void _showQuickAssetSwitcherModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(20),
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
                        color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.swap_horiz_rounded,
                          color: FlutterFlowTheme.of(context).primary, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Switch Plant Equipment Unit',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                        Text(
                          'Select any unit across identical lines or diverse products',
                          style: GoogleFonts.roboto(
                            fontSize: 11,
                            color: FlutterFlowTheme.of(context).secondaryText,
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
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: _fleetAssets.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final asset = _fleetAssets[index];
                  final isSelected = asset.id == _selectedAssetId;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedAssetId = asset.id;
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: const Color(0xFF1E293B),
                          duration: const Duration(seconds: 2),
                          content: Text(
                            'Active unit switched to ${asset.name}',
                            style: GoogleFonts.inter(color: Colors.white),
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? FlutterFlowTheme.of(context).primary.withOpacity(0.08)
                            : FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context).alternate,
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: asset.statusColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              asset.category == 'Generators'
                                  ? Icons.power_rounded
                                  : (asset.category == 'Compressors'
                                      ? Icons.air_rounded
                                      : (asset.category == 'HVAC'
                                          ? Icons.ac_unit_rounded
                                          : (asset.category == 'Boilers'
                                              ? Icons.local_fire_department_rounded
                                              : Icons.smart_toy_rounded))),
                              color: asset.statusColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        asset.name,
                                        style: GoogleFonts.inter(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: asset.statusColor.withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        asset.status,
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.bold,
                                          color: asset.statusColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${asset.productModel} • ${asset.location}',
                                  style: GoogleFonts.roboto(
                                    fontSize: 11,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected) ...[
                            const SizedBox(width: 8),
                            Icon(
                              Icons.check_circle_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 20,
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MODAL: ADD / CLONE ASSET UNIT
  void _showAddAssetModal() {
    String selectedCategory = 'Generators';
    String baseProduct = 'Cummins 500KVA Diesel GenSet';
    final nameCtrl = TextEditingController(text: 'Generator Unit #${_fleetAssets.where((a) => a.category == 'Generators').length + 1}');
    final serialCtrl = TextEditingController(text: 'SN-7823${_fleetAssets.length + 5}-E');
    final locCtrl = TextEditingController(text: 'Bay ${_fleetAssets.length * 2} Heavy Power');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalCtx) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
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
                            color: const Color(0xFF10B981).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.add_box_rounded,
                              color: Color(0xFF10B981), size: 20),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Register / Clone Unit',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            Text(
                              'Add multiple units of identical products or new lines',
                              style: GoogleFonts.roboto(
                                fontSize: 11,
                                color: FlutterFlowTheme.of(context).secondaryText,
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
                const SizedBox(height: 16),

                // Category Selector
                Text('Equipment Category',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: FlutterFlowTheme.of(context).primaryText)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  children: ['Generators', 'Compressors', 'HVAC', 'Boilers', 'Robotics'].map((cat) {
                    final isSel = selectedCategory == cat;
                    return ChoiceChip(
                      label: Text(cat,
                          style: GoogleFonts.spaceGrotesk(
                              fontSize: 11,
                              color: isSel ? Colors.white : FlutterFlowTheme.of(context).primaryText)),
                      selected: isSel,
                      selectedColor: FlutterFlowTheme.of(context).primary,
                      onSelected: (selected) {
                        if (selected) {
                          setModalState(() {
                            selectedCategory = cat;
                            if (cat == 'Generators') {
                              baseProduct = 'Cummins 500KVA Diesel GenSet';
                              nameCtrl.text = 'Generator Unit #${_fleetAssets.where((a) => a.category == 'Generators').length + 1}';
                            } else if (cat == 'Compressors') {
                              baseProduct = 'Atlas Copco Rotary Screw 75HP';
                              nameCtrl.text = 'Air Compressor #${_fleetAssets.where((a) => a.category == 'Compressors').length + 1}';
                            } else if (cat == 'HVAC') {
                              baseProduct = 'Daikin Water-Cooled 200TR';
                              nameCtrl.text = 'Chiller Unit CH-0${_fleetAssets.where((a) => a.category == 'HVAC').length + 1}';
                            } else if (cat == 'Boilers') {
                              baseProduct = 'Thermax Packaged 500kg/hr';
                              nameCtrl.text = 'Steam Boiler B-0${_fleetAssets.where((a) => a.category == 'Boilers').length + 1}';
                            } else {
                              baseProduct = 'Fanuc M-20iD/35 Industrial Robot';
                              nameCtrl.text = 'Robotic Arm (ROB-0${_fleetAssets.where((a) => a.category == 'Robotics').length + 1})';
                            }
                          });
                        }
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),

                // Base Product Model
                Text('Product Specification Model',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: FlutterFlowTheme.of(context).primaryText)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: FlutterFlowTheme.of(context).alternate),
                  ),
                  child: Text(baseProduct,
                      style: GoogleFonts.roboto(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: FlutterFlowTheme.of(context).primaryText)),
                ),
                const SizedBox(height: 12),

                // Unit Name
                Text('Unit Name / Identifier',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: FlutterFlowTheme.of(context).primaryText)),
                const SizedBox(height: 6),
                TextField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 12),

                // Serial & Location
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Serial Number',
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: FlutterFlowTheme.of(context).primaryText)),
                          const SizedBox(height: 6),
                          TextField(
                            controller: serialCtrl,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bay / Line Location',
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: FlutterFlowTheme.of(context).primaryText)),
                          const SizedBox(height: 6),
                          TextField(
                            controller: locCtrl,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Save button
                ButtonWidget(
                  content: 'Save Unit to Fleet',
                  variant: 'primary',
                  size: 'large',
                  fullWidth: true,
                  onTap: () {
                    final newId = 'UNIT-${_fleetAssets.length + 101}';
                    final newAsset = PlantAsset(
                      id: newId,
                      name: nameCtrl.text.trim(),
                      productModel: baseProduct,
                      category: selectedCategory,
                      manufacturer: 'OEM Industrial Certified',
                      serialNumber: serialCtrl.text.trim(),
                      location: locCtrl.text.trim(),
                      installDate: 'Aug 2026',
                      lastService: 'Initial Commissioning',
                      status: 'Active',
                      statusColor: const Color(0xFF10B981),
                      healthScore: 100,
                      telemetry: const AssetTelemetry(
                        loadPercent: 50.0,
                        temperatureC: 65.0,
                        vibrationMmS: 0.8,
                        pressureBar: 5.0,
                        operatingHours: 12,
                      ),
                      predictiveAlert: const PredictiveAlert(
                        title: 'OPTIMAL: Commissioning Complete',
                        component: 'Initial Break-in Cycle',
                        daysToLimit: 365,
                        description: 'Brand new asset operating within prime factory tolerances.',
                        recommendedAction: 'Schedule 100h initial oil analysis.',
                        severity: 'OPTIMAL',
                        severityColor: Color(0xFF10B981),
                      ),
                      defaultSymptom: 'Routine Telemetry Sync on ${nameCtrl.text.trim()}',
                      commonParts: ['Break-in Oil Filter', 'Service Kit A'],
                    );

                    setState(() {
                      _fleetAssets.add(newAsset);
                      _selectedAssetId = newId;
                    });

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xFF065F46),
                        content: Row(
                          children: [
                            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Unit registered! Added ${newAsset.name} to active fleet.',
                                style: GoogleFonts.inter(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TAB 1: ASSETS / FLEET MANAGEMENT VIEW
  Widget _buildAssetsView() {
    final activeCount = _fleetAssets.where((a) => a.status == 'Active' || a.status == 'Running').length;
    final alertCount = _fleetAssets.where((a) => a.status == 'Maintenance' || a.status == 'Warning').length;
    final avgHealth = (_fleetAssets.map((a) => a.healthScore).reduce((a, b) => a + b) / _fleetAssets.length).round();

    final filtered = _filteredAssets;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Plant Fleet Management',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                  Text(
                    'Peenya Industrial Area • Stage 2 Grid',
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: _showAddAssetModal,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: FlutterFlowTheme.of(context).primary.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add_rounded, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        'Add / Clone',
                        style: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.bold,
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
          const SizedBox(height: 14),

          // Live Search Bar
          Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: FlutterFlowTheme.of(context).alternate,
              ),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
              style: GoogleFonts.roboto(
                fontSize: 13,
                color: FlutterFlowTheme.of(context).primaryText,
              ),
              decoration: InputDecoration(
                hintText: 'Search units, product models, serials, or bays...',
                hintStyle: GoogleFonts.roboto(
                  fontSize: 12,
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 20,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Fleet KPI Cards
          Row(
            children: [
              Expanded(
                child: _buildFleetStatCard(
                    'TOTAL', '${_fleetAssets.length} Units', FlutterFlowTheme.of(context).primary),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildFleetStatCard(
                    'ACTIVE', '$activeCount Units', const Color(0xFF10B981)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildFleetStatCard(
                    'HEALTH', '$avgHealth% Avg', const Color(0xFF3B82F6)),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Category Filter Pills
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterPill('All'),
                const SizedBox(width: 8),
                _buildFilterPill('Generators'),
                const SizedBox(width: 8),
                _buildFilterPill('Compressors'),
                const SizedBox(width: 8),
                _buildFilterPill('HVAC'),
                const SizedBox(width: 8),
                _buildFilterPill('Boilers'),
                const SizedBox(width: 8),
                _buildFilterPill('Robotics'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Fleet Asset Cards List
          if (filtered.isEmpty) ...[
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: FlutterFlowTheme.of(context).alternate),
              ),
              child: Column(
                children: [
                  Icon(Icons.search_off_rounded,
                      size: 40, color: FlutterFlowTheme.of(context).secondaryText),
                  const SizedBox(height: 12),
                  Text(
                    'No assets matching "$_searchQuery"',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Try changing search filters or register a new unit.',
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ...filtered.map((asset) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildFleetCard(asset),
                )),
          ],
        ],
      ),
    );
  }

  Widget _buildFleetStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: FlutterFlowTheme.of(context).alternate),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: FlutterFlowTheme.of(context).secondaryText,
            ),
          ),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterPill(String category) {
    bool isSelected = _selectedAssetFilter == category ||
        (_selectedAssetFilter == 'Power Gen' && category == 'Generators');
    return InkWell(
      onTap: () {
        setState(() => _selectedAssetFilter = category);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? FlutterFlowTheme.of(context).primary
              : FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? FlutterFlowTheme.of(context).primary
                : FlutterFlowTheme.of(context).alternate,
          ),
        ),
        child: Text(
          category,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected
                ? Colors.white
                : FlutterFlowTheme.of(context).secondaryText,
          ),
        ),
      ),
    );
  }

  Widget _buildFleetCard(PlantAsset asset) {
    final isSelected = _selectedAssetId == asset.id;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedAssetId = asset.id;
          _currentNavIndex = 0; // Switch to home dashboard for this asset
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? FlutterFlowTheme.of(context).primary
                : FlutterFlowTheme.of(context).alternate,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: FlutterFlowTheme.of(context).primary.withOpacity(0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: asset.statusColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          asset.category == 'Generators'
                              ? Icons.power_rounded
                              : (asset.category == 'Compressors'
                                  ? Icons.air_rounded
                                  : (asset.category == 'HVAC'
                                      ? Icons.ac_unit_rounded
                                      : (asset.category == 'Boilers'
                                          ? Icons.local_fire_department_rounded
                                          : Icons.smart_toy_rounded))),
                          color: asset.statusColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              asset.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            Text(
                              asset.productModel,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                fontSize: 11,
                                color: FlutterFlowTheme.of(context).secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${asset.healthScore}% HP',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: asset.statusColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: asset.statusColor.withOpacity(0.3)),
                      ),
                      child: Text(
                        asset.status,
                        style: GoogleFonts.spaceGrotesk(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: asset.statusColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.place_rounded,
                          size: 13,
                          color: FlutterFlowTheme.of(context).secondaryText),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          asset.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                              fontSize: 11,
                              color: FlutterFlowTheme.of(context).secondaryText),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.speed_rounded,
                        size: 13,
                        color: FlutterFlowTheme.of(context).primary),
                    const SizedBox(width: 4),
                    Text(
                      'Load ${asset.telemetry.loadPercent.toInt()}% • ${asset.telemetry.temperatureC.toStringAsFixed(0)}°C • ${asset.telemetry.operatingHours}h',
                      style: GoogleFonts.spaceGrotesk(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: FlutterFlowTheme.of(context).primaryText),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // LIST OF ENRICHED HISTORICAL SERVICE & AUDIT RECORDS
  List<IssueHistoryRecord> get _historyRecords => const [
        IssueHistoryRecord(
          ticketId: 'TICK-8842',
          title: 'Hose Clamp Replacement & Torque Spec',
          assetId: 'ABC123',
          date: 'Feb 04, 2026',
          category: 'Repairs',
          symptom: 'ERR-704 Coolant Overheat (98°C spike after 10m under 80% load)',
          rootCause:
              'Elastomeric fatigue at lower radiator hose clamp junction caused by cyclic engine vibration at 1500 RPM.',
          resolvedBy: 'Ravi Kumar',
          resolverRole: 'Field Technician',
          resolverAvatarText: 'RK',
          roleColor: Color(0xFFD97706),
          roleIcon: Icons.build_rounded,
          resolutionSteps: [
            'Isolated engine thermal jacket & verified block temp cooled to <60°C.',
            'Replaced OEM Kit #HC-500 (silicone elastomeric seal + 316-SS constant-tension band).',
            'Torqued clamp bolt to exact 28 Nm spec with digital calibrated driver.',
            'Replenished 5.0L Fleetguard Ethylene Glycol premix.',
            'Executed 15-min 100% load test (500 kW); verified temp stabilized at 84°C without leakage.',
          ],
          partsUsed: ['OEM Clamp Kit #HC-500', 'Coolant Premix 5.0L'],
          mttrDuration: '38 mins',
          finalTelemetryVerification:
              'Coolant temp steady 84°C at 500 kW load, expansion pressure 1.05 bar.',
          totalCompanyDataContribution: 88,
          freshworksContribution: 38,
          oemManualContribution: 28,
          aiReasoningContribution: 22,
          humanOperatorContribution: 12,
          citations: [
            CompanyDataSourceCitation(
              sourceName: 'Freshworks MCP Ticket History',
              documentReference: 'TICK-7201 & TICK-7550',
              insightProvided:
                  'Matched 2 prior thermal alert tickets in Q3 2025; cited Tech Ravi\'s previous clamp inspection note.',
              icon: Icons.history_edu_rounded,
            ),
            CompanyDataSourceCitation(
              sourceName: 'Cummins QSK19 OEM Manual',
              documentReference: 'Section §4.2 Cooling Circuit',
              insightProvided:
                  'Provided exact 28 Nm torque rating and silicone elastomeric clamp part ID #HC-500.',
              icon: Icons.menu_book_rounded,
            ),
            CompanyDataSourceCitation(
              sourceName: 'Multimodal AI Vision Reasoner',
              documentReference: 'Neural Vision Packet v3.2',
              insightProvided:
                  'Detected fluid seepage pattern at bottom fitting; computed 89% cooling restriction probability.',
              icon: Icons.auto_awesome_rounded,
            ),
          ],
        ),
        IssueHistoryRecord(
          ticketId: 'TICK-8719',
          title: 'Manifold Air Lock Bleed & Thermal Recovery',
          assetId: 'ABC123',
          date: 'Jan 22, 2026',
          category: 'Repairs',
          symptom:
              'Rapid temperature ascent to 95°C without visible external fluid loss',
          rootCause:
              'Entrapped air pocket in upper radiator manifold after routine coolant topping, causing thermal stagnation.',
          resolvedBy: 'Arun Kumar',
          resolverRole: 'Customer Self-Resolved',
          resolverAvatarText: 'AK',
          roleColor: Color(0xFF10B981),
          roleIcon: Icons.verified_user_rounded,
          resolutionSteps: [
            'Operator initiated AI voice troubleshooting call with Apex-7 agent.',
            'AI guided operator to isolate engine to 900 RPM idle speed.',
            'Loosened brass bleeder valve #BV-2 on upper radiator manifold by 1/4 turn.',
            'Purged compressed air pocket until bubble-free coolant stream emerged.',
            'Re-torqued bleeder screw to 12 Nm; verified engine temperature dropped back to 82°C.',
          ],
          partsUsed: ['Self-Executed (No Parts Replaced)'],
          mttrDuration: '14 mins',
          finalTelemetryVerification:
              'Temperature dropped from 95°C to 82°C; SCADA flow rate 120 L/min.',
          totalCompanyDataContribution: 92,
          freshworksContribution: 30,
          oemManualContribution: 35,
          aiReasoningContribution: 27,
          humanOperatorContribution: 8,
          citations: [
            CompanyDataSourceCitation(
              sourceName: 'Cummins Standard Operating Procedure',
              documentReference: 'SOP-114 Manifold Air Bleed',
              insightProvided:
                  'Step-by-step non-invasive air purge sequence for QSK19 industrial generators.',
              icon: Icons.menu_book_rounded,
            ),
            CompanyDataSourceCitation(
              sourceName: 'Freshworks Live Telemetry Sync',
              documentReference: 'SCADA Telemetry ABC123',
              insightProvided:
                  'Real-time flow sensor validation confirming coolant circulation recovery.',
              icon: Icons.speed_rounded,
            ),
          ],
        ),
        IssueHistoryRecord(
          ticketId: 'TICK-8604',
          title: '500-Hour Scheduled Interval Service & Lube Oil Renewal',
          assetId: 'ABC123',
          date: 'Jan 15, 2026',
          category: 'Routine',
          symptom: '500-Hour Scheduled Maintenance Interval Reached',
          rootCause: 'Standard preventive maintenance lifecycle compliance.',
          resolvedBy: 'Suresh Patel',
          resolverRole: 'Plant Manager',
          resolverAvatarText: 'SP',
          roleColor: Color(0xFF3B82F6),
          roleIcon: Icons.manage_accounts_rounded,
          resolutionSteps: [
            'Approved work permit & SCADA offline maintenance mode for Bay 4.',
            'Drained 35L 15W-40 Valvoline Premium Blue heavy-duty engine oil.',
            'Replaced primary & secondary spin-on fuel filters (#FF-5776).',
            'Executed battery impedance and starter load testing (100% capacity).',
            'Authorized work completion and signed off in Freshworks Enterprise Service Desk.',
          ],
          partsUsed: [
            '15W-40 Engine Oil (35L)',
            'Fleetguard Fuel Filters #FF-5776 (x2)'
          ],
          mttrDuration: '1 hr 20 mins',
          finalTelemetryVerification:
              'Oil pressure 4.2 bar at 1500 RPM; Cranking voltage 24.8V.',
          totalCompanyDataContribution: 84,
          freshworksContribution: 45,
          oemManualContribution: 25,
          aiReasoningContribution: 15,
          humanOperatorContribution: 15,
          citations: [
            CompanyDataSourceCitation(
              sourceName: 'Freshworks Enterprise Service Desk',
              documentReference: 'Work Order #WO-9932',
              insightProvided:
                  'Automated preventive maintenance schedule generated from SCADA hour-meter tracking.',
              icon: Icons.assignment_turned_in_rounded,
            ),
          ],
        ),
        IssueHistoryRecord(
          ticketId: 'TICK-8490',
          title: 'Tri-Axial Vibration Audit & Foundation Damping',
          assetId: 'ABC123',
          date: 'Dec 20, 2025',
          category: 'Inspections',
          symptom: 'Quarterly predictive acoustic & vibration baseline test',
          rootCause: 'Minor harmonic resonance on Mount #3 isolator pad.',
          resolvedBy: 'Ravi Kumar',
          resolverRole: 'Field Technician',
          resolverAvatarText: 'RK',
          roleColor: Color(0xFFD97706),
          roleIcon: Icons.analytics_rounded,
          resolutionSteps: [
            'Attached tri-axial piezoelectric accelerometers to block and stator.',
            'Recorded FFT vibration spectrum at 0%, 50%, and 100% load steps.',
            'Detected 42 Hz harmonic on Mount #3; tightened isolator anchor bolt to 110 Nm.',
            'Verified post-fix vibration level 1.1 mm/s RMS (ISO 10816-3 compliant).',
          ],
          partsUsed: ['Anti-Vibration Shim Pad #AV-30'],
          mttrDuration: '50 mins',
          finalTelemetryVerification:
              'Vibration reduced to 1.1 mm/s RMS across all 3 axes.',
          totalCompanyDataContribution: 90,
          freshworksContribution: 35,
          oemManualContribution: 30,
          aiReasoningContribution: 25,
          humanOperatorContribution: 10,
          citations: [
            CompanyDataSourceCitation(
              sourceName: 'ISO Standard Repository',
              documentReference: 'ISO 10816-3 Class II',
              insightProvided:
                  'Allowable vibration envelope thresholds for rigid foundation generators.',
              icon: Icons.verified_rounded,
            ),
          ],
        ),
        IssueHistoryRecord(
          ticketId: 'TICK-8320',
          title: 'Alternator V-Belt Tension Calibration',
          assetId: 'ABC123',
          date: 'Sept 12, 2025',
          category: 'Repairs',
          symptom: 'Auxiliary battery charge voltage dipping below 25.2V at full load',
          rootCause:
              'Alternator drive V-belt stretch (12mm deflection) after 1,200 operating hours.',
          resolvedBy: 'Arun Kumar',
          resolverRole: 'Customer Self-Resolved',
          resolverAvatarText: 'AK',
          roleColor: Color(0xFF10B981),
          roleIcon: Icons.settings_suggest_rounded,
          resolutionSteps: [
            'De-energized generator and locked out master breaker.',
            'Adjusted alternator tensioner bracket bolt to achieve 6mm deflection under 45N pressure.',
            'Cleaned pulley grooves and inspected belt teeth for micro-cracks.',
            'Restarted engine under load; verified charging voltage 27.6V DC.',
          ],
          partsUsed: ['Tension Recalibration (No Parts)'],
          mttrDuration: '22 mins',
          finalTelemetryVerification:
              'Alternator charge rate steady 27.6V DC under 500 kW load.',
          totalCompanyDataContribution: 86,
          freshworksContribution: 32,
          oemManualContribution: 38,
          aiReasoningContribution: 20,
          humanOperatorContribution: 10,
          citations: [
            CompanyDataSourceCitation(
              sourceName: 'Cummins QSK19 Service Manual',
              documentReference: 'Section §8.3 Belt Tension Specs',
              insightProvided:
                  'Exact deflection rating (6mm under 45N force) for dual V-belt alternator pulley.',
              icon: Icons.menu_book_rounded,
            ),
          ],
        ),
      ];

  // TAB 2: HISTORY / SERVICE LOG VIEW
  Widget _buildHistoryView() {
    // Filter records based on selected filter
    final records = _historyRecords.where((r) {
      if (_selectedHistoryFilter == 'All') return true;
      if (_selectedHistoryFilter == 'Field Tech') {
        return r.resolverRole == 'Field Technician';
      }
      if (_selectedHistoryFilter == 'Manager') {
        return r.resolverRole == 'Plant Manager';
      }
      if (_selectedHistoryFilter == 'Self-Resolved') {
        return r.resolverRole == 'Customer Self-Resolved';
      }
      if (_selectedHistoryFilter == 'Routine') {
        return r.category == 'Routine';
      }
      return true;
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // History Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Maintenance & Resolution History',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                    ),
                    Text(
                      'Attribution by Role & Company Knowledge Contribution',
                      style: GoogleFonts.roboto(
                        fontSize: 11,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Exported Full Resolution Dossier (PDF & Freshworks Sync).'),
                      backgroundColor: Color(0xFF1E293B),
                    ),
                  );
                },
                icon: const Icon(Icons.file_download_outlined),
                tooltip: 'Export Log',
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Fleet Knowledge Attribution Summary Card
          _buildKnowledgeOverviewCard(),
          const SizedBox(height: 16),

          // Role Filter Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildHistoryFilterPill('All (${_historyRecords.length})'),
                const SizedBox(width: 8),
                _buildHistoryFilterPill('Field Tech (2)'),
                const SizedBox(width: 8),
                _buildHistoryFilterPill('Manager (1)'),
                const SizedBox(width: 8),
                _buildHistoryFilterPill('Self-Resolved (2)'),
                const SizedBox(width: 8),
                _buildHistoryFilterPill('Routine (1)'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Chronological Resolution Timeline Cards
          ...records.map((record) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildEnrichedTimelineCard(record),
            );
          }),
        ],
      ),
    );
  }

  // FLEET KNOWLEDGE ATTRIBUTION OVERVIEW CARD
  Widget _buildKnowledgeOverviewCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
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
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.hub_rounded, color: Colors.cyanAccent, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'COMPANY DATA & AI ASSIST METRICS',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: Colors.cyanAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '88% AVG DATA ASSIST',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF34D399),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 3-Column Metrics
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TOTAL LOGS',
                        style: GoogleFonts.spaceGrotesk(
                            fontSize: 9, color: const Color(0xFF94A3B8))),
                    const SizedBox(height: 2),
                    Text('12 Resolved',
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('FIRST-TIME FIX',
                        style: GoogleFonts.spaceGrotesk(
                            fontSize: 9, color: const Color(0xFF94A3B8))),
                    const SizedBox(height: 2),
                    Text('94% FTFR',
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF60A5FA))),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AVG MTTR',
                        style: GoogleFonts.spaceGrotesk(
                            fontSize: 9, color: const Color(0xFF94A3B8))),
                    const SizedBox(height: 2),
                    Text('38 mins',
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFA78BFA))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Progress Bar Breakdown
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              height: 8,
              child: Row(
                children: [
                  Expanded(flex: 38, child: Container(color: const Color(0xFF3B82F6))),
                  Expanded(flex: 30, child: Container(color: const Color(0xFF8B5CF6))),
                  Expanded(flex: 22, child: Container(color: const Color(0xFF10B981))),
                  Expanded(flex: 10, child: Container(color: const Color(0xFFF59E0B))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Source Legend
          Wrap(
            spacing: 10,
            runSpacing: 4,
            children: [
              _buildLegendPill('Freshworks (38%)', const Color(0xFF3B82F6)),
              _buildLegendPill('OEM Specs (30%)', const Color(0xFF8B5CF6)),
              _buildLegendPill('AI Vision/Diag (22%)', const Color(0xFF10B981)),
              _buildLegendPill('Physical Action (10%)', const Color(0xFFF59E0B)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendPill(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 9,
            color: const Color(0xFFCBD5E1),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryFilterPill(String filter) {
    // Match base string for active state
    String filterKey = filter.split(' ').first;
    bool isSelected = _selectedHistoryFilter == filterKey;

    return InkWell(
      onTap: () => setState(() => _selectedHistoryFilter = filterKey),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? FlutterFlowTheme.of(context).primary
              : FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? FlutterFlowTheme.of(context).primary
                : FlutterFlowTheme.of(context).alternate,
          ),
        ),
        child: Text(
          filter,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected
                ? Colors.white
                : FlutterFlowTheme.of(context).secondaryText,
          ),
        ),
      ),
    );
  }

  // ENRICHED RESOLUTION TIMELINE CARD (CLICKABLE TO OPEN AUDIT MODAL)
  Widget _buildEnrichedTimelineCard(IssueHistoryRecord record) {
    return InkWell(
      onTap: () => _showResolutionAuditModal(record),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: FlutterFlowTheme.of(context).alternate),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Ticket ID & Role Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: record.roleColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(record.roleIcon, color: record.roleColor, size: 16),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        record.ticketId,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          '• ${record.date}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 11,
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: record.roleColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
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
              ],
            ),
            const SizedBox(height: 8),

            // Title
            Text(
              record.title,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            const SizedBox(height: 4),

            // Symptom & Root Cause
            Text(
              'Cause: ${record.rootCause}',
              style: GoogleFonts.roboto(
                fontSize: 11,
                color: FlutterFlowTheme.of(context).secondaryText,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),

            // Company Data & AI Contribution Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: FlutterFlowTheme.of(context).alternate),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.auto_awesome_rounded,
                                size: 13,
                                color: FlutterFlowTheme.of(context).primary),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                'Company Data & AI Input:',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${record.totalCompanyDataContribution}% Assisted',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF059669),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: record.totalCompanyDataContribution / 100.0,
                      minHeight: 5,
                      backgroundColor: FlutterFlowTheme.of(context).alternate,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        record.totalCompanyDataContribution > 85
                            ? const Color(0xFF10B981)
                            : FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Bottom Info: Solved By Person & Tap for Audit
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.person_outline_rounded,
                          size: 13, color: Color(0xFF64748B)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Solved by: ${record.resolvedBy}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Audit Dossier',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Icon(Icons.arrow_forward_ios_rounded,
                        size: 10, color: FlutterFlowTheme.of(context).primary),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // TAB 3: PROFILE / OPERATOR VIEW
  Widget _buildProfileView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Profile Header Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: FlutterFlowTheme.of(context).alternate),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'AK',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Arun Kumar',
                                style: GoogleFonts.inter(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(Icons.verified_rounded,
                                  color: Color(0xFF10B981), size: 16),
                            ],
                          ),
                          Text(
                            'Lead Operations Engineer • Shift A',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color:
                                  FlutterFlowTheme.of(context).secondaryText,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primary
                                  .withOpacity(0.08),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'ID: OPS-88320 • L3 Specialist',
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
                  ],
                ),
                const Divider(height: 24),
                Row(
                  children: [
                    Expanded(
                        child: _buildProfileStat(
                            'INCIDENTS', '28 Done', const Color(0xFF10B981))),
                    const SizedBox(width: 8),
                    Expanded(
                        child: _buildProfileStat(
                            'AVG RESP', '4.2m', const Color(0xFF3B82F6))),
                    const SizedBox(width: 8),
                    Expanded(
                        child: _buildProfileStat(
                            'SAFETY', '99.8%', const Color(0xFF8B5CF6))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Facility & Permissions Details
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: FlutterFlowTheme.of(context).alternate),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Plant & Facility Assignment',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
                const SizedBox(height: 12),
                _buildSpecItem(
                    'Primary Facility', 'Plant #2 • Peenya Industrial Area, Bangalore'),
                const SizedBox(height: 10),
                _buildSpecItem(
                    'Operational Zone', 'Bay 4 Heavy Machinery & Diesel Grids'),
                const SizedBox(height: 10),
                _buildSpecItem(
                    'SCADA Connection', 'Node Gateway #12 • Latency 14ms (Optimal)'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Settings & Preferences
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: FlutterFlowTheme.of(context).alternate),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Application & Diagnostics',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Offline Telemetry Cache',
                              style: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Syncs diagnostic packets when field signal is low',
                              style: GoogleFonts.roboto(
                                fontSize: 11,
                                color: FlutterFlowTheme.of(context).secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch.adaptive(
                        value: _offlineSyncEnabled,
                        activeColor: FlutterFlowTheme.of(context).primary,
                        onChanged: (val) => setState(() => _offlineSyncEnabled = val),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 16),
                InkWell(
                  onTap: _showSupportModal,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone_in_talk_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '24/7 Field Dispatch Hotline',
                                style: GoogleFonts.roboto(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '+91 80 2839 0000',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 11,
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ],
                          ),
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
              ],
            ),
          ),
          const SizedBox(height: 20),

          ButtonWidget(
            content: 'Switch Operator / Shift',
            variant: 'outline',
            size: 'medium',
            fullWidth: true,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Shift A currently active for Arun Kumar.')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String title, String val, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(title,
              style: GoogleFonts.spaceGrotesk(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: FlutterFlowTheme.of(context).secondaryText)),
          const SizedBox(height: 2),
          Text(val,
              style: GoogleFonts.inter(
                  fontSize: 13, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildTelemetryMetric(
      String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 12, color: color),
                const SizedBox(width: 3),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 9,
                        color: color,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: FlutterFlowTheme.of(context).primaryText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecItem(String title, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 11,
            color: FlutterFlowTheme.of(context).secondaryText,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: FlutterFlowTheme.of(context).primaryText,
          ),
        ),
      ],
    );
  }
}
