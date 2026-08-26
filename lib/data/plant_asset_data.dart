import 'package:flutter/material.dart';

/// Telemetry metrics for an industrial asset
class AssetTelemetry {
  final double loadPercent;
  final double temperatureC;
  final double vibrationMmS;
  final double pressureBar;
  final int operatingHours;

  const AssetTelemetry({
    required this.loadPercent,
    required this.temperatureC,
    required this.vibrationMmS,
    required this.pressureBar,
    required this.operatingHours,
  });

  AssetTelemetry copyWith({
    double? loadPercent,
    double? temperatureC,
    double? vibrationMmS,
    double? pressureBar,
    int? operatingHours,
  }) {
    return AssetTelemetry(
      loadPercent: loadPercent ?? this.loadPercent,
      temperatureC: temperatureC ?? this.temperatureC,
      vibrationMmS: vibrationMmS ?? this.vibrationMmS,
      pressureBar: pressureBar ?? this.pressureBar,
      operatingHours: operatingHours ?? this.operatingHours,
    );
  }
}

/// Predictive maintenance early warning alert
class PredictiveAlert {
  final String title;
  final String component;
  final int daysToLimit;
  final String description;
  final String recommendedAction;
  final String severity; // 'CRITICAL', 'WARNING', 'OPTIMAL'
  final Color severityColor;

  const PredictiveAlert({
    required this.title,
    required this.component,
    required this.daysToLimit,
    required this.description,
    required this.recommendedAction,
    required this.severity,
    required this.severityColor,
  });
}

/// Plant Asset data model supporting multiple units of identical products or diverse products
class PlantAsset {
  final String id;
  final String name;
  final String productModel;
  final String category; // 'Generators', 'Compressors', 'HVAC', 'Boilers', 'Robotics'
  final String manufacturer;
  final String serialNumber;
  final String location;
  final String installDate;
  final String lastService;
  final String status; // 'Active', 'Running', 'Standby', 'Maintenance', 'Warning'
  final Color statusColor;
  final int healthScore; // 0 - 100%
  final AssetTelemetry telemetry;
  final PredictiveAlert? predictiveAlert;
  final String defaultSymptom;
  final List<String> commonParts;

  const PlantAsset({
    required this.id,
    required this.name,
    required this.productModel,
    required this.category,
    required this.manufacturer,
    required this.serialNumber,
    required this.location,
    required this.installDate,
    required this.lastService,
    required this.status,
    required this.statusColor,
    required this.healthScore,
    required this.telemetry,
    this.predictiveAlert,
    required this.defaultSymptom,
    required this.commonParts,
  });

  PlantAsset copyWith({
    String? id,
    String? name,
    String? productModel,
    String? category,
    String? manufacturer,
    String? serialNumber,
    String? location,
    String? installDate,
    String? lastService,
    String? status,
    Color? statusColor,
    int? healthScore,
    AssetTelemetry? telemetry,
    PredictiveAlert? predictiveAlert,
    String? defaultSymptom,
    List<String>? commonParts,
  }) {
    return PlantAsset(
      id: id ?? this.id,
      name: name ?? this.name,
      productModel: productModel ?? this.productModel,
      category: category ?? this.category,
      manufacturer: manufacturer ?? this.manufacturer,
      serialNumber: serialNumber ?? this.serialNumber,
      location: location ?? this.location,
      installDate: installDate ?? this.installDate,
      lastService: lastService ?? this.lastService,
      status: status ?? this.status,
      statusColor: statusColor ?? this.statusColor,
      healthScore: healthScore ?? this.healthScore,
      telemetry: telemetry ?? this.telemetry,
      predictiveAlert: predictiveAlert ?? this.predictiveAlert,
      defaultSymptom: defaultSymptom ?? this.defaultSymptom,
      commonParts: commonParts ?? this.commonParts,
    );
  }
}

/// Initial Mock Repository containing multiple units of the same products and diverse product lines
class PlantAssetRepository {
  static List<PlantAsset> getInitialFleet() {
    return [
      // 1. Same Product - Unit 1 (Cummins 500KVA)
      const PlantAsset(
        id: 'ABC123',
        name: 'Generator Unit #1 (ABC123)',
        productModel: 'Cummins 500KVA Diesel GenSet',
        category: 'Generators',
        manufacturer: 'Cummins Power Systems',
        serialNumber: 'SN-78234-B',
        location: 'Bay 4 Heavy Power',
        installDate: 'Mar 2022',
        lastService: '3 months ago',
        status: 'Active',
        statusColor: Color(0xFF10B981),
        healthScore: 84,
        telemetry: AssetTelemetry(
          loadPercent: 78.0,
          temperatureC: 82.4,
          vibrationMmS: 2.1,
          pressureBar: 4.8,
          operatingHours: 1847,
        ),
        predictiveAlert: PredictiveAlert(
          title: 'PREDICTIVE: 10 Days to Failure',
          component: 'Lower Radiator Hose (HC-500)',
          daysToLimit: 10,
          description: 'Thermal oscillation detected micro-fissure expansion on clamp interface. Pre-requisition advised.',
          recommendedAction: 'Pre-requisition Hose Clamp Kit #HC-500',
          severity: 'CRITICAL',
          severityColor: Color(0xFFEF4444),
        ),
        defaultSymptom: 'ERR-704 Coolant Overheat Tripped on Generator Unit #1 (ABC123)',
        commonParts: ['Hose Clamp Kit #HC-500', 'Coolant 5L Premix', 'Thermostat Sensor TS-44'],
      ),

      // 2. Same Product - Unit 2 (Cummins 500KVA)
      const PlantAsset(
        id: 'GEN-402',
        name: 'Generator Unit #2 (GEN-402)',
        productModel: 'Cummins 500KVA Diesel GenSet',
        category: 'Generators',
        manufacturer: 'Cummins Power Systems',
        serialNumber: 'SN-78235-C',
        location: 'Bay 6 Heavy Power',
        installDate: 'Mar 2022',
        lastService: '1 month ago',
        status: 'Active',
        statusColor: Color(0xFF10B981),
        healthScore: 96,
        telemetry: AssetTelemetry(
          loadPercent: 64.5,
          temperatureC: 74.2,
          vibrationMmS: 1.4,
          pressureBar: 5.1,
          operatingHours: 1620,
        ),
        predictiveAlert: PredictiveAlert(
          title: 'OPTIMAL: Routine Telemetry Steady',
          component: 'Fuel Injector Bank A',
          daysToLimit: 180,
          description: 'Operating within normal factory vibration and combustion tolerance.',
          recommendedAction: 'Standard 2,000h filter inspection scheduled.',
          severity: 'OPTIMAL',
          severityColor: Color(0xFF10B981),
        ),
        defaultSymptom: 'Routine Health Check & Calibration on Generator Unit #2 (GEN-402)',
        commonParts: ['Primary Fuel Filter FF-102', 'Lube Oil 15W-40', 'Air Filter AF-55'],
      ),

      // 3. Same Product - Unit 3 (Cummins 500KVA)
      const PlantAsset(
        id: 'GEN-505',
        name: 'Generator Unit #3 (GEN-505)',
        productModel: 'Cummins 500KVA Diesel GenSet',
        category: 'Generators',
        manufacturer: 'Cummins Power Systems',
        serialNumber: 'SN-89104-A',
        location: 'Bay 8 Emergency Standby',
        installDate: 'Nov 2023',
        lastService: '2 weeks ago',
        status: 'Standby',
        statusColor: Color(0xFF3B82F6),
        healthScore: 98,
        telemetry: AssetTelemetry(
          loadPercent: 0.0,
          temperatureC: 38.0,
          vibrationMmS: 0.2,
          pressureBar: 5.4,
          operatingHours: 420,
        ),
        predictiveAlert: PredictiveAlert(
          title: 'STANDBY: Battery Float Voltage Steady',
          component: 'Starter Battery Array',
          daysToLimit: 240,
          description: 'Emergency auto-start ready. Weekly exercise test passed.',
          recommendedAction: 'Monthly trickle charge electrolyte check.',
          severity: 'OPTIMAL',
          severityColor: Color(0xFF3B82F6),
        ),
        defaultSymptom: 'Auto-Transfer Switch Test on Generator Unit #3 (GEN-505)',
        commonParts: ['Starter Relay SR-24V', 'Battery Terminal Cable 2AWG'],
      ),

      // 4. Same Product - Air Compressor Unit #1 (Atlas Copco)
      const PlantAsset(
        id: 'AC-10',
        name: 'Air Compressor #1 (AC-10)',
        productModel: 'Atlas Copco Rotary Screw 75HP',
        category: 'Compressors',
        manufacturer: 'Atlas Copco Industrial',
        serialNumber: 'SN-AC-9042',
        location: 'Pneumatics Room Bay B',
        installDate: 'Jan 2021',
        lastService: '4 weeks ago',
        status: 'Running',
        statusColor: Color(0xFF3B82F6),
        healthScore: 88,
        telemetry: AssetTelemetry(
          loadPercent: 82.0,
          temperatureC: 68.0,
          vibrationMmS: 1.8,
          pressureBar: 7.4,
          operatingHours: 3420,
        ),
        predictiveAlert: PredictiveAlert(
          title: 'PREDICTIVE: Air Filter Differential High',
          component: 'Intake Filtration Cartridge',
          daysToLimit: 25,
          description: 'Intake delta-P reached 35 mbar. Minor efficiency drop.',
          recommendedAction: 'Schedule intake filter replacement.',
          severity: 'WARNING',
          severityColor: Color(0xFFF59E0B),
        ),
        defaultSymptom: 'Pneumatic Line Delta-P Pressure Warning on Air Compressor #1 (AC-10)',
        commonParts: ['Air/Oil Separator 2901-0774-00', 'Rotair Plus Mineral Oil 20L'],
      ),

      // 5. Same Product - Air Compressor Unit #2 (Atlas Copco)
      const PlantAsset(
        id: 'AC-11',
        name: 'Air Compressor #2 (AC-11)',
        productModel: 'Atlas Copco Rotary Screw 75HP',
        category: 'Compressors',
        manufacturer: 'Atlas Copco Industrial',
        serialNumber: 'SN-AC-9043',
        location: 'Pneumatics Room Bay B',
        installDate: 'Jan 2021',
        lastService: '2 months ago',
        status: 'Running',
        statusColor: Color(0xFF3B82F6),
        healthScore: 91,
        telemetry: AssetTelemetry(
          loadPercent: 75.0,
          temperatureC: 66.5,
          vibrationMmS: 1.6,
          pressureBar: 7.5,
          operatingHours: 3310,
        ),
        predictiveAlert: PredictiveAlert(
          title: 'OPTIMAL: Continuous Flow Nominal',
          component: 'Screw Element Rotor',
          daysToLimit: 300,
          description: 'Discharge pressure and air purity within ISO 8573 Class 1.',
          recommendedAction: 'Routine condensate drain check.',
          severity: 'OPTIMAL',
          severityColor: Color(0xFF10B981),
        ),
        defaultSymptom: 'Condensate Auto-Drain Inspection on Compressor #2 (AC-11)',
        commonParts: ['Auto-Drain Valve Kit AD-12', 'Inline Coalescing Filter E-Grade'],
      ),

      // 6. Diverse Product - Water Chiller (Daikin)
      const PlantAsset(
        id: 'CH-02',
        name: 'Chiller Unit CH-02',
        productModel: 'Daikin Water-Cooled 200TR',
        category: 'HVAC',
        manufacturer: 'Daikin Applied',
        serialNumber: 'SN-DK-4412',
        location: 'HVAC Chiller Plant Room',
        installDate: 'Jun 2020',
        lastService: '5 months ago',
        status: 'Standby',
        statusColor: Color(0xFFF59E0B),
        healthScore: 79,
        telemetry: AssetTelemetry(
          loadPercent: 45.0,
          temperatureC: 6.8,
          vibrationMmS: 1.2,
          pressureBar: 3.2,
          operatingHours: 5120,
        ),
        predictiveAlert: PredictiveAlert(
          title: 'WARNING: Refrigerant Loop Subcooling Shift',
          component: 'Expansion Valve TXV-3',
          daysToLimit: 14,
          description: 'Subcooling dropped by 2.3°C. Potential micro-leak or valve drift.',
          recommendedAction: 'Inspect TXV actuator and leak-test condenser ports.',
          severity: 'WARNING',
          severityColor: Color(0xFFF59E0B),
        ),
        defaultSymptom: 'Chilled Water Return Temp Offset on Chiller CH-02',
        commonParts: ['R-134a Refrigerant 13.6kg', 'TXV Actuator Kit', 'Filter Drier Core'],
      ),

      // 7. Diverse Product - Steam Boiler (Thermax)
      const PlantAsset(
        id: 'B-99',
        name: 'Steam Boiler B-99',
        productModel: 'Thermax Packaged 500kg/hr',
        category: 'Boilers',
        manufacturer: 'Thermax Energy Solutions',
        serialNumber: 'SN-TH-8801',
        location: 'Boiler House Bay 1',
        installDate: 'Aug 2019',
        lastService: '6 months ago',
        status: 'Maintenance',
        statusColor: Color(0xFFEF4444),
        healthScore: 68,
        telemetry: AssetTelemetry(
          loadPercent: 30.0,
          temperatureC: 165.0,
          vibrationMmS: 3.4,
          pressureBar: 9.8,
          operatingHours: 6890,
        ),
        predictiveAlert: PredictiveAlert(
          title: 'CRITICAL: Pressure Relief Valve Recalibration Due',
          component: 'Safety Relief Valve SRV-10',
          daysToLimit: 5,
          description: 'Annual statutory boiler pressure threshold calibration mandatory.',
          recommendedAction: 'Dispatch certified boiler inspector for hydro-test.',
          severity: 'CRITICAL',
          severityColor: Color(0xFFEF4444),
        ),
        defaultSymptom: 'Burner Flame Sensor Tripping on Steam Boiler B-99',
        commonParts: ['Flame Sensor UV-99', 'Water Level Probe Electrodes', 'Blowdown Valve Gasket'],
      ),

      // 8. Diverse Product - Robotic Assembly Arm (Fanuc)
      const PlantAsset(
        id: 'ROB-07',
        name: 'Robotic Arm 6-Axis (ROB-07)',
        productModel: 'Fanuc M-20iD/35 Industrial Robot',
        category: 'Robotics',
        manufacturer: 'Fanuc Robotics',
        serialNumber: 'SN-FN-3392',
        location: 'Automated Line 3 Cell B',
        installDate: 'Feb 2023',
        lastService: '1 month ago',
        status: 'Running',
        statusColor: Color(0xFF10B981),
        healthScore: 94,
        telemetry: AssetTelemetry(
          loadPercent: 72.0,
          temperatureC: 48.2,
          vibrationMmS: 0.8,
          pressureBar: 6.0,
          operatingHours: 2190,
        ),
        predictiveAlert: PredictiveAlert(
          title: 'OPTIMAL: Joint J3 Backlash Calibrated',
          component: 'Harmonic Drive Gearbox J3',
          daysToLimit: 150,
          description: 'Repeatability accuracy at ±0.02mm, well within tolerance.',
          recommendedAction: 'Inspect cable harness flex bundle during next PM.',
          severity: 'OPTIMAL',
          severityColor: Color(0xFF10B981),
        ),
        defaultSymptom: 'J2 Axis Position Drift Notification on Robotic Arm ROB-07',
        commonParts: ['Vigo Grease RE0', 'Teach Pendant Cable 10m', 'Encoder Battery Pack'],
      ),
    ];
  }
}
