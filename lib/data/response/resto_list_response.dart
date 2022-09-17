import 'package:restoran_app/data/models/restaurant.dart';

class RestoListResponse {
  List<Restaurant> restaurants;

  RestoListResponse({
    required this.restaurants,
  });

  factory RestoListResponse.fromJson(Map<String, dynamic> json) =>
      RestoListResponse(
          restaurants: List<Restaurant>.from((json['restaurants'] as List)
              .map((element) => Restaurant.fromJson(element))).toList());

  Map<String, dynamic> toJson() => {
        "restaurants": List<dynamic>.from(
            restaurants.map((restaurant) => restaurant.toJson()))
      };
}
