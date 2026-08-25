import '/components/activity_item/activity_item_widget.dart';
import '/components/bottom_nav/bottom_nav_widget.dart';
import '/components/bottom_nav_child/bottom_nav_child_widget.dart';
import '/components/button/button_widget.dart';
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
            Text('Contact Plant Support',
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: FlutterFlowTheme.of(context).primaryText)),
            const SizedBox(height: 4),
            Text('24/7 Field Dispatch & SCADA Emergency Desk',
                style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: FlutterFlowTheme.of(context).secondaryText)),
            const SizedBox(height: 20),
            ButtonWidget(
              content: 'Call Control Desk (+91 80 2839 0000)',
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

  // TAB 2: HISTORY / SERVICE LOG VIEW
  Widget _buildHistoryView() {
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
                    'Maintenance & Audit Logs',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                  Text(
                    'Full Service Records • Generator ABC123',
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.file_download_outlined),
                tooltip: 'Export Log',
              ),
            ],
          ),
          const SizedBox(height: 16),

          // History Stats
          Row(
            children: [
              Expanded(
                  child: _buildFleetStatCard(
                      'TOTAL LOGS', '12 Done', const Color(0xFF10B981))),
              const SizedBox(width: 8),
              Expanded(
                  child: _buildFleetStatCard(
                      'SLA MET', '100%', const Color(0xFF3B82F6))),
              const SizedBox(width: 8),
              Expanded(
                  child: _buildFleetStatCard(
                      'AVG MTTR', '42 mins', const Color(0xFF8B5CF6))),
            ],
          ),
          const SizedBox(height: 16),

          // Filter Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildHistoryFilterPill('All'),
                const SizedBox(width: 8),
                _buildHistoryFilterPill('Repairs'),
                const SizedBox(width: 8),
                _buildHistoryFilterPill('Routine'),
                const SizedBox(width: 8),
                _buildHistoryFilterPill('Inspections'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Chronological Timeline Cards
          _buildTimelineCard(
            date: 'Feb 04, 2026',
            title: 'Hose Clamp Repair',
            tech: 'Ravi Kumar • L3 Specialist',
            details:
                'Fluid leak resolved at lower coolant clamp. Replaced OEM Kit #HC-500. Torque verified to 28Nm.',
            badge: 'Resolved',
            badgeColor: Colors.amber.shade700,
            icon: Icons.build_rounded,
          ),
          const SizedBox(height: 12),
          _buildTimelineCard(
            date: 'Jan 15, 2026',
            title: 'Routine Scheduled Maintenance',
            tech: 'Suresh M • Field Engineer',
            details:
                '15W-40 oil replenishment (35L), secondary fuel filter replacement, battery load test passed.',
            badge: 'Completed',
            badgeColor: Colors.green,
            icon: Icons.check_circle_rounded,
          ),
          const SizedBox(height: 12),
          _buildTimelineCard(
            date: 'Dec 20, 2025',
            title: 'Quarterly Vibration Analysis',
            tech: 'Automated SCADA Diagnostics',
            details:
                'Tri-axial vibration profile 1.1 mm/s RMS (compliant with ISO 10816-3 Class II).',
            badge: 'Audit Passed',
            badgeColor: Colors.blue,
            icon: Icons.analytics_rounded,
          ),
          const SizedBox(height: 12),
          _buildTimelineCard(
            date: 'Sept 12, 2025',
            title: 'Alternator Belt Replacement',
            tech: 'Ravi Kumar • L3 Specialist',
            details:
                'V-belt tension calibration after 1,200 operating hours. Load bank stress test executed 500kW.',
            badge: 'Completed',
            badgeColor: Colors.green,
            icon: Icons.settings_rounded,
          ),
          const SizedBox(height: 12),
          _buildTimelineCard(
            date: 'Mar 10, 2022',
            title: 'Commissioning & Installation',
            tech: 'Cummins India Field Service',
            details:
                'Factory acceptance commissioning at Peenya Stage 2 Industrial Facility Bay 4.',
            badge: 'Installed',
            badgeColor: Colors.purple,
            icon: Icons.verified_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryFilterPill(String filter) {
    bool isSelected = _selectedHistoryFilter == filter;
    return InkWell(
      onTap: () => setState(() => _selectedHistoryFilter = filter),
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

  Widget _buildTimelineCard({
    required String date,
    required String title,
    required String tech,
    required String details,
    required String badge,
    required Color badgeColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(16),
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
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: badgeColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: badgeColor, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: badgeColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            details,
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.person_outline_rounded,
                      size: 13,
                      color: FlutterFlowTheme.of(context).secondaryText),
                  const SizedBox(width: 4),
                  Text(
                    tech,
                    style: GoogleFonts.roboto(
                      fontSize: 11,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                ],
              ),
              Text(
                date,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: FlutterFlowTheme.of(context).primary,
                ),
              ),
            ],
          ),
        ],
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
