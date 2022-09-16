import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restoran_app/component/navigation.dart';
import 'package:restoran_app/data/provider/preferences_provider.dart';

// ignore: must_be_immutable
class SwitchThema extends StatelessWidget {
  PreferencesProvider provider;
  SwitchThema({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: const Text('Dark Theme'),
        trailing: Switch.adaptive(
          value: provider.isDarkTheme,
          onChanged: (value) {
            defaultTargetPlatform == TargetPlatform.iOS
                ? showCupertinoDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: const Text('Coming Soon!'),
                        content:
                            const Text('This feature will be coming soon!'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigation.back();
                            },
                          ),
                        ],
                      );
                    },
                  )
                : provider.enableDarkTheme(value);
          },
        ),
      ),
    );
  }
}
