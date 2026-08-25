import '/components/activity_item/activity_item_widget.dart';
import '/components/bottom_nav/bottom_nav_widget.dart';
import '/components/bottom_nav_child/bottom_nav_child_widget.dart';
import '/components/button/button_widget.dart';
import '/components/history_resolution_audit/history_resolution_audit_widget.dart';
import '/components/in_call_agentic_troubleshooting/in_call_transcription_widget.dart';
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

  void _showInCallAgentModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => InCallTranscriptionWidget(
        initialSymptom: 'Generator ABC123 Coolant Overheat Tripped',
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
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.all(6),
                                child: const Icon(
                                  Icons.factory_rounded,
                                  color: Colors.white,
                                  size: 20,
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

  // TAB 0: HOME / DASHBOARD VIEW
  Widget _buildHomeView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                            _selectedAssetId == 'ABC123'
                                ? 'Generator ABC123'
                                : 'Asset $_selectedAssetId',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Cummins 500KVA • SN-78234-B • Peenya, BLR',
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
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).success10,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).success30,
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, _) => Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).success,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: FlutterFlowTheme.of(context)
                                        .success
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
                            'Active',
                            style: GoogleFonts.spaceGrotesk(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: FlutterFlowTheme.of(context).onSuccess,
                            ),
                          ),
                        ],
                      ),
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
                    _buildSpecItem('Serial Number', 'SN-78234-B'),
                    _buildSpecItem('Install Date', 'Mar 2022'),
                    _buildSpecItem('Last Service', '3 months ago'),
                    _buildSpecItem('Location', 'Peenya, BLR'),
                  ],
                ),
                const Divider(height: 22, thickness: 1),
                // Real-time Telemetry Row
                Row(
                  children: [
                    _buildTelemetryMetric(
                        'Load', '78%', Icons.bolt_rounded, const Color(0xFF3B82F6)),
                    const SizedBox(width: 8),
                    _buildTelemetryMetric('Coolant', '82°C',
                        Icons.thermostat_rounded, const Color(0xFFEF4444)),
                    const SizedBox(width: 8),
                    _buildTelemetryMetric('Vibration', '1.2 mm/s',
                        Icons.vibration_rounded, const Color(0xFF10B981)),
                    const SizedBox(width: 8),
                    _buildTelemetryMetric('Runtime', '1,847h',
                        Icons.timer_rounded, const Color(0xFF8B5CF6)),
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
            content: 'Report Issue with AI',
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

  // TAB 1: ASSETS / FLEET MANAGEMENT VIEW
  Widget _buildAssetsView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Plant Fleet Assets',
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '4 Assets',
                  style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Fleet KPI Cards
          Row(
            children: [
              Expanded(
                  child: _buildFleetStatCard(
                      'ACTIVE', '3 Units', const Color(0xFF10B981))),
              const SizedBox(width: 8),
              Expanded(
                  child: _buildFleetStatCard(
                      'MAINT', '1 Unit', const Color(0xFFEF4444))),
              const SizedBox(width: 8),
              Expanded(
                  child: _buildFleetStatCard(
                      'UPTIME', '99.1%', const Color(0xFF3B82F6))),
            ],
          ),
          const SizedBox(height: 16),

          // Category Filter Pills
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterPill('All'),
                const SizedBox(width: 8),
                _buildFilterPill('Power Gen'),
                const SizedBox(width: 8),
                _buildFilterPill('Compressors'),
                const SizedBox(width: 8),
                _buildFilterPill('HVAC'),
                const SizedBox(width: 8),
                _buildFilterPill('Boilers'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Fleet Asset Cards
          _buildFleetCard(
            id: 'ABC123',
            name: 'Generator ABC123',
            type: 'Cummins 500KVA Diesel GenSet',
            location: 'Bay 4 Heavy Power',
            status: 'Active',
            statusColor: const Color(0xFF10B981),
            metrics: 'Load 78% • 82°C • 1,847h',
            isSelected: _selectedAssetId == 'ABC123',
          ),
          const SizedBox(height: 12),
          _buildFleetCard(
            id: 'AC-10',
            name: 'Air Compressor AC-10',
            type: 'Atlas Copco Rotary Screw 75HP',
            location: 'Pneumatics Room B',
            status: 'Running',
            statusColor: const Color(0xFF3B82F6),
            metrics: '7.4 Bar • 100% Flow • 3,420h',
            isSelected: _selectedAssetId == 'AC-10',
          ),
          const SizedBox(height: 12),
          _buildFleetCard(
            id: 'CH-02',
            name: 'Chiller Unit CH-02',
            type: 'Daikin Water-Cooled 200TR',
            location: 'HVAC Chiller Plant',
            status: 'Standby',
            statusColor: const Color(0xFFF59E0B),
            metrics: '6.8°C Chilled Water • Ready',
            isSelected: _selectedAssetId == 'CH-02',
          ),
          const SizedBox(height: 12),
          _buildFleetCard(
            id: 'B-99',
            name: 'Steam Boiler B-99',
            type: 'Thermax Packaged 500kg/hr',
            location: 'Boiler House Bay 1',
            status: 'Maintenance',
            statusColor: const Color(0xFFEF4444),
            metrics: 'Pressure Sensor Alert • Scheduled',
            isSelected: _selectedAssetId == 'B-99',
          ),
        ],
      ),
    );
  }

  Widget _buildFleetStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: FlutterFlowTheme.of(context).alternate),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: GoogleFonts.spaceGrotesk(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: FlutterFlowTheme.of(context).secondaryText)),
          const SizedBox(height: 2),
          Text(value,
              style: GoogleFonts.inter(
                  fontSize: 15, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildFilterPill(String category) {
    bool isSelected = _selectedAssetFilter == category;
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

  Widget _buildFleetCard({
    required String id,
    required String name,
    required String type,
    required String location,
    required String status,
    required Color statusColor,
    required String metrics,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedAssetId = id;
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
        ),
        child: Column(
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
                        color: statusColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.memory_rounded,
                          color: statusColor, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color:
                                    FlutterFlowTheme.of(context).primaryText)),
                        Text(type,
                            style: GoogleFonts.roboto(
                                fontSize: 11,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryText)),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: statusColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: statusColor),
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.place_rounded,
                        size: 13,
                        color: FlutterFlowTheme.of(context).secondaryText),
                    const SizedBox(width: 4),
                    Text(location,
                        style: GoogleFonts.roboto(
                            fontSize: 11,
                            color: FlutterFlowTheme.of(context).secondaryText)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.speed_rounded,
                        size: 13,
                        color: FlutterFlowTheme.of(context).primary),
                    const SizedBox(width: 4),
                    Text(metrics,
                        style: GoogleFonts.spaceGrotesk(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: FlutterFlowTheme.of(context).primaryText)),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Maintenance & Resolution History',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                  Text(
                    'Attribution by Role & Company Knowledge Contribution',
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                ],
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
              Row(
                children: [
                  const Icon(Icons.hub_rounded, color: Colors.cyanAccent, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'COMPANY DATA & AI ASSIST METRICS',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Colors.cyanAccent,
                    ),
                  ),
                ],
              ),
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
                Row(
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
                    Text(
                      '• ${record.date}',
                      style: GoogleFonts.roboto(
                        fontSize: 11,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ),
                  ],
                ),
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
                      Row(
                        children: [
                          Icon(Icons.auto_awesome_rounded,
                              size: 13,
                              color: FlutterFlowTheme.of(context).primary),
                          const SizedBox(width: 4),
                          Text(
                            'Company Data & AI Input:',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                        ],
                      ),
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
                Row(
                  children: [
                    const Icon(Icons.person_outline_rounded,
                        size: 13, color: Color(0xFF64748B)),
                    const SizedBox(width: 4),
                    Text(
                      'Solved by: ${record.resolvedBy}',
                      style: GoogleFonts.roboto(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                    ),
                  ],
                ),
                Row(
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
