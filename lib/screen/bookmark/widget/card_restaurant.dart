import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/component/navigation.dart';
import 'package:restoran_app/data/models/restaurant.dart';
import 'package:restoran_app/data/provider/database_provider.dart';
import 'package:restoran_app/screen/detail_page/detail_restaurant_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(restaurant.id),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Material(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    restaurant.smallpictureUrl,
                    width: 100,
                  ),
                ),
                title: Text(
                  restaurant.name,
                ),
                subtitle: Text(restaurant.city),
                trailing: isBookmarked
                    ? IconButton(
                        icon: const Icon(Icons.bookmark),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () => provider.removeBookmark(restaurant.id),
                      )
                    : IconButton(
                        icon: const Icon(Icons.bookmark_border),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () => provider.addBookmark(restaurant),
                      ),
                onTap: () => Navigation.intentWithData(
                    DetailRestaurantPage.routeName, restaurant.id),
              ),
            );
          },
        );
      },
    );
  }
}
