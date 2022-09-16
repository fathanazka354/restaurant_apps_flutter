import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/component/navigation.dart';
import 'package:restoran_app/data/api/api_service.dart';
import 'package:restoran_app/data/db/database_helper.dart';
import 'package:restoran_app/data/provider/database_provider.dart';
import 'package:restoran_app/data/provider/preferences_provider.dart';
import 'package:restoran_app/data/provider/resto_detail_provider.dart';
import 'package:restoran_app/data/provider/resto_list_provider.dart';
import 'package:restoran_app/data/provider/resto_search_provider.dart';
import 'package:restoran_app/data/provider/scheduling_provider.dart';
import 'package:restoran_app/screen/detail_page/detail_restaurant_page.dart';
import 'package:restoran_app/screen/home_page/home.dart';
import 'package:restoran_app/screen/setting_page/setting_page.dart';
import 'package:restoran_app/screen/splash.dart';
import 'package:restoran_app/component/style.dart';
import 'package:restoran_app/utils/background_service.dart';
import 'package:restoran_app/utils/notification_helper.dart';
import 'package:restoran_app/utils/preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailRestaurantPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestoListProvider>(
            create: (_) => RestoListProvider(apiService: _apiService)),
        ChangeNotifierProvider<RestoSearchProvider>(
            create: (_) => RestoSearchProvider(apiService: _apiService)),
        ChangeNotifierProvider<RestoDetailProvider>(
            create: (_) => RestoDetailProvider(apiService: _apiService)),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
          child: const SettingsPage(),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
            create: (_) => PreferencesProvider(
                preferencesHelper: PreferencesHelper(
                    sharedPreferences: SharedPreferences.getInstance()))),
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()))
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            theme: provider.themeData,
            builder: (context, child) {
              return CupertinoTheme(
                  data: CupertinoThemeData(
                      brightness: provider.isDarkTheme
                          ? Brightness.dark
                          : Brightness.light),
                  child: Material(
                    child: child,
                  ));
            },
            initialRoute: SplashScreen.routeName,
            navigatorKey: navigatorKey,
            routes: {
              SplashScreen.routeName: (_) => const SplashScreen(),
              Home.routeName: (_) => const Home(),
              DetailRestaurantPage.routeName: (context) => DetailRestaurantPage(
                    restaurant:
                        ModalRoute.of(context)?.settings.arguments as String,
                  ),
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
