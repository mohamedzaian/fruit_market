import 'package:hive/hive.dart';
part  'product_model.g.dart';

@HiveType(typeId: 0)
class Productmodel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double price;
  @HiveField(2)
  final String category;
  @HiveField(3)
  final String image;
  @HiveField(4)
  bool isFavorite = false;
  @HiveField(5)
  final String details;

  Productmodel({
    required this.name,
    required this.price,
    required this.category,
    required this.image,
    required this.details,
  });
  factory Productmodel.fromJson(Map<String, dynamic> json) {
    return Productmodel(
      name: json['name'],
      price: json['price'],
      category: json['category'],
      image: json['image'],
      details: json['details'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'category': category,
      'image': image,
      'details': details
    };
  }
}
