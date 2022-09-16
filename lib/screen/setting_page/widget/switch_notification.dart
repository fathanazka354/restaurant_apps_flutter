import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/data/provider/preferences_provider.dart';
import 'package:restoran_app/data/provider/scheduling_provider.dart';
import 'package:restoran_app/screen/widget/custom_dialog.dart';

// ignore: must_be_immutable
class SwitchNotification extends StatelessWidget {
  PreferencesProvider provider;
  SwitchNotification({
    Key? key,
    required this.provider,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: const Text('Scheduling restaurant'),
        trailing: Consumer<SchedulingProvider>(
          builder: (context, scheduled, _) {
            return Switch.adaptive(
              value: provider.isRestaurantActive,
              onChanged: (value) async {
                if (Platform.isIOS) {
                  customDialog(context);
                } else {
                  scheduled.scheduledRestaurant(value);
                  provider.enableRestaurant(value);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
