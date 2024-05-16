class CharacterModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? image;
  String? price;

  CharacterModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.title,
      this.image,
      this.price});

  CharacterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['title'] = title;
    data['image'] = image;
    data['price'] = price;
    return data;
  }
}
