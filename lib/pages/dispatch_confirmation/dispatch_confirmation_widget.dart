import '/components/button/button_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dispatch_confirmation_model.dart';
export 'dispatch_confirmation_model.dart';

class DispatchConfirmationWidget extends StatefulWidget {
  const DispatchConfirmationWidget({super.key});

  static String routeName = 'DispatchConfirmation';
  static String routePath = '/dispatchConfirmation';

  @override
  State<DispatchConfirmationWidget> createState() =>
      _DispatchConfirmationWidgetState();
}

class _DispatchConfirmationWidgetState
    extends State<DispatchConfirmationWidget> {
  late DispatchConfirmationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DispatchConfirmationModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _showLiveTrackingModal() {
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
                    const Icon(Icons.navigation_rounded, color: Color(0xFF1A237E), size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'Live GPS Telemetry',
                      style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: FlutterFlowTheme.of(context).primaryText),
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
            Row(
              children: [
                Expanded(
                  child: _buildTelemetryCard('DISTANCE', '2.4 km', FlutterFlowTheme.of(context).primaryText),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTelemetryCard('SPEED', '38 km/h', FlutterFlowTheme.of(context).primaryText),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTelemetryCard('EST. ARRIVAL', '12 mins', FlutterFlowTheme.of(context).primary),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: FlutterFlowTheme.of(context).alternate),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('DESTINATION TARGET:', style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.bold, color: FlutterFlowTheme.of(context).secondaryText)),
                  const SizedBox(height: 4),
                  Text('Plant Bay 4, Peenya Industrial Area Stage 2, Bangalore, Karnataka 560058', style: GoogleFonts.roboto(fontSize: 12, color: FlutterFlowTheme.of(context).primaryText)),
                  const SizedBox(height: 6),
                  Text('Route: Via Outer Ring Rd · Low Traffic', style: GoogleFonts.roboto(fontSize: 11, color: Colors.green.shade700, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ButtonWidget(
              content: 'Close Live Tracker',
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

  Widget _buildTelemetryCard(String title, String val, Color valColor) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: FlutterFlowTheme.of(context).alternate),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        children: [
          Text(title, style: GoogleFonts.spaceGrotesk(fontSize: 9, fontWeight: FontWeight.bold, color: FlutterFlowTheme.of(context).secondaryText)),
          const SizedBox(height: 4),
          Text(val, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: valColor)),
        ],
      ),
    );
  }

  void _showCallTechModal() {
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
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFF1A237E),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text('RK', style: GoogleFonts.spaceGrotesk(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            const SizedBox(height: 12),
            Text('Calling Ravi Kumar...', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 4),
            Text('+91 98450 12890 · Field Specialist', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.indigoAccent)),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Text(
                'Ravi is in transit with OEM Hose Clamp kit (#HC-500) and 5L Coolant in van inventory.',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(fontSize: 12, color: Colors.white70),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.call_end, color: Colors.white),
              label: const Text('End Call', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
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
                              context.goNamed('AIAnalysisResult');
                            },
                          ),
                          Text(
                            'Dispatch Confirmation',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 8,
                            buttonSize: 38,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.more_vert_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
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
                      // Success Header
                      Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).success15,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.check_circle_rounded,
                              color: FlutterFlowTheme.of(context).success,
                              size: 36,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Technician Assigned',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Dispatch approved for Generator ABC123',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Technician Card
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
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'RK',
                                    style: GoogleFonts.spaceGrotesk(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ravi Kumar',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: FlutterFlowTheme.of(context).primaryText,
                                        ),
                                      ),
                                      Text(
                                        'Certified — Cummins 500KVA Specialist',
                                        style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 20, thickness: 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star_rounded,
                                          color: Colors.amber,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '4.8/5',
                                          style: GoogleFonts.spaceGrotesk(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: FlutterFlowTheme.of(context).primaryText,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '147 jobs',
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 11,
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '12 minutes',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                    Text(
                                      'Estimated Arrival',
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 11,
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary5,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.history_rounded,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Fixed this unit before: Hose clamp (Feb 2026)',
                                      style: GoogleFonts.roboto(
                                        fontSize: 11,
                                        color: FlutterFlowTheme.of(context).primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Diagnostic Packet
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Diagnostic Packet Summary',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).success10,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  child: Text(
                                    'Parts in Van ✓',
                                    style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.bold, color: FlutterFlowTheme.of(context).onSuccess),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary10,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.inventory_2_rounded,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Issue: Cooling restriction — hose clamp leak',
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: FlutterFlowTheme.of(context).primaryText,
                                        ),
                                      ),
                                      Text(
                                        'Parts: Hose clamp kit (#HC-500), Coolant 5L Heavy Duty',
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
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Map View Simulation
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F172A),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(
                                  Icons.map_rounded,
                                  size: 80,
                                  color: Colors.white.withOpacity(0.15),
                                ),
                              ),
                              Positioned(
                                top: 20,
                                left: 40,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                        color: Colors.blueAccent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.directions_car, color: Colors.white, size: 14),
                                    ),
                                    Text(
                                      'Ravi (Van)',
                                      style: GoogleFonts.spaceGrotesk(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                right: 40,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.factory, color: Colors.white, size: 14),
                                    ),
                                    Text(
                                      'Plant Bay 4',
                                      style: GoogleFonts.spaceGrotesk(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  color: Colors.black54,
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Peenya Industrial Area Stage 2 · 2.4 km away',
                                        style: GoogleFonts.roboto(color: Colors.white70, fontSize: 10),
                                      ),
                                      Text(
                                        'Via Outer Ring Rd',
                                        style: GoogleFonts.roboto(color: const Color(0xFF10B981), fontSize: 10, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ButtonWidget(
                        icon: const Icon(Icons.navigation_rounded, color: Colors.white, size: 18),
                        iconPresent: true,
                        content: 'Track Arrival',
                        variant: 'primary',
                        size: 'large',
                        fullWidth: true,
                        onTap: _showLiveTrackingModal,
                      ),
                      const SizedBox(height: 8),
                      ButtonWidget(
                        icon: Icon(Icons.phone_rounded, color: FlutterFlowTheme.of(context).primaryText, size: 18),
                        iconPresent: true,
                        content: 'Contact Technician (Ravi)',
                        variant: 'outline',
                        size: 'medium',
                        fullWidth: true,
                        onTap: _showCallTechModal,
                      ),
                      const SizedBox(height: 8),
                      ButtonWidget(
                        icon: Icon(Icons.home_rounded, color: FlutterFlowTheme.of(context).primaryText, size: 18),
                        iconPresent: true,
                        content: 'Return to Dashboard',
                        variant: 'ghost',
                        size: 'medium',
                        fullWidth: true,
                        onTap: () {
                          context.goNamed('AssetDashboard');
                        },
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
