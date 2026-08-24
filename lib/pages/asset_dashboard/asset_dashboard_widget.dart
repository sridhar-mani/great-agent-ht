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

class _AssetDashboardWidgetState extends State<AssetDashboardWidget> {
  late AssetDashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AssetDashboardModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _showHistoryModal() {
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
                Text(
                  'Complete Service History (ABC123)',
                  style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: FlutterFlowTheme.of(context).primaryText),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildHistoryItem('Feb 04, 2026', 'Hose Clamp Repair', 'Agent Ravi Kumar · Resolved leak', Colors.amber),
            const Divider(height: 16),
            _buildHistoryItem('Jan 15, 2026', 'Routine Maintenance', 'Oil replenishment & filter inspection', Colors.green),
            const Divider(height: 16),
            _buildHistoryItem('Sept 12, 2025', 'Belt Replacement', 'Alternator drive tension calibration', Colors.blue),
            const Divider(height: 16),
            _buildHistoryItem('Mar 10, 2022', 'Commissioning & Install', 'Factory install at Peenya Stage 2', Colors.purple),
            const SizedBox(height: 20),
            ButtonWidget(
              content: 'Close History',
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

  Widget _buildHistoryItem(String date, String title, String sub, MaterialColor color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: FlutterFlowTheme.of(context).primaryText)),
              Text(sub, style: GoogleFonts.roboto(fontSize: 11, color: FlutterFlowTheme.of(context).secondaryText)),
            ],
          ),
        ),
        Text(date, style: GoogleFonts.spaceGrotesk(fontSize: 11, color: FlutterFlowTheme.of(context).secondaryText)),
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
            const Icon(Icons.headset_mic_rounded, color: Color(0xFF1A237E), size: 40),
            const SizedBox(height: 12),
            Text('Contact Plant Support', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: FlutterFlowTheme.of(context).primaryText)),
            const SizedBox(height: 4),
            Text('24/7 Field Dispatch & Emergency Hotline', style: GoogleFonts.roboto(fontSize: 12, color: FlutterFlowTheme.of(context).secondaryText)),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                              const SizedBox(width: 12),
                              Text(
                                'ServiceOps AI',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  FlutterFlowIconButton(
                                    borderRadius: 8,
                                    buttonSize: 38,
                                    fillColor: Colors.transparent,
                                    icon: Icon(
                                      Icons.notifications_none_rounded,
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      size: 22,
                                    ),
                                    onPressed: () {},
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primary,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'AK',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.spaceGrotesk(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 13,
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
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
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
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Generator ABC123',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: FlutterFlowTheme.of(context).primaryText,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Cummins 500KVA • SN-78234-B • Peenya, BLR',
                                      style: GoogleFonts.roboto(
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).success10,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context).success30,
                                      width: 1,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).success,
                                          shape: BoxShape.circle,
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
                            const Divider(height: 24, thickness: 1),
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
                                _buildSpecItem(context, 'Serial Number', 'SN-78234-B'),
                                _buildSpecItem(context, 'Install Date', 'Mar 2022'),
                                _buildSpecItem(context, 'Last Service', '3 months ago'),
                                _buildSpecItem(context, 'Location', 'Peenya, BLR'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ButtonWidget(
                        icon: const Icon(
                          Icons.report_problem_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        iconPresent: true,
                        content: 'Report Issue',
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
                              content: 'View History',
                              variant: 'outline',
                              size: 'medium',
                              fullWidth: true,
                              onTap: _showHistoryModal,
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
                              content: 'Contact Support',
                              variant: 'outline',
                              size: 'medium',
                              fullWidth: true,
                              onTap: _showSupportModal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
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
                            onTap: _showHistoryModal,
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
                          mainAxisSize: MainAxisSize.min,
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
                ),
              ),
              BottomNavWidget(
                child: () => const BottomNavChildWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecItem(BuildContext context, String title, String value) {
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
