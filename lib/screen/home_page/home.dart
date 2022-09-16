import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/constant/result_state.dart';
import 'package:restoran_app/data/provider/resto_list_provider.dart';
import 'package:restoran_app/data/response/resto_list_response.dart';
import 'package:restoran_app/screen/bookmark/bookmark_page.dart';
import 'package:restoran_app/screen/home_page/widget/list_page.dart';
import 'package:restoran_app/screen/search_page/search_page.dart';
import 'package:restoran_app/screen/setting_page/setting_page.dart';

import '../../data/models/restaurant.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const String routeName = '/';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget bottomNav() {
      return BottomNavigationBar(
        elevation: 20,
        selectedItemColor: const Color.fromARGB(255, 66, 85, 152),
        currentIndex: _bottomNavIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 24,
              ),
              label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 24,
              ),
              label: 'Settings')
        ],
        onTap: ((value) => setState(() {
              _bottomNavIndex = value;
            })),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurant App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: SearchPage()),
              icon: const Icon(
                Icons.search,
              ))
        ],
      ),
      drawer: const Drawer(),
      bottomNavigationBar: bottomNav(),
      body: Consumer<RestoListProvider>(
        builder: (context, provider, _) {
          ResultState<RestoListResponse> state = provider.state;
          switch (state.status) {
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.error:
              return Center(
                child: Text(state.message!),
              );
            case Status.hasData:
              List<Restaurant> restaurants = state.data!.restaurants;
              for (int i = 0; i < 3; i++) {
                if (_bottomNavIndex == 0) {
                  return RestaurantListPage(
                    restaurants: restaurants,
                  );
                } else if (_bottomNavIndex == 1) {
                  return const BookmarksPage();
                } else {
                  return const SettingsPage();
                }
              }
              return RestaurantListPage(restaurants: restaurants);
          }
        },
      ),
    );
  }
}
