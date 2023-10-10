class AddedProductModel {
  int? id;
  String? title;
  String? price;
  String? description;
  String? image;
  String? category;

  AddedProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    category = json['category'];
  }
}
