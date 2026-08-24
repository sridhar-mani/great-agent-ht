import '/components/activity_item/activity_item_widget.dart';
import '/components/bottom_nav/bottom_nav_widget.dart';
import '/components/button/button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'asset_dashboard_widget.dart' show AssetDashboardWidget;
import 'package:flutter/material.dart';

class AssetDashboardModel extends FlutterFlowModel<AssetDashboardWidget> {
  late ButtonModel buttonModel1;
  late ButtonModel buttonModel2;
  late ButtonModel buttonModel3;

  late ActivityItemModel activityItemModel1;
  late ActivityItemModel activityItemModel2;
  late ActivityItemModel activityItemModel3;

  late BottomNavModel bottomNavModel;

  @override
  void initState(BuildContext context) {
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
    buttonModel3 = createModel(context, () => ButtonModel());

    activityItemModel1 = createModel(context, () => ActivityItemModel());
    activityItemModel2 = createModel(context, () => ActivityItemModel());
    activityItemModel3 = createModel(context, () => ActivityItemModel());

    bottomNavModel = createModel(context, () => BottomNavModel());
  }

  @override
  void dispose() {
    buttonModel1.dispose();
    buttonModel2.dispose();
    buttonModel3.dispose();

    activityItemModel1.dispose();
    activityItemModel2.dispose();
    activityItemModel3.dispose();

    bottomNavModel.dispose();
  }
}
