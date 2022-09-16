import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/component/navigation.dart';
import 'package:restoran_app/constant/result_state.dart';
import 'package:restoran_app/data/models/restaurant.dart';
import 'package:restoran_app/data/provider/resto_search_provider.dart';
import 'package:restoran_app/data/response/resto_search_response.dart';
import 'package:restoran_app/screen/detail_page/detail_restaurant_page.dart';

class SearchPage extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => Navigation.back(),
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    throw Exception('Data Kosong');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    RestoSearchProvider provider = Provider.of(context, listen: false);
    if (query.isNotEmpty) {
      provider.getDetail(query);
    } else {
      provider.getDetail("");
    }
    return Consumer<RestoSearchProvider>(
      builder: (context, provider, _) {
        ResultState<RestoSearchResponse> state = provider.state;
        switch (state.status) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
          case Status.error:
            return const Center(child: Text('Data Kosong'));
          case Status.hasData:
            List<Restaurant> restaurants = state.data!.restaurant;
            if (restaurants.isEmpty) {
              return const Text(
                  'Data Kosong, Silahkan Inputkan selain inputan tersebut');
            }
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                onTap: (() => Navigation.intentWithData(
                    DetailRestaurantPage.routeName, restaurants[index].id)),
                leading: SizedBox(
                  width: 80,
                  child: Hero(
                    tag: restaurants[index].pictureId,
                    child: Image.network(
                      restaurants[index].smallpictureUrl,
                    ),
                  ),
                ),
                title: RichText(
                    text: TextSpan(
                        text: restaurants[index]
                            .name
                            .substring(0, restaurants[index].name.length),
                        style: const TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold),
                        children: [
                      TextSpan(
                          text: restaurants[index]
                              .name
                              .substring(restaurants[index].name.length),
                          style: const TextStyle(color: Colors.grey))
                    ])),
                subtitle: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 18,
                    ),
                    Text(restaurants[index].rating != null
                        ? '${double.parse(restaurants[index].rating.toString())}'
                        : "Empty"),
                  ],
                ),
              ),
              itemCount: restaurants.length,
            );
        }
      },
    );
  }
}
