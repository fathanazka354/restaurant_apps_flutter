import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/data/provider/preferences_provider.dart';
import 'package:restoran_app/screen/setting_page/widget/switch_notification.dart';
import 'package:restoran_app/screen/setting_page/widget/switch_thema.dart';
import 'package:restoran_app/screen/widget/plan_widget.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  const SettingsPage({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(builder: (context, provider, child) {
      return ListView(
        children: [
          SwitchNotification(provider: provider),
          SwitchThema(provider: provider)
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlanWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
