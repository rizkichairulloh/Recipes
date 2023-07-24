class RecipesModel {
  bool? success;
  Data? data;

  RecipesModel({this.success, this.data});

  RecipesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Recipes>? recipes;

  Data({this.recipes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['recipes'] != null) {
      recipes = <Recipes>[];
      json['recipes'].forEach((v) {
        recipes!.add(Recipes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (recipes != null) {
      data['recipes'] = recipes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Recipes {
  String? calories;
  String? carbos;
  String? description;
  String? difficulty;
  String? fats;
  String? headline;
  String? id;
  String? image;
  String? name;
  String? proteins;
  String? thumb;
  String? time;

  Recipes(
      {this.calories,
        this.carbos,
        this.description,
        this.difficulty,
        this.fats,
        this.headline,
        this.id,
        this.image,
        this.name,
        this.proteins,
        this.thumb,
        this.time});

  Recipes.fromJson(Map<String, dynamic> json) {
    calories = json['calories'];
    carbos = json['carbos'];
    description = json['description'];
    difficulty = json['difficulty'];
    fats = json['fats'];
    headline = json['headline'];
    id = json['id'];
    image = json['image'];
    name = json['name'];
    proteins = json['proteins'];
    thumb = json['thumb'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['calories'] = calories;
    data['carbos'] = carbos;
    data['description'] = description;
    data['difficulty'] = difficulty;
    data['fats'] = fats;
    data['headline'] = headline;
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['proteins'] = proteins;
    data['thumb'] = thumb;
    data['time'] = time;
    return data;
  }
}
