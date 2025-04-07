class RestaurantData {
  final String nameRestaurantEng;
  final String nameRestaurantTH;
  final String description;
  final String rating;
  final String time;
  final String customer;
  final String title;
  final List<MenuData> menuData;
  final String id;
  RestaurantData(
      this.id,
      this.customer,
      this.description,
      this.menuData,
      this.nameRestaurantEng,
      this.nameRestaurantTH,
      this.rating,
      this.time,
      this.title);
  RestaurantData.fromJson(Map<String, dynamic> json)
      : nameRestaurantEng = json['nameRestaurantEng'],
        nameRestaurantTH = json['nameRestaurantTH'],
        description = json['description'],
        rating = json["rating"],
        time = json["time"],
        customer = json["customer"],
        title = json["title"],
        id = json["_id"],
        menuData = (json["menuLists"] as List)
            .map((menuJson) => MenuData.formJson(menuJson))
            .toList();
}

class MenuData {
  final String? name;
  final String? description;
  final double? price;
  final bool? addEgg;
  final String? time;
  final double? rating;
  final bool? addSize;
  MenuData({
    required this.description,
    required this.name,
    required this.price,
    required this.addEgg,
    required this.rating,
    required this.time,
    required this.addSize,
  });
  factory MenuData.formJson(Map<String, dynamic> json) {
    return MenuData(
        name: json['name'],
        addEgg: json['addEgg'],
        rating: json['rating'],
        time: json['time'],
        addSize: json['addSize'],
        description: json['description'],
        price: json['price']);
  }
}
